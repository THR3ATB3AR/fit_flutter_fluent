import 'package:cached_network_image/cached_network_image.dart';
import 'package:fit_flutter_fluent/data/gog_game.dart';
import 'package:fit_flutter_fluent/data/gog_download_links.dart';
import 'package:fit_flutter_fluent/services/scraper_service.dart';
import 'package:fit_flutter_fluent/widgets/fluent_chip.dart';
import 'package:fit_flutter_fluent/widgets/gog_details/gog_download_dialog.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'dart:async';
import 'package:fit_flutter_fluent/services/dd_manager.dart';
import 'package:fit_flutter_fluent/l10n/generated/app_localizations.dart';

class GogHeader extends StatefulWidget {
  final GogGame gogGame;
  const GogHeader({super.key, required this.gogGame});

  @override
  State<GogHeader> createState() => _GogHeaderState();
}

class _GogHeaderState extends State<GogHeader> {
  final ScraperService _scraperService = ScraperService.instance;
  final DdManager _ddManager = DdManager.instance;

  GogDownloadLinks? _downloadLinks;
  bool _isLoadingLinks = false;

  ValueNotifier<double>? _batchProgressNotifier;
  double _batchProgress = 0.0;
  StreamSubscription? _taskGroupUpdateSubscription;

  @override
  void initState() {
    super.initState();
    _setupProgressListener();
    _taskGroupUpdateSubscription = _ddManager.onTaskGroupUpdated.listen((
      updatedSanitizedTitle,
    ) {
      if (mounted &&
          updatedSanitizedTitle ==
              _ddManager.sanitizeFileName(widget.gogGame.title)) {
        _setupProgressListener();
      }
    });
  }

  void _setupProgressListener() {
    _batchProgressNotifier?.removeListener(_onProgressChanged);
    _batchProgressNotifier = _ddManager.getBatchProgressForTitle(
      widget.gogGame.title,
    );
    if (mounted) {
      setState(() {
        if (_batchProgressNotifier != null) {
          _batchProgress = _batchProgressNotifier!.value;
          _batchProgressNotifier!.addListener(_onProgressChanged);
        } else {
          _batchProgress = 0.0;
        }
      });
    }
  }

  void _onProgressChanged() {
    if (mounted && _batchProgressNotifier != null) {
      setState(() => _batchProgress = _batchProgressNotifier!.value);
    }
  }

  @override
  void dispose() {
    _batchProgressNotifier?.removeListener(_onProgressChanged);
    _taskGroupUpdateSubscription?.cancel();
    super.dispose();
  }

  Future<void> _fetchAndShowDownloadDialog() async {
    if (!mounted) return;
    setState(() => _isLoadingLinks = true);

    final links = await _scraperService.scrapeGogGameDownloadLinks(
      widget.gogGame.url,
    );

    if (!mounted) return;
    setState(() {
      _downloadLinks = links;
      _isLoadingLinks = false;
    });

    if (_downloadLinks != null && !_downloadLinks!.isEmpty) {
      showDialog(
        context: context,
        builder:
            (context) => GogDownloadDialog(
              gameTitle: widget.gogGame.title,
              links: _downloadLinks!,
            ),
      );
    } else {
      displayInfoBar(
        context,
        builder: (context, close) {
          return InfoBar(
            title: Text(AppLocalizations.of(context)!.error),
            content: Text(
              'AppLocalizations.of(context)!.couldNotFindDownloadLinks',
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
  }

  @override
  Widget build(BuildContext context) {
    final theme = FluentTheme.of(context);
    final typography = theme.typography;
    final localizations = AppLocalizations.of(context)!;

    return Padding(
      padding: const EdgeInsets.only(bottom: 24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.0),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 8,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8.0),
                  child: CachedNetworkImage(
                    imageUrl: widget.gogGame.cover,
                    fit: BoxFit.cover,
                    width: 120,
                    height: 120,
                    errorWidget:
                        (context, url, error) => Container(
                          width: 120,
                          height: 120,
                          color: theme.resources.subtleFillColorSecondary,
                          child: Center(
                            child: Icon(
                              FluentIcons.photo_error,
                              size: 32,
                              color: theme.inactiveColor,
                            ),
                          ),
                        ),
                    placeholder:
                        (context, url) => Container(
                          width: 120,
                          height: 120,
                          color: theme.resources.subtleFillColorTertiary,
                          child: const Center(child: ProgressRing()),
                        ),
                  ),
                ),
              ),
              const SizedBox(width: 24),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      widget.gogGame.title,
                      style: typography.titleLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                        letterSpacing: 0.5,
                      ),
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      widget.gogGame.publisher,
                      style: typography.bodyLarge?.copyWith(
                        color: theme.inactiveColor,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          if (widget.gogGame.genres.isNotEmpty)
            Wrap(
              spacing: 8.0,
              runSpacing: 8.0,
              children:
                  widget.gogGame.genres
                      .map((g) => FluentChip(label: g.trim()))
                      .toList(),
            ),
          const SizedBox(height: 24),
          SizedBox(
            width: 180,
            child: FilledButton(
              style: ButtonStyle(
                padding: WidgetStateProperty.all(
                  const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                ),
              ),
              onPressed: _isLoadingLinks ? null : _fetchAndShowDownloadDialog,
              child:
                  _isLoadingLinks
                      ? const SizedBox(
                        width: 16,
                        height: 16,
                        child: ProgressRing(),
                      )
                      : Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            FluentIcons.download,
                            size: 16,
                            color:
                                theme.brightness == Brightness.dark
                                    ? Colors.black
                                    : Colors.white,
                          ),
                          const SizedBox(width: 8),
                          Text(
                            localizations.download,
                            style: typography.bodyStrong?.copyWith(
                              color:
                                  theme.brightness == Brightness.dark
                                      ? Colors.black
                                      : Colors.white,
                            ),
                          ),
                        ],
                      ),
            ),
          ),
          if (_batchProgressNotifier != null)
            Padding(
              padding: const EdgeInsets.only(top: 20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: 180,
                    child: ProgressBar(
                      value: _batchProgress * 100,
                      backgroundColor: theme.resources.subtleFillColorSecondary,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    _batchProgress == 1.0
                        ? localizations.downloadComplete
                        : _batchProgress == 0.0
                        ? localizations.downloadPending
                        : '${localizations.downloading} ${(_batchProgress * 100).toStringAsFixed(0)}%',
                    style: typography.body,
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}
