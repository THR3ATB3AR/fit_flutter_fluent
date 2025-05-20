import 'package:cached_network_image/cached_network_image.dart';
import 'package:fit_flutter_fluent/data/repack.dart';
import 'package:fluent_ui/fluent_ui.dart';

class ScreenshotSection extends StatefulWidget {
  final Repack repack;
  const ScreenshotSection({super.key, required this.repack});

  @override
  State<ScreenshotSection> createState() => _ScreenshotSectionState();
}

class _ScreenshotSectionState extends State<ScreenshotSection> {
  int _selectedIndex = 0;
  late ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    if (widget.repack.screenshots.isNotEmpty) {
      _selectedIndex = 0;
    } else {
      _selectedIndex = -1;
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(covariant ScreenshotSection oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.repack != oldWidget.repack ||
        widget.repack.screenshots.length !=
            oldWidget.repack.screenshots.length) {
      setState(() {
        if (widget.repack.screenshots.isNotEmpty) {
          _selectedIndex = 0;
          if (_scrollController.hasClients) {
            _scrollController.jumpTo(0);
          }
        } else {
          _selectedIndex = -1;
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenshots = widget.repack.screenshots;
    final theme = FluentTheme.of(context);

    if (screenshots.isEmpty) {
      return const Card(
        child: Center(
          child: Padding(
            padding: EdgeInsets.all(16.0),
            child: Text('No screenshots available.'),
          ),
        ),
      );
    }

    if (_selectedIndex >= screenshots.length || _selectedIndex < 0) {
      _selectedIndex = screenshots.isNotEmpty ? 0 : -1;
    }

    Widget placeholderWidget = const Center(child: ProgressRing());

    Widget thumbnailErrorWidget(
      BuildContext context,
      String url,
      dynamic error,
    ) {
      return Container(
        color: theme.resources.subtleFillColorSecondary,
        child: const Center(child: Icon(FluentIcons.error, size: 24)),
      );
    }

    Widget largeImageErrorWidget(
      BuildContext context,
      String url,
      dynamic error,
    ) {
      return Container(
        color: theme.resources.subtleFillColorSecondary,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(FluentIcons.error, size: 48),
              const SizedBox(height: 8),
              Text('Error loading image', style: theme.typography.body),
            ],
          ),
        ),
      );
    }

    return Row(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Expanded(
          flex: 1,
          child: Card(
            borderRadius: BorderRadius.circular(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 16.0, right: 16.0),
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: Text(
                    'Screenshots (${screenshots.length})',
                    style: theme.typography.subtitle,
                    ),
                  ),
                ),
                Divider(style: DividerThemeData(thickness: 2, horizontalMargin: EdgeInsets.all(0), verticalMargin: EdgeInsets.all(0))),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Scrollbar(
                      controller: _scrollController,
                      child: ListView.builder(
                        controller: _scrollController,
                        itemCount: screenshots.length,
                        itemBuilder: (context, index) {
                          final isSelected = index == _selectedIndex;
                          final borderColor =
                              theme.brightness == Brightness.light
                                  ? theme.resources.controlStrokeColorDefault
                                  : Colors.white.withValues(alpha: 0.8);
                    
                          return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 4.0),
                            child: GestureDetector(
                              onTap: () {
                                setState(() {
                                  _selectedIndex = index;
                                });
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  border:
                                      isSelected
                                          ? Border.all(
                                            color: borderColor,
                                            width: 2.5,
                                          )
                                          : null,
                                  borderRadius: BorderRadius.circular(4.0),
                                ),
                                child: AspectRatio(
                                  aspectRatio: 16 / 9,
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(6.0),
                                    child: CachedNetworkImage(
                                      imageUrl: screenshots[index],
                                      fit: BoxFit.cover,
                                      placeholder:
                                          (context, url) => placeholderWidget,
                                      errorWidget: thumbnailErrorWidget,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(width: 16.0),
        Expanded(
          flex: 2,
          child: Card(
            borderRadius: BorderRadius.circular(8.0),
            padding: const EdgeInsets.all(28.0),
            child:
                _selectedIndex >= 0 && _selectedIndex < screenshots.length
                    ? Center(
                      child: AspectRatio(
                        aspectRatio: 16 / 9,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(6.0),
                          child: CachedNetworkImage(
                            imageUrl: screenshots[_selectedIndex],
                            fit: BoxFit.contain,
                            placeholder: (context, url) => placeholderWidget,
                            errorWidget: largeImageErrorWidget,
                          ),
                        ),
                      ),
                    )
                    : const Center(child: Text('Select a screenshot to view.')),
          ),
        ),
      ],
    );
  }
}
