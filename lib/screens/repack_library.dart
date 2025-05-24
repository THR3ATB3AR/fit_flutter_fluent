import 'dart:async';
import 'package:fit_flutter_fluent/data/repack.dart';
import 'package:fit_flutter_fluent/services/repack_service.dart';
import 'package:fit_flutter_fluent/services/scraper_service.dart';
import 'package:fit_flutter_fluent/widgets/repack_item.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter/foundation.dart' show listEquals;
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:fit_flutter_fluent/theme.dart';

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
          _performFilteringAndPagination();
        } else if (_isLoadingInitial) {
          _fullRepackListFromService = List.from(
            newServiceData,
          );
          _performFilteringAndPagination();
        }
      } else {
        _fullRepackListFromService = [];
        _performFilteringAndPagination();
      }
    });

    if (_repackService.isDataLoadedInMemory) {
      _fullRepackListFromService = List.from(_repackService.everyRepack);
      if (_isLoadingInitial) {
         _performFilteringAndPagination();
      }
    } else {
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
          _fullRepackListFromService.isEmpty &&
          _repackService.everyRepack.isNotEmpty) {
        _fullRepackListFromService = List.from(_repackService.everyRepack);
      }
      _performFilteringAndPagination();
    }
  }

  void _performFilteringAndPagination() {
    if (!mounted) return;

    if (!_repackService.isDataLoadedInMemory &&
        _fullRepackListFromService.isEmpty &&
        _activeSearchQuery.isEmpty) { 
      setState(() {
        _filteredRepacksForDisplay = [];
        _paginatedRepacks = [];
      });
      return;
    }

    if (_activeSearchQuery.isEmpty) {
      _filteredRepacksForDisplay = List.from(_fullRepackListFromService);
    } else {
      _filteredRepacksForDisplay =
          _fullRepackListFromService.where((repack) {
            return repack.title.toLowerCase().contains(
              _activeSearchQuery.toLowerCase(),
            );
          }).toList();
    }

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
      _syncStatusText = "Starting library sync...";
      ScraperService.instance.loadingProgress.value = 0.0; 
    });

    try {
      _updateSyncStatusText("Fetching all repack names...");
      ScraperService.instance.loadingProgress.value = 0.0;

      final allNames = await ScraperService.instance.scrapeAllRepacksNames(
        onProgress: (current, total) {
          if (mounted) {
            _updateSyncStatusText(
              "Fetching names: $current/$total pages",
            );
            if (total > 0) {
              ScraperService.instance.loadingProgress.value = current.toDouble() / total.toDouble();
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
          "Scraping missing repack details...\nThis may take a while.",
        );
        // Reset progress for the next scraping phase
        ScraperService.instance.loadingProgress.value = 0.0;
      }

      // Assuming ScraperService.scrapeMissingRepacks internally updates
      // ScraperService.instance.loadingProgress.value.
      // If it doesn't, you would add a similar onProgress update here.
      await ScraperService.instance.scrapeMissingRepacks(
        onProgress: (current, total) {
          if (mounted) {
            _updateSyncStatusText(
              "Scraping details: $current/$total missing repacks",
            );
            // If ScraperService.scrapeMissingRepacks does NOT update loadingProgress itself:
            // if (total > 0) {
            //   ScraperService.instance.loadingProgress.value = current.toDouble() / total.toDouble();
            // } else {
            //   ScraperService.instance.loadingProgress.value = 0.0;
            // }
          }
        },
      );

      if (mounted) {
        displayInfoBar(
          context,
          builder: (context, close) {
            return InfoBar(
              title: const Text('Success'),
              content: const Text('Repack library synchronized.'),
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
              title: const Text('Error'),
              content: Text('Failed to sync library: $e'),
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
          _syncStatusText = ""; // Clear status text
        });
        ScraperService.instance.loadingProgress.value = 0.0; // Reset global progress fully at the end
        // After sync, refresh data
        _fullRepackListFromService = List.from(_repackService.everyRepack);
        _performFilteringAndPagination();
      }
    }
  }

  // _showSyncProgressDialog method is removed.

  @override
  void dispose() {
    _repackServiceSubscription?.cancel();
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final pageHeader = PageHeader(
      title: const Text('Repack Library'),
      commandBar: CommandBar(
        primaryItems: [
          CommandBarButton(
            icon: _isSyncingLibrary
                ? const SizedBox(
                    width: 16,
                    height: 16,
                    child: ProgressRing(strokeWidth: 2.0),
                  )
                : const Icon(FluentIcons.sync),
            label: const Text('Sync Library'),
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
                'Syncing Library...',
                style: FluentTheme.of(context).typography.subtitle,
              ),
              const SizedBox(height: 8),
              Text(_syncStatusText, style: FluentTheme.of(context).typography.body),
              const SizedBox(height: 16),
              ValueListenableBuilder<double>(
                valueListenable: ScraperService.instance.loadingProgress,
                builder: (context, value, child) {
                  if (value > 0 && value <= 1) {
                    return ProgressBar(value: value * 100);
                  }
                  return const ProgressRing(); // Indeterminate
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
      // 1. Initial loading state for the whole page
      if (_isLoadingInitial && _paginatedRepacks.isEmpty && !_repackService.isDataLoadedInMemory) {
        return const Expanded(child: Center(child: ProgressRing()));
      }

      // 2. "No repacks" state
      if (!_isLoadingInitial && _filteredRepacksForDisplay.isEmpty) {
        return Expanded(
          child: Center(
            child: Text(
              _activeSearchQuery.isEmpty
                  ? "No repacks found in the library."
                  : "No repacks found matching '$_activeSearchQuery'.",
              style: FluentTheme.of(context).typography.bodyLarge,
            ),
          ),
        );
      }

      // 3. GridView state
      return Expanded(
        child: LayoutBuilder(
          builder: (context, constraints) {
            final double screenWidth = constraints.maxWidth;
            int crossAxisCount;

            if (screenWidth < 600) {crossAxisCount = 4;}
            else if (screenWidth < 900) {crossAxisCount = 5;}
            else if (screenWidth < 1200) {crossAxisCount = 6;}
            else if (screenWidth < 1500) {crossAxisCount = 7;}
            else {crossAxisCount = 8;}

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
              return const Center(
                child: Text(
                  "The window is too narrow to display items correctly.\nPlease resize the window.",
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
          if (_isLoadingMore && !_isSyncingLibrary) // Show only if not syncing
            const Padding(
              padding: EdgeInsets.all(16.0),
              child: ProgressRing(),
            ),
        ],
      ),
    );
  }
}