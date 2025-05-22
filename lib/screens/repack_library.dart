import 'dart:async';
import 'package:fit_flutter_fluent/data/repack.dart';
import 'package:fit_flutter_fluent/services/repack_service.dart';
import 'package:fit_flutter_fluent/widgets/repack_item.dart'; 
import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter/foundation.dart' show listEquals;
import 'package:go_router/go_router.dart';

class RepackLibrary extends StatefulWidget {
  const RepackLibrary({super.key});

  @override
  State<RepackLibrary> createState() => _RepackLibraryState();
}

class _RepackLibraryState extends State<RepackLibrary> {
  final RepackService _repackService = RepackService.instance;
  List<Repack> _allRepacksSource = []; 
  List<Repack> _displayedRepacks = []; 
  bool _isLoadingInitial = true; 
  bool _isLoadingMore = false; 
  final ScrollController _scrollController = ScrollController();
  final int _itemsPerPage = 24; 

  StreamSubscription? _repackServiceSubscription;

  @override
  void initState() {
    super.initState();
    _repackServiceSubscription = _repackService.repacksStream.listen((_) {
      if (_repackService.isDataLoadedInMemory && mounted) {
        _initializeOrUpdateRepacksData();
      }
    });

    _loadInitialData();

    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _repackServiceSubscription?.cancel();
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }

  Future<void> _loadInitialData() async {
    if (_repackService.isDataLoadedInMemory) {
      _initializeOrUpdateRepacksData();
    } else {
      if (mounted) {
        setState(() {
          _isLoadingInitial = true;
        });
      }
    }
  }

  void _initializeOrUpdateRepacksData() {
    final newRepackData = _repackService.everyRepack;
    if (!listEquals(_allRepacksSource, newRepackData)) {
      _allRepacksSource = List.from(newRepackData); 
      _displayedRepacks = _allRepacksSource.take(_itemsPerPage).toList();
    }
    
    if (mounted) {
      setState(() {
        _isLoadingInitial = false;
      });
    }
  }

  void _onScroll() {
    if (_scrollController.position.pixels >= _scrollController.position.maxScrollExtent - 400 &&
        !_isLoadingMore &&
        _displayedRepacks.length < _allRepacksSource.length) {
      _loadMoreItems();
    }
  }

  Future<void> _loadMoreItems() async {
    if (_isLoadingMore) return; 

    if (mounted) {
      setState(() {
        _isLoadingMore = true;
      });
    }


    final currentLength = _displayedRepacks.length;
    final moreItems = _allRepacksSource.skip(currentLength).take(_itemsPerPage).toList();
    
    if (mounted) {
      setState(() {
        _displayedRepacks.addAll(moreItems);
        _isLoadingMore = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoadingInitial && _displayedRepacks.isEmpty) {
      return const ScaffoldPage(
        content: Center(child: ProgressRing()),
      );
    }

    if (_allRepacksSource.isEmpty && !_isLoadingInitial) {
      return const ScaffoldPage(
        header: PageHeader(title: Text('Repack Library')),
        content: Center(child: Text("No repacks found in the library.")),
      );
    }

    return ScaffoldPage(
      header: const PageHeader(
        title: Text('Repack Library'),
      ),
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

          final double totalHorizontalPaddingAndSpacing = (gridPadding * 2) + (gridItemSpacing * (crossAxisCount - 1));
          final double availableWidthForCards = screenWidth - totalHorizontalPaddingAndSpacing;
          final double cardWidth = availableWidthForCards / crossAxisCount;

          final double repackItemHeight = (cardWidth - cardInternalHorizontalMargin) / 0.65;

          if (repackItemHeight <= 0 || cardWidth <= cardInternalHorizontalMargin) {
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
                  itemCount: _displayedRepacks.length,
                  itemBuilder: (context, index) {
                    final repack = _displayedRepacks[index];
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