import 'package:fit_flutter_fluent/data/repack.dart';
import 'package:fit_flutter_fluent/data/repack_list_type.dart';
import 'package:fit_flutter_fluent/services/repack_service.dart';
import 'package:fit_flutter_fluent/widgets/repack_item.dart';
import 'package:fluent_ui/fluent_ui.dart';

class RepackSlider extends StatefulWidget {
  final RepackListType repackListType;
  final String title;
  final Function(Repack) onRepackTap;

  const RepackSlider({
    super.key,
    required this.repackListType,
    required this.title,
    required this.onRepackTap,
  });

  @override
  State<RepackSlider> createState() => _RepackSliderState();
}

class _RepackSliderState extends State<RepackSlider> {
  final ScrollController _scrollController = ScrollController();
  final RepackService _repackService = RepackService.instance;
  // late StreamSubscription _repackSubscription;
  // bool _dataLoaded = false;

  @override
  void initState() {
    super.initState();
    // _repackSubscription = _repackService.repacksStream.listen((_) {
    // });
    // _loadData();
  }

  @override
  void dispose() {
    // _repackSubscription.cancel();
    super.dispose();
  }

  //   Future<void> _loadData() async {
  //    if (await _repackService.checkTablesNotEmpty() && !_dataLoaded) {
  //        await _repackService.loadRepacks();
  //       _dataLoaded = true;
  //    }
  // }

  void _scrollLeft() {
    _scrollController.animateTo(
      _scrollController.offset - 400,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  void _scrollRight() {
    _scrollController.animateTo(
      _scrollController.offset + 400,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 16, left: 16, right: 16),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text(
              widget.title,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
          ),
        ),
        Expanded(
          child: StreamBuilder<void>(
            stream: _repackService.repacksStream,
            builder: (context, snapshot) {
              List<Repack> repackList;
              switch (widget.repackListType) {
                case RepackListType.newest:
                  repackList = _repackService.newRepacks;
                  break;
                case RepackListType.popular:
                  repackList = _repackService.popularRepacks;
                  break;
              }

              if (snapshot.connectionState == ConnectionState.waiting &&
                  !_repackService.isDataLoadedInMemory) {
                return const Center(child: ProgressRing());
              }
              if (repackList.isEmpty && _repackService.isDataLoadedInMemory) {
                // Data loaded, but this specific list is empty
                return Center(
                  child: Text(
                    'No ${widget.title.toLowerCase()} repacks found.',
                  ),
                );
              } else if (repackList.isEmpty &&
                  !_repackService.isDataLoadedInMemory) {
                // Still loading or failed to load
                return const Center(child: ProgressRing());
              }

              return LayoutBuilder(
                builder: (BuildContext context, BoxConstraints constraints) {
                  final double itemHeight =
                      constraints.maxHeight; // Wysokość dostępna dla ListView

                  if (itemHeight <= 0) {
                    // Zabezpieczenie przed niepoprawną wysokością
                    return const SizedBox.shrink(); // Nie renderuj nic, jeśli wysokość jest nieprawidłowa
                  }

                  return ListView.builder(
                    controller: _scrollController,
                    scrollDirection: Axis.horizontal,
                    itemCount: repackList.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        child: RepackItem(
                          repack: repackList[index],
                          itemHeight: itemHeight, // Przekaż wysokość
                        ),
                        onTap: () {
                          widget.onRepackTap(repackList[index]);
                        },
                      );
                    },
                  );
                },
              );
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(4.0),
                child: SizedBox(
                  width: 45,
                  height: 45,
                  child: IconButton(
                    onPressed: _scrollLeft,
                    icon: const Icon(FluentIcons.chevron_left_small),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(4.0),
                child: SizedBox(
                  width: 45,
                  height: 45,
                  child: IconButton(
                    onPressed: _scrollRight,
                    icon: const Icon(FluentIcons.chevron_right_small),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
