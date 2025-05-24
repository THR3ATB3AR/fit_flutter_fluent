// repack_library.dart
import 'dart:async';
import 'package:fit_flutter_fluent/data/repack.dart';
import 'package:fit_flutter_fluent/services/repack_service.dart';
import 'package:fit_flutter_fluent/widgets/repack_item.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter/foundation.dart' show listEquals;
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart'; // Import Provider
import 'package:fit_flutter_fluent/theme.dart'; // Import SearchProvider (adjust path if needed)

class RepackLibrary extends StatefulWidget {
  const RepackLibrary({super.key});

  @override
  State<RepackLibrary> createState() => _RepackLibraryState();
}

class _RepackLibraryState extends State<RepackLibrary> {
  final RepackService _repackService = RepackService.instance;

  List<Repack> _fullRepackListFromService =
      []; // Raw data from service (all repacks)
  List<Repack> _filteredRepacksForDisplay =
      []; // Data after applying search filter
  List<Repack> _paginatedRepacks =
      []; // Paginated subset of _filteredRepacksForDisplay

  bool _isLoadingInitial = true;
  bool _isLoadingMore = false;
  final ScrollController _scrollController = ScrollController();
  final int _itemsPerPage = 24; // Or your preferred number

  StreamSubscription? _repackServiceSubscription;
  String _activeSearchQuery = ''; // Local cache of the current search query

  @override
  void initState() {
    super.initState();

    // Subscribe to RepackService updates
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
          // Data same, but was initial loading, so process
          _performFilteringAndPagination();
        }
      } else {
        // Data not loaded or cleared
        _fullRepackListFromService = [];
        _performFilteringAndPagination();
      }
    });

    // Initial data load attempt
    if (_repackService.isDataLoadedInMemory) {
      _fullRepackListFromService = List.from(_repackService.everyRepack);
      // _activeSearchQuery will be picked up by didChangeDependencies
      // _performFilteringAndPagination will be called by didChangeDependencies
    } else {
      // _isLoadingInitial is already true, wait for service stream or didChangeDependencies
    }

    _scrollController.addListener(_onScroll);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // This method is called when the widget is first built and when its
    // dependencies (like SearchProvider) change.
    final newSearchQuery = Provider.of<SearchProvider>(context).searchQuery;

    // If search query changed OR it's the very first time processing (isLoadingInitial)
    if (_activeSearchQuery != newSearchQuery || _isLoadingInitial) {
      _activeSearchQuery = newSearchQuery;
      // Ensure full list is available if service has loaded it
      if (_repackService.isDataLoadedInMemory &&
          _fullRepackListFromService.isEmpty) {
        _fullRepackListFromService = List.from(_repackService.everyRepack);
      }
      _performFilteringAndPagination();
    }
  }

  void _performFilteringAndPagination() {
    if (!mounted) return;

    // If service data isn't ready and we don't have a local copy
    if (!_repackService.isDataLoadedInMemory &&
        _fullRepackListFromService.isEmpty) {
      setState(() {
        // _isLoadingInitial remains true, show loading indicator
        _filteredRepacksForDisplay = [];
        _paginatedRepacks = [];
      });
      return;
    }

    // Apply search filter
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

    // Paginate the filtered list
    _paginatedRepacks = _filteredRepacksForDisplay.take(_itemsPerPage).toList();

    bool wasInitialLoading = _isLoadingInitial;

    setState(() {
      if (wasInitialLoading) {
        _isLoadingInitial =
            false; // Data processed, initial loading phase is over
      }
      // Reset scroll position when filter changes or initial load completes
      if (_scrollController.hasClients) {
        _scrollController.jumpTo(0);
      }
    });
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
            _scrollController.position.maxScrollExtent - 400 &&
        !_isLoadingMore &&
        _paginatedRepacks.length < _filteredRepacksForDisplay.length) {
      // Compare with filtered list
      _loadMorePaginatedItems();
    }
  }

  Future<void> _loadMorePaginatedItems() async {
    if (_isLoadingMore || !mounted) return;

    setState(() => _isLoadingMore = true);

    // Simulate delay for realism if desired
    // await Future.delayed(const Duration(milliseconds: 300));

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

  @override
  void dispose() {
    _repackServiceSubscription?.cancel();
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // No need to watch SearchProvider directly in build if didChangeDependencies handles it.

    if (_isLoadingInitial && _paginatedRepacks.isEmpty) {
      return const ScaffoldPage(content: Center(child: ProgressRing()));
    }

    if (_filteredRepacksForDisplay.isEmpty && !_isLoadingInitial) {
      return ScaffoldPage(
        header: const PageHeader(title: Text('Repack Library')),
        content: Center(
          child: Text(
            _activeSearchQuery.isEmpty
                ? "No repacks found in the library."
                : "No repacks found matching '$_activeSearchQuery'.",
            style: FluentTheme.of(context).typography.bodyLarge,
          ),
        ),
      );
    }

    return ScaffoldPage(
      header: const PageHeader(title: Text('Repack Library')),
      content: LayoutBuilder(
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
            return const Center(
              child: Text(
                "The window is too narrow to display items correctly.\nPlease resize the window.",
                textAlign: TextAlign.center,
              ),
            );
          }

          final double cellAspectRatio = cardWidth / repackItemHeight;

          return Column(
            children: [
              Expanded(
                child: GridView.builder(
                  controller: _scrollController,
                  padding: const EdgeInsets.all(gridPadding),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: crossAxisCount,
                    childAspectRatio: cellAspectRatio,
                    mainAxisSpacing: gridItemSpacing,
                    crossAxisSpacing: gridItemSpacing,
                  ),
                  itemCount: _paginatedRepacks.length, // Use paginated list
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
                ),
              ),
              if (_isLoadingMore)
                const Padding(
                  padding: EdgeInsets.all(16.0),
                  child: ProgressRing(),
                ),
            ],
          );
        },
      ),
    );
  }
}
