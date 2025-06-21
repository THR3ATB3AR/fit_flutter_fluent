import 'dart:async';
import 'package:fit_flutter_fluent/data/gog_game.dart';
import 'package:fit_flutter_fluent/services/repack_service.dart';
import 'package:fit_flutter_fluent/services/scraper_service.dart';
import 'package:fit_flutter_fluent/widgets/gog_item.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter/foundation.dart' show listEquals;
import 'package:flutter/material.dart' show Badge;
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:fit_flutter_fluent/theme.dart';
import 'package:fit_flutter_fluent/l10n/generated/app_localizations.dart';

class GogLibrary extends StatefulWidget {
  const GogLibrary({super.key});

  @override
  State<GogLibrary> createState() => _GogLibraryState();
}

class _GogLibraryState extends State<GogLibrary> {
  final RepackService _repackService = RepackService.instance;
  final ScraperService _scraperService = ScraperService.instance;

  List<GogGame> _fullGogGameListFromService = [];
  List<GogGame> _filteredGogGamesForDisplay = [];
  List<GogGame> _paginatedGogGames = [];

  bool _isLoadingInitial = true;
  bool _isLoadingMore = false;
  final ScrollController _scrollController = ScrollController();
  final int _itemsPerPage = 30;

  StreamSubscription? _dataServiceSubscription;
  String _activeSearchQuery = '';

  bool _isSyncingLibrary = false;
  String _syncStatusText = "";

  final FlyoutController _genreFlyoutController = FlyoutController();
  Map<String, int> _genreCounts = {};
  final Set<String> _selectedGenres = {};

  @override
  void initState() {
    super.initState();

    _dataServiceSubscription = _repackService.repacksStream.listen((_) {
      if (!mounted) return;
      final newServiceData = _repackService.gogGames;
      bool dataChanged = !listEquals(_fullGogGameListFromService, newServiceData);

      if (_repackService.isDataLoadedInMemory) {
        if (dataChanged) {
          _fullGogGameListFromService = List.from(newServiceData);
          _calculateAndSortGenreCounts();
          _performFilteringAndPagination();
        } else if (_isLoadingInitial) {
          _fullGogGameListFromService = List.from(newServiceData);
          _calculateAndSortGenreCounts();
          _performFilteringAndPagination();
        }
      } else {
        _fullGogGameListFromService = [];
        _performFilteringAndPagination();
      }
    });

    if (_repackService.isDataLoadedInMemory) {
      _fullGogGameListFromService = List.from(_repackService.gogGames);
      _calculateAndSortGenreCounts();
      if (_isLoadingInitial) {
        _performFilteringAndPagination();
      }
    }

    _scrollController.addListener(_onScroll);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final newSearchQuery = Provider.of<SearchProvider>(context).searchQuery;

    if (_activeSearchQuery != newSearchQuery || _isLoadingInitial) {
      _activeSearchQuery = newSearchQuery;
      if (_repackService.isDataLoadedInMemory &&
          _fullGogGameListFromService.isEmpty &&
          _repackService.gogGames.isNotEmpty) {
        _fullGogGameListFromService = List.from(_repackService.gogGames);
        _calculateAndSortGenreCounts();
      }
      _performFilteringAndPagination();
    }
  }

  void _calculateAndSortGenreCounts() {
    final newGenreCounts = <String, int>{};
    for (final game in _fullGogGameListFromService) {
      // GogGame.genres is already a List<String>, which is simpler
      for (final genre in game.genres) {
        newGenreCounts.update(genre, (count) => count + 1, ifAbsent: () => 1);
      }
    }

    final sortedEntries = newGenreCounts.entries.toList()..sort((a, b) => a.key.compareTo(b.key));
    _genreCounts = Map.fromEntries(sortedEntries);
  }

  void _performFilteringAndPagination() {
    if (!mounted) return;

    List<GogGame> currentlyFilteredGames = List.from(_fullGogGameListFromService);

    if (_selectedGenres.isNotEmpty) {
      currentlyFilteredGames = currentlyFilteredGames.where((game) {
        return _selectedGenres.every((selectedGenre) => game.genres.contains(selectedGenre));
      }).toList();
    }

    if (_activeSearchQuery.isNotEmpty) {
      currentlyFilteredGames = currentlyFilteredGames.where((game) {
        return game.title.toLowerCase().contains(_activeSearchQuery.toLowerCase());
      }).toList();
    }

    _filteredGogGamesForDisplay = currentlyFilteredGames;
    _paginatedGogGames = _filteredGogGamesForDisplay.take(_itemsPerPage).toList();

    bool wasInitialLoading = _isLoadingInitial;

    setState(() {
      if (wasInitialLoading) {
        _isLoadingInitial = false;
      }
      if (_scrollController.hasClients && wasInitialLoading) {
        _scrollController.jumpTo(0);
      }
    });
  }

  void _onScroll() {
    if (_scrollController.position.pixels >= _scrollController.position.maxScrollExtent - 400 &&
        !_isLoadingMore &&
        _paginatedGogGames.length < _filteredGogGamesForDisplay.length) {
      _loadMorePaginatedItems();
    }
  }

  Future<void> _loadMorePaginatedItems() async {
    if (_isLoadingMore || !mounted) return;
    setState(() => _isLoadingMore = true);

    final currentLength = _paginatedGogGames.length;
    final moreItems = _filteredGogGamesForDisplay.skip(currentLength).take(_itemsPerPage).toList();

    if (mounted) {
      setState(() {
        _paginatedGogGames.addAll(moreItems);
        _isLoadingMore = false;
      });
    }
  }

  void _updateSyncStatusText(String newStatus) {
    if (mounted) setState(() => _syncStatusText = newStatus);
  }

  Future<void> _syncGogLibrary() async {
    if (!mounted) return;
    setState(() {
      _isSyncingLibrary = true;
      _syncStatusText = AppLocalizations.of(context)!.startingGogSync;
      _scraperService.loadingProgress.value = 0.0;
    });

    try {
      _updateSyncStatusText(AppLocalizations.of(context)!.fetchingGogGames);
      final scrapedGames = await _scraperService.scrapeGogGames(
        onProgress: (current, total) {
          if (mounted) {
            _updateSyncStatusText(
              AppLocalizations.of(context)!.fetchingGogGameDetails(current, total),
            );
            if (total > 0) {
              _scraperService.loadingProgress.value = current.toDouble() / total.toDouble();
            }
          }
        },
      );
      _repackService.gogGames = scrapedGames;
      await _repackService.saveGogGamesList();

      if (mounted) {
        displayInfoBar(
          context,
          builder: (context, close) => InfoBar(
            title: Text(AppLocalizations.of(context)!.success),
            content: Text(AppLocalizations.of(context)!.gogLibrarySynchronized),
            action: IconButton(icon: const Icon(FluentIcons.clear), onPressed: close),
            severity: InfoBarSeverity.success,
          ),
        );
      }
    } catch (e) {
      print("Error syncing GOG library: $e");
      if (mounted) {
        displayInfoBar(
          context,
          builder: (context, close) => InfoBar(
            title: Text(AppLocalizations.of(context)!.error),
            content: Text(AppLocalizations.of(context)!.failedToSyncGogLibrary(e.toString())),
            action: IconButton(icon: const Icon(FluentIcons.clear), onPressed: close),
            severity: InfoBarSeverity.error,
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() {
          _isSyncingLibrary = false;
          _syncStatusText = "";
        });
        _scraperService.loadingProgress.value = 0.0;
        // The service stream listener will handle updating the lists
      }
    }
  }

  @override
  void dispose() {
    _genreFlyoutController.dispose();
    _dataServiceSubscription?.cancel();
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final pageHeader = PageHeader(
      title: Text(AppLocalizations.of(context)!.gogLibrary),
      commandBar: CommandBar(
        mainAxisAlignment: MainAxisAlignment.end,
        primaryItems: [
          CommandBarBuilderItem(
            builder: (context, mode, w) => FlyoutTarget(controller: _genreFlyoutController, child: w),
            wrappedItem: CommandBarButton(
              icon: Badge(
                isLabelVisible: _selectedGenres.isNotEmpty,
                child: const Icon(FluentIcons.filter),
              ),
              label: Text(AppLocalizations.of(context)!.filter),
              onPressed: () => _genreFlyoutController.showFlyout(
                barrierDismissible: true,
                dismissWithEsc: true,
                builder: (context) {
                  return StatefulBuilder(
                    builder: (context, flyoutSetState) {
                      return FlyoutContent(
                        child: SizedBox(
                          width: 250,
                          height: 400,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(12.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      AppLocalizations.of(context)!.filterByGenre,
                                      style: FluentTheme.of(context).typography.subtitle,
                                    ),
                                    Button(
                                      onPressed: _selectedGenres.isEmpty
                                          ? null
                                          : () {
                                              flyoutSetState(() {
                                                setState(() {
                                                  _selectedGenres.clear();
                                                  _performFilteringAndPagination();
                                                });
                                              });
                                            },
                                      child: Text(AppLocalizations.of(context)!.clear),
                                    ),
                                  ],
                                ),
                              ),
                              const Divider(),
                              if (_genreCounts.isEmpty)
                                Expanded(
                                  child: Center(
                                    child: Text(
                                      AppLocalizations.of(context)!.noGenresAvailable,
                                      style: FluentTheme.of(context).typography.bodyLarge,
                                    ),
                                  ),
                                )
                              else
                                Expanded(
                                  child: ListView.builder(
                                    padding: const EdgeInsets.symmetric(horizontal: 4.0),
                                    itemCount: _genreCounts.length,
                                    itemBuilder: (context, index) {
                                      final genre = _genreCounts.keys.elementAt(index);
                                      final count = _genreCounts[genre]!;
                                      return Padding(
                                        padding: const EdgeInsets.only(left: 8.0, right: 8.0, top: 4.0, bottom: 4.0),
                                        child: Checkbox(
                                          content: Expanded(
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                Flexible(
                                                  child: Text(genre, overflow: TextOverflow.ellipsis),
                                                ),
                                                Text(
                                                  ' ($count)',
                                                  style: TextStyle(
                                                    color: FluentTheme.of(context).accentColor.defaultBrushFor(FluentTheme.of(context).brightness),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          checked: _selectedGenres.contains(genre),
                                          onChanged: (checked) {
                                            flyoutSetState(() {
                                              setState(() {
                                                if (checked == true) {
                                                  _selectedGenres.add(genre);
                                                } else {
                                                  _selectedGenres.remove(genre);
                                                }
                                                _performFilteringAndPagination();
                                              });
                                            });
                                          },
                                        ),
                                      );
                                    },
                                  ),
                                ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ),
          CommandBarButton(
            icon: _isSyncingLibrary
                ? const SizedBox(width: 16, height: 16, child: ProgressRing(strokeWidth: 2.0))
                : const Icon(FluentIcons.sync),
            label: Text(AppLocalizations.of(context)!.syncGogLibrary),
            onPressed: _isSyncingLibrary ? null : _syncGogLibrary,
          ),
        ],
      ),
    );

    Widget? syncProgressWidget;
    if (_isSyncingLibrary) {
      syncProgressWidget = Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        child: Card(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                AppLocalizations.of(context)!.syncingLibrary,
                style: FluentTheme.of(context).typography.subtitle,
              ),
              const SizedBox(height: 8),
              Text(_syncStatusText, style: FluentTheme.of(context).typography.body),
              const SizedBox(height: 16),
              ValueListenableBuilder<double>(
                valueListenable: _scraperService.loadingProgress,
                builder: (context, value, child) {
                  return ProgressBar(value: value * 100);
                },
              ),
            ],
          ),
        ),
      );
    }

    Widget buildMainContentArea() {
      if (_isLoadingInitial && _paginatedGogGames.isEmpty) {
        return const Expanded(child: Center(child: ProgressRing()));
      }

      if (!_isLoadingInitial && _filteredGogGamesForDisplay.isEmpty) {
        return Expanded(
          child: Center(
            child: Text(
              _activeSearchQuery.isEmpty && _selectedGenres.isEmpty
                  ? AppLocalizations.of(context)!.noGogGamesFoundInLibrary
                  : AppLocalizations.of(context)!.noGogGamesFoundMatchingSearch,
              style: FluentTheme.of(context).typography.bodyLarge,
              textAlign: TextAlign.center,
            ),
          ),
        );
      }

      return Expanded(
        child: LayoutBuilder(
          builder: (context, constraints) {
            final double screenWidth = constraints.maxWidth;
            int crossAxisCount;

            if (screenWidth < 600) {
              crossAxisCount = 4;
            } else if (screenWidth < 900) {
              crossAxisCount = 5;
            } else if (screenWidth < 1200) {
              crossAxisCount = 6;
            } else if (screenWidth < 1500) {
              crossAxisCount = 7;
            } else {
              crossAxisCount = 8;
            }

            const double cardInternalHorizontalMargin = 16.0;
            const double gridPadding = 8.0;
            const double gridItemSpacing = 0.0;

            final double totalHorizontalPaddingAndSpacing =
                (gridPadding * 2) + (gridItemSpacing * (crossAxisCount - 1));
            final double availableWidthForCards =
                screenWidth - totalHorizontalPaddingAndSpacing;
            final double cardWidth = availableWidthForCards / crossAxisCount;
            final double gogItemHeight =
                (cardWidth - cardInternalHorizontalMargin) / 0.65;

            if (gogItemHeight <= 0 ||
                cardWidth <= cardInternalHorizontalMargin) {
              return Center(
                child: Text(
                  "${AppLocalizations.of(context)!.theWindowIsTooNarrowToDisplayItemsCorrectly}\n${AppLocalizations.of(context)!.pleaseResizeTheWindow}",
                  textAlign: TextAlign.center,
                ),
              );
            }

            final double cellAspectRatio = cardWidth / gogItemHeight;

            return GridView.builder(
              controller: _scrollController,
              padding: const EdgeInsets.all(8.0),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: crossAxisCount,
                childAspectRatio: cellAspectRatio,
              ),
              itemCount: _paginatedGogGames.length,
              itemBuilder: (context, index) {
                final gogGame = _paginatedGogGames[index];
                return GestureDetector(
                  onTap: () {
                    // You can create a GogDetails page later
                    context.push("/gogdetails", extra: gogGame);
                  },
                  child: GogItem(gogGame: gogGame, itemHeight: gogItemHeight),
                );
              },
            );
          },
        ),
      );
    }

    return ScaffoldPage(
      header: pageHeader,
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          if (syncProgressWidget != null) syncProgressWidget,
          buildMainContentArea(),
          if (_isLoadingMore && !_isSyncingLibrary)
            const Padding(padding: EdgeInsets.all(16.0), child: ProgressRing()),
        ],
      ),
    );
  }
}

// Small tweak to GogItem to remove itemHeight dependency
// and let the GridView handle sizing.