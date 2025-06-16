import 'dart:async';
import 'package:fit_flutter_fluent/data/repack.dart';
import 'package:fit_flutter_fluent/services/repack_service.dart';
import 'package:fit_flutter_fluent/services/scraper_service.dart';
import 'package:fit_flutter_fluent/widgets/repack_item.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter/foundation.dart' show listEquals;
import 'package:flutter/material.dart' show Badge;
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:fit_flutter_fluent/theme.dart';
import 'package:fit_flutter_fluent/l10n/generated/app_localizations.dart';

class RepackLibrary extends StatefulWidget {
  const RepackLibrary({super.key});

  @override
  State<RepackLibrary> createState() => _RepackLibraryState();
}

class _RepackLibraryState extends State<RepackLibrary> {
  final RepackService _repackService = RepackService.instance;

  List<Repack> _fullRepackListFromService = [];
  List<Repack> _filteredRepacksForDisplay = [];
  List<Repack> _paginatedRepacks = [];

  bool _isLoadingInitial = true;
  bool _isLoadingMore = false;
  final ScrollController _scrollController = ScrollController();
  final int _itemsPerPage = 24;

  StreamSubscription? _repackServiceSubscription;
  String _activeSearchQuery = '';

  bool _isSyncingLibrary = false;
  String _syncStatusText = "";

  final FlyoutController _genreFlyoutController = FlyoutController();
  Map<String, int> _genreCounts = {};
  final Set<String> _selectedGenres = {};

  @override
  void initState() {
    super.initState();

    _repackServiceSubscription = _repackService.repacksStream.listen((_) {
      if (!mounted) return;
      final newServiceData = _repackService.everyRepack;
      bool dataChanged =
          !listEquals(_fullRepackListFromService, newServiceData);

      if (_repackService.isDataLoadedInMemory) {
        if (dataChanged) {
          _fullRepackListFromService = List.from(newServiceData);
          _calculateAndSortGenreCounts();
          _performFilteringAndPagination();
        } else if (_isLoadingInitial) {
          _fullRepackListFromService = List.from(newServiceData);
          _calculateAndSortGenreCounts();
          _performFilteringAndPagination();
        }
      } else {
        _fullRepackListFromService = [];
        _performFilteringAndPagination();
      }
    });

    if (_repackService.isDataLoadedInMemory) {
      _fullRepackListFromService = List.from(_repackService.everyRepack);
      _calculateAndSortGenreCounts();
      if (_isLoadingInitial) {
        _performFilteringAndPagination();
      }
    } else {}

    _scrollController.addListener(_onScroll);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final newSearchQuery = Provider.of<SearchProvider>(context).searchQuery;

    if (_activeSearchQuery != newSearchQuery || _isLoadingInitial) {
      _activeSearchQuery = newSearchQuery;
      if (_repackService.isDataLoadedInMemory &&
          _fullRepackListFromService.isEmpty &&
          _repackService.everyRepack.isNotEmpty) {
        _fullRepackListFromService = List.from(_repackService.everyRepack);
        _calculateAndSortGenreCounts();
      }
      _performFilteringAndPagination();
    }
  }

  void _calculateAndSortGenreCounts() {
    final newGenreCounts = <String, int>{};
    for (final repack in _fullRepackListFromService) {
      if (repack.genres.isNotEmpty) {
        final genres = repack.genres
            .split(',')
            .map((g) => g.trim())
            .where((g) => g.isNotEmpty);
        for (final genre in genres) {
          newGenreCounts.update(genre, (count) => count + 1, ifAbsent: () => 1);
        }
      }
    }

    final sortedEntries =
        newGenreCounts.entries.toList()..sort((a, b) => a.key.compareTo(b.key));

    _genreCounts = Map.fromEntries(sortedEntries);
  }

  void _performFilteringAndPagination() {
    if (!mounted) return;

    if (!_repackService.isDataLoadedInMemory &&
        _fullRepackListFromService.isEmpty &&
        _activeSearchQuery.isEmpty) {
      setState(() {
        _filteredRepacksForDisplay = [];
        _paginatedRepacks = [];
        _genreCounts = {};
        _selectedGenres.clear();
      });
      return;
    }

    List<Repack> currentlyFilteredRepacks = List.from(
      _fullRepackListFromService,
    );

    if (_selectedGenres.isNotEmpty) {
      currentlyFilteredRepacks =
          currentlyFilteredRepacks.where((repack) {
            if (repack.genres.isEmpty) return false;
            final repackGenres =
                repack.genres.split(',').map((g) => g.trim()).toSet();
            return repackGenres.containsAll(_selectedGenres);
          }).toList();
    }

    if (_activeSearchQuery.isNotEmpty) {
      currentlyFilteredRepacks =
          currentlyFilteredRepacks.where((repack) {
            return repack.title.toLowerCase().contains(
              _activeSearchQuery.toLowerCase(),
            );
          }).toList();
    }

    _filteredRepacksForDisplay = currentlyFilteredRepacks;

    _paginatedRepacks = _filteredRepacksForDisplay.take(_itemsPerPage).toList();

    bool wasInitialLoading = _isLoadingInitial;

    setState(() {
      if (wasInitialLoading &&
          (_repackService.isDataLoadedInMemory ||
              _fullRepackListFromService.isNotEmpty ||
              _activeSearchQuery.isNotEmpty)) {
        _isLoadingInitial = false;
      }
      if (_scrollController.hasClients &&
          (wasInitialLoading ||
              _activeSearchQuery !=
                  Provider.of<SearchProvider>(
                    context,
                    listen: false,
                  ).searchQuery)) {
        _scrollController.jumpTo(0);
      }
    });
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
            _scrollController.position.maxScrollExtent - 400 &&
        !_isLoadingMore &&
        _paginatedRepacks.length < _filteredRepacksForDisplay.length) {
      _loadMorePaginatedItems();
    }
  }

  Future<void> _loadMorePaginatedItems() async {
    if (_isLoadingMore || !mounted) return;
    setState(() => _isLoadingMore = true);
    final currentLength = _paginatedRepacks.length;
    final moreItems =
        _filteredRepacksForDisplay
            .skip(currentLength)
            .take(_itemsPerPage)
            .toList();
    if (mounted) {
      setState(() {
        _paginatedRepacks.addAll(moreItems);
        _isLoadingMore = false;
      });
    }
  }

  void _updateSyncStatusText(String newStatus) {
    if (mounted) {
      setState(() {
        _syncStatusText = newStatus;
      });
    }
  }

  Future<void> _syncRepackLibrary() async {
    if (!mounted) return;
    setState(() {
      _isSyncingLibrary = true;
      _syncStatusText = AppLocalizations.of(context)!.startingLibrarySync;
      ScraperService.instance.loadingProgress.value = 0.0;
    });

    try {
      _updateSyncStatusText(
        AppLocalizations.of(context)!.fetchingAllRepackNames,
      );
      ScraperService.instance.loadingProgress.value = 0.0;

      final allNames = await ScraperService.instance.scrapeAllRepacksNames(
        onProgress: (current, total) {
          if (mounted) {
            _updateSyncStatusText(
              AppLocalizations.of(context)!.fetchingNamesPages(current, total),
            );
            if (total > 0) {
              ScraperService.instance.loadingProgress.value =
                  current.toDouble() / total.toDouble();
            } else {
              ScraperService.instance.loadingProgress.value = 0.0;
            }
          }
        },
      );
      _repackService.allRepacksNames = allNames;
      await _repackService.saveAllRepackList();

      if (mounted) {
        _updateSyncStatusText(
          "${AppLocalizations.of(context)!.scrapingMissingRepackDetails}\n${AppLocalizations.of(context)!.thisMayTakeAWhile}",
        );
        ScraperService.instance.loadingProgress.value = 0.0;
      }
      await ScraperService.instance.scrapeMissingRepacks(
        onProgress: (current, total) {
          if (mounted) {
            _updateSyncStatusText(
              AppLocalizations.of(
                context,
              )!.scrapingMissingRepackDetailsProgress(current, total),
            );
          }
        },
      );

      if (mounted) {
        displayInfoBar(
          context,
          builder: (context, close) {
            return InfoBar(
              title: Text(AppLocalizations.of(context)!.success),
              content: Text(
                AppLocalizations.of(context)!.repackLibrarySynchronized,
              ),
              action: IconButton(
                icon: const Icon(FluentIcons.clear),
                onPressed: close,
              ),
              severity: InfoBarSeverity.success,
            );
          },
        );
      }
    } catch (e) {
      print("Error syncing repack library: $e");
      if (mounted) {
        displayInfoBar(
          context,
          builder: (context, close) {
            return InfoBar(
              title: Text(AppLocalizations.of(context)!.error),
              content: Text(
                AppLocalizations.of(context)!.failedToSyncLibrary(e.toString()),
              ),
              action: IconButton(
                icon: const Icon(FluentIcons.clear),
                onPressed: close,
              ),
              severity: InfoBarSeverity.error,
            );
          },
        );
      }
    } finally {
      if (mounted) {
        setState(() {
          _isSyncingLibrary = false;
          _syncStatusText = "";
        });
        ScraperService.instance.loadingProgress.value = 0.0;
        _fullRepackListFromService = List.from(_repackService.everyRepack);
        _calculateAndSortGenreCounts();
        _performFilteringAndPagination();
      }
    }
  }

  @override
  void dispose() {
    _genreFlyoutController.dispose();
    _repackServiceSubscription?.cancel();
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final pageHeader = PageHeader(
      title: Text(AppLocalizations.of(context)!.repackLibrary),
      commandBar: CommandBar(
        mainAxisAlignment: MainAxisAlignment.end,
        primaryItems: [
          CommandBarBuilderItem(
            builder:
                (context, mode, w) =>
                    FlyoutTarget(controller: _genreFlyoutController, child: w),
            wrappedItem: CommandBarButton(
              icon: Badge(
                isLabelVisible: _selectedGenres.isNotEmpty,
                child: const Icon(FluentIcons.filter),
              ),
              label: Text(AppLocalizations.of(context)!.filter),
              onPressed:
                  () => _genreFlyoutController.showFlyout(
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
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          AppLocalizations.of(context)!.filterByGenre,
                                          style:
                                              FluentTheme.of(
                                                context,
                                              ).typography.subtitle,
                                        ),
                                        Button(
                                          onPressed:
                                              _selectedGenres.isEmpty
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
                                          style:
                                              FluentTheme.of(
                                                context,
                                              ).typography.bodyLarge,
                                        ),
                                      ),
                                    )
                                  else
                                    Expanded(
                                      child: ListView.builder(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 4.0,
                                        ),
                                        itemCount: _genreCounts.length,
                                        itemBuilder: (context, index) {
                                          final genre = _genreCounts.keys
                                              .elementAt(index);
                                          final count = _genreCounts[genre]!;
                                          return Padding(
                                            padding: const EdgeInsets.only(left: 8.0, right: 8.0, top: 4.0, bottom: 4.0),
                                            child: Checkbox(
                                              content: Expanded(
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.spaceBetween,
                                                    children: [
                                                    Text(
                                                      '${genre.length > 20 ? '${genre.substring(0, 20)}…' : genre} ',
                                                    ),
                                                    Text(
                                                      '($count)',
                                                      style: TextStyle(
                                                      color: FluentTheme.of(context).accentColor.defaultBrushFor(FluentTheme.of(context).brightness),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              checked: _selectedGenres.contains(
                                                genre,
                                              ),
                                              onChanged: (checked) {
                                                flyoutSetState(() {
                                                  setState(() {
                                                    if (checked == true) {
                                                      _selectedGenres.add(genre);
                                                    } else {
                                                      _selectedGenres.remove(
                                                        genre,
                                                      );
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
            icon:
                _isSyncingLibrary
                    ? const SizedBox(
                      width: 16,
                      height: 16,
                      child: ProgressRing(strokeWidth: 2.0),
                    )
                    : const Icon(FluentIcons.sync),
            label: Text(AppLocalizations.of(context)!.syncLibrary),
            onPressed: _isSyncingLibrary ? null : _syncRepackLibrary,
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
              Text(
                _syncStatusText,
                style: FluentTheme.of(context).typography.body,
              ),
              const SizedBox(height: 16),
              ValueListenableBuilder<double>(
                valueListenable: ScraperService.instance.loadingProgress,
                builder: (context, value, child) {
                  if (value > 0 && value <= 1) {
                    return ProgressBar(value: value * 100);
                  }
                  return const ProgressRing();
                },
              ),
              ValueListenableBuilder<double>(
                valueListenable: ScraperService.instance.loadingProgress,
                builder: (context, value, child) {
                  if (value > 0 && value <= 1) {
                    return Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Text('${(value * 100).toStringAsFixed(1)}%'),
                    );
                  }
                  return const SizedBox.shrink();
                },
              ),
            ],
          ),
        ),
      );
    }

    Widget buildMainContentArea() {
      if (_isLoadingInitial &&
          _paginatedRepacks.isEmpty &&
          !_repackService.isDataLoadedInMemory) {
        return const Expanded(child: Center(child: ProgressRing()));
      }

      if (!_isLoadingInitial && _filteredRepacksForDisplay.isEmpty) {
        return Expanded(
          child: Center(
            child: Text(
              _activeSearchQuery.isEmpty && _selectedGenres.isEmpty
                  ? AppLocalizations.of(context)!.noRepacksFoundInTheLibrary
                  : AppLocalizations.of(
                    context,
                  )!.noRepacksFoundMatchingSearch(_activeSearchQuery),
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
            final double repackItemHeight =
                (cardWidth - cardInternalHorizontalMargin) / 0.65;

            if (repackItemHeight <= 0 ||
                cardWidth <= cardInternalHorizontalMargin) {
              return Center(
                child: Text(
                  "${AppLocalizations.of(context)!.theWindowIsTooNarrowToDisplayItemsCorrectly}\n${AppLocalizations.of(context)!.pleaseResizeTheWindow}",
                  textAlign: TextAlign.center,
                ),
              );
            }

            final double cellAspectRatio = cardWidth / repackItemHeight;

            return GridView.builder(
              controller: _scrollController,
              padding: const EdgeInsets.all(gridPadding),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: crossAxisCount,
                childAspectRatio: cellAspectRatio,
                mainAxisSpacing: gridItemSpacing,
                crossAxisSpacing: gridItemSpacing,
              ),
              itemCount: _paginatedRepacks.length,
              itemBuilder: (context, index) {
                final repack = _paginatedRepacks[index];
                return GestureDetector(
                  onTap: () {
                    context.push("/repackdetails", extra: repack);
                  },
                  child: RepackItem(
                    repack: repack,
                    itemHeight: repackItemHeight,
                  ),
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
