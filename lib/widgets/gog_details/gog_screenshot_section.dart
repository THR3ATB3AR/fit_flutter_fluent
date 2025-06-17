import 'package:cached_network_image/cached_network_image.dart';
import 'package:fit_flutter_fluent/data/gog_game.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:fit_flutter_fluent/l10n/generated/app_localizations.dart';

class GogScreenshotSection extends StatefulWidget {
  final GogGame gogGames;
  const GogScreenshotSection({super.key, required this.gogGames});

  @override
  State<GogScreenshotSection> createState() => _GogScreenshotSectionState();
}

class _GogScreenshotSectionState extends State<GogScreenshotSection> {
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
    if (widget.gogGames.screenshots.isNotEmpty) {
      _selectedIndex = 0;
      if (_scrollController.hasClients) {
        _scrollController.jumpTo(0);
      }
    } else {
      _selectedIndex = -1;
    }
  }

  @override
  void didUpdateWidget(covariant GogScreenshotSection oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.gogGames.url != oldWidget.gogGames.url ||
        widget.gogGames.screenshots.length !=
            oldWidget.gogGames.screenshots.length) {
      setState(() {
        _updateSelectedIndex();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenshots = widget.gogGames.screenshots;
    final theme = FluentTheme.of(context);

    if (screenshots.isEmpty) {
      return Card(
        padding: const EdgeInsets.all(20),
        borderRadius: BorderRadius.circular(8.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                FluentIcons.photo_collection,
                size: 48,
                color: theme.inactiveColor,
              ),
              const SizedBox(height: 12),
              Text(
                AppLocalizations.of(context)!.noScreenshotsAvailable,
                style: theme.typography.bodyLarge,
              ),
            ],
          ),
        ),
      );
    }

    if (_selectedIndex >= screenshots.length || _selectedIndex < 0) {
      _selectedIndex = screenshots.isNotEmpty ? 0 : -1;
    }

    Widget placeholderWidget = Container(
      color: theme.resources.subtleFillColorTertiary,
      child: const Center(child: ProgressRing()),
    );

    Widget thumbnailErrorWidget(BuildContext c, String u, dynamic e) =>
        Container(
          color: theme.resources.subtleFillColorSecondary,
          child: Center(
            child: Icon(
              FluentIcons.photo_error,
              size: 24,
              color: theme.inactiveColor,
            ),
          ),
        );

    Widget largeImageErrorWidget(BuildContext c, String u, dynamic e) =>
        Container(
          color: theme.resources.subtleFillColorSecondary,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  FluentIcons.photo_error,
                  size: 48,
                  color: theme.inactiveColor,
                ),
                const SizedBox(height: 8),
                Text(
                  AppLocalizations.of(context)!.errorLoadingImage,
                  style: theme.typography.body?.copyWith(
                    color: theme.inactiveColor,
                  ),
                ),
              ],
            ),
          ),
        );

    return Row(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Expanded(
          flex: 1,
          child: Card(
            padding: EdgeInsets.zero,
            borderRadius: BorderRadius.circular(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                    left: 16.0,
                    top: 16.0,
                    right: 16.0,
                    bottom: 8.0,
                  ),
                  child: Text(
                    AppLocalizations.of(context)!.screenshotsTitle(screenshots.length),
                    style: theme.typography.subtitle,
                  ),
                ),
                const Divider(
                  style: DividerThemeData(
                    thickness: 1,
                    horizontalMargin: EdgeInsets.zero,
                    verticalMargin: EdgeInsets.zero,
                  ),
                ),
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
                          return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 4.0),
                            child: HoverButton(
                              onPressed: () {
                                setState(() {
                                  _selectedIndex = index;
                                });
                              },
                              builder: (context, states) {
                                return Container(
                                  decoration: BoxDecoration(
                                    border:
                                        isSelected
                                            ? Border.all(
                                              color: theme.accentColor,
                                              width: 2.5,
                                            )
                                            : Border.all(
                                              color: Colors.transparent,
                                              width: 2.5,
                                            ),
                                    borderRadius: BorderRadius.circular(6.0),
                                    color:
                                        states.isHovered
                                            ? theme
                                                .resources
                                                .subtleFillColorSecondary
                                            : Colors.transparent,
                                  ),
                                  padding: const EdgeInsets.all(2.0),
                                  child: AspectRatio(
                                    aspectRatio: 16 / 9,
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(4.0),
                                      child: CachedNetworkImage(
                                        imageUrl: screenshots[index],
                                        fit: BoxFit.cover,
                                        placeholder:
                                            (c, u) => placeholderWidget,
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
        Expanded(
          flex: 3,
          child: Card(
            borderRadius: BorderRadius.circular(8.0),
            padding: const EdgeInsets.all(16.0),
            child:
                _selectedIndex >= 0 && _selectedIndex < screenshots.length
                    ? Center(
                      child: ClipRRect(
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
                        style: theme.typography.bodyLarge?.copyWith(
                          color: theme.inactiveColor,
                        ),
                      ),
                    ),
          ),
        ),
      ],
    );
  }
}
