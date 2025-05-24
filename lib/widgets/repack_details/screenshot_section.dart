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
    _updateSelectedIndex();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }
  
  void _updateSelectedIndex() {
    if (widget.repack.screenshots.isNotEmpty) {
      _selectedIndex = 0;
       if (_scrollController.hasClients) {
        _scrollController.jumpTo(0);
      }
    } else {
      _selectedIndex = -1;
    }
  }

  @override
  void didUpdateWidget(covariant ScreenshotSection oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.repack.url != oldWidget.repack.url || // Check if it's a different repack
        widget.repack.screenshots.length != oldWidget.repack.screenshots.length) {
      setState(() {
        _updateSelectedIndex();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenshots = widget.repack.screenshots;
    final theme = FluentTheme.of(context);

    if (screenshots.isEmpty) {
      return Card(
        padding: const EdgeInsets.all(20),
        borderRadius: BorderRadius.circular(8.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(FluentIcons.photo_collection, size: 48, color: theme.inactiveColor),
              const SizedBox(height: 12),
              Text('No screenshots available.', style: theme.typography.bodyLarge),
            ],
          ),
        ),
      );
    }

    // Ensure _selectedIndex is valid
    if (_selectedIndex >= screenshots.length || _selectedIndex < 0) {
      _selectedIndex = screenshots.isNotEmpty ? 0 : -1;
    }

    Widget placeholderWidget = Container(
      color: theme.resources.subtleFillColorTertiary,
      child: const Center(child: ProgressRing()),
    );

    Widget thumbnailErrorWidget(BuildContext c, String u, dynamic e) => Container(
          color: theme.resources.subtleFillColorSecondary,
          child: Center(child: Icon(FluentIcons.photo_error, size: 24, color: theme.inactiveColor)),
        );

    Widget largeImageErrorWidget(BuildContext c, String u, dynamic e) => Container(
          color: theme.resources.subtleFillColorSecondary,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(FluentIcons.photo_error, size: 48, color: theme.inactiveColor),
                const SizedBox(height: 8),
                Text('Error loading image', style: theme.typography.body?.copyWith(color: theme.inactiveColor)),
              ],
            ),
          ),
        );

    return Row(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // Thumbnails Column
        Expanded(
          flex: 1,
          child: Card(
            padding: EdgeInsets.zero, // Padding will be handled by Column
            borderRadius: BorderRadius.circular(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 16.0, top: 16.0, right: 16.0, bottom: 8.0),
                  child: Text(
                    'Screenshots (${screenshots.length})',
                    style: theme.typography.subtitle,
                  ),
                ),
                const Divider(
                  style: DividerThemeData(
                    thickness: 1, // Standard thickness
                    horizontalMargin: EdgeInsets.zero,
                    verticalMargin: EdgeInsets.zero,
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Scrollbar( // Use FluentScrollbar for consistent styling
                      controller: _scrollController,
                      child: ListView.builder(
                        controller: _scrollController,
                        itemCount: screenshots.length,
                        itemBuilder: (context, index) {
                          final isSelected = index == _selectedIndex;
                          return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 4.0),
                            child: HoverButton( // Added HoverButton for better interactivity
                              onPressed: () {
                                setState(() {
                                  _selectedIndex = index;
                                });
                              },
                              builder: (context, states) {
                                return Container(
                                  decoration: BoxDecoration(
                                    border: isSelected
                                        ? Border.all(color: theme.accentColor, width: 2.5)
                                        : Border.all(color: Colors.transparent, width: 2.5), // Keep space for border
                                    borderRadius: BorderRadius.circular(6.0),
                                    color: states.isHovering ? theme.resources.subtleFillColorSecondary : Colors.transparent,
                                  ),
                                  padding: const EdgeInsets.all(2.0), // Padding for the border effect
                                  child: AspectRatio(
                                    aspectRatio: 16 / 9,
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(4.0),
                                      child: CachedNetworkImage(
                                        imageUrl: screenshots[index],
                                        fit: BoxFit.cover,
                                        placeholder: (c, u) => placeholderWidget,
                                        errorWidget: thumbnailErrorWidget,
                                      ),
                                    ),
                                  ),
                                );
                              },
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
        // Large Image View
        Expanded(
          flex: 3, // Give more space to the main image
          child: Card(
            borderRadius: BorderRadius.circular(8.0),
            padding: const EdgeInsets.all(16.0), // Consistent padding
            child: _selectedIndex >= 0 && _selectedIndex < screenshots.length
                ? Center(
                    child: ClipRRect( // ClipRRect for rounded corners on the image itself
                      borderRadius: BorderRadius.circular(6.0),
                      child: CachedNetworkImage(
                        imageUrl: screenshots[_selectedIndex],
                        fit: BoxFit.contain,
                        placeholder: (c, u) => placeholderWidget,
                        errorWidget: largeImageErrorWidget,
                      ),
                    ),
                  )
                : Center(
                    child: Text(
                      'Select a screenshot to view.',
                      style: theme.typography.bodyLarge?.copyWith(color: theme.inactiveColor),
                    ),
                  ),
          ),
        ),
      ],
    );
  }
}