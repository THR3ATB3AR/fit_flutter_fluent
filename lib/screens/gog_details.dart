import 'package:fit_flutter_fluent/data/gog_game.dart';
import 'package:fit_flutter_fluent/widgets/gog_details/description_section.dart';
import 'package:fit_flutter_fluent/widgets/gog_details/gog_header.dart';
import 'package:fit_flutter_fluent/widgets/gog_details/gog_screenshot_section.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:fit_flutter_fluent/services/scraper_service.dart';
import 'package:fit_flutter_fluent/services/repack_service.dart';
import 'package:fit_flutter_fluent/l10n/generated/app_localizations.dart';

class GogDetails extends StatefulWidget {
  final GogGame selectedGogGame;
  const GogDetails({super.key, required this.selectedGogGame});

  @override
  State<GogDetails> createState() => _GogDetailsState();
}

class _GogDetailsState extends State<GogDetails> {
  late GogGame _currentGogGame;
  bool _isRescrapingDetails = false;

  final ScraperService _scraperService = ScraperService.instance;
  final RepackService _repackService = RepackService.instance;

  @override
  void initState() {
    super.initState();
    _currentGogGame = widget.selectedGogGame;
  }

  Future<void> _openRepackUrl() async {
    if (_currentGogGame.url.isEmpty) {
      _showInfoBar(
        title: AppLocalizations.of(context)!.error,
        content: AppLocalizations.of(context)!.repackUrlIsNotAvailable,
        severity: InfoBarSeverity.error,
      );
      return;
    }
    final uri = Uri.tryParse(_currentGogGame.url);
    if (uri != null) {
      if (await canLaunchUrl(uri)) {
        try {
          await launchUrl(uri, mode: LaunchMode.externalApplication);
        } catch (e) {
          _showInfoBar(
            title: AppLocalizations.of(context)!.error,
            content: AppLocalizations.of(
              context,
            )!.couldNotLaunchUrl(e.toString()),
            severity: InfoBarSeverity.error,
          );
        }
      } else {
        _showInfoBar(
          title: AppLocalizations.of(context)!.error,
          content: AppLocalizations.of(
            context,
          )!.couldNotLaunch(_currentGogGame.url),
          severity: InfoBarSeverity.error,
        );
      }
    } else {
      _showInfoBar(
        title: AppLocalizations.of(context)!.error,
        content: AppLocalizations.of(
          context,
        )!.invalidUrlFormat(_currentGogGame.url),
        severity: InfoBarSeverity.error,
      );
    }
  }

  Future<void> _rescrapeDetails() async {
    if (_isRescrapingDetails) return;

    setState(() {
      _isRescrapingDetails = true;
    });

    try {
      GogGame newGogGameData = await _scraperService.rescrapeSingleGogGame(
        _currentGogGame.id,
      );

      _repackService.gogGames.removeWhere((g) => g.id == newGogGameData.id);
      _repackService.gogGames.add(newGogGameData);

      await _repackService.saveGogGamesList();

      if (mounted) {
        setState(() {
          _currentGogGame = newGogGameData;
        });
        _showInfoBar(
          title: AppLocalizations.of(context)!.success,
          content: AppLocalizations.of(
            context,
          )!.detailsHaveBeenRescraped(newGogGameData.title),
          severity: InfoBarSeverity.success,
        );
      }
    } catch (e) {
      _showInfoBar(
        title: AppLocalizations.of(context)!.errorRescraping,
        content: AppLocalizations.of(
          context,
        )!.failedToRescrapeDetails(e.toString()),
        severity: InfoBarSeverity.error,
      );
    } finally {
      if (mounted) {
        setState(() {
          _isRescrapingDetails = false;
        });
      }
    }
  }

  void _showInfoBar({
    required String title,
    required String content,
    required InfoBarSeverity severity,
  }) {
    if (mounted) {
      displayInfoBar(
        context,
        builder:
            (context, _) => InfoBar(
              title: Text(title),
              content: Text(content),
              severity: severity,
            ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    const double screenshotSectionMaxWidth = 1400.0;

    return ScaffoldPage.scrollable(
      header: CommandBar(
        mainAxisAlignment: MainAxisAlignment.end,
        primaryItems: [
          CommandBarButton(
            icon: const Icon(FluentIcons.globe),
            label: Text(AppLocalizations.of(context)!.openSourcePage),
            onPressed: _currentGogGame.url.isNotEmpty ? _openRepackUrl : null,
          ),
          CommandBarButton(
            icon:
                _isRescrapingDetails
                    ? const SizedBox(
                      height: 18,
                      width: 18,
                      child: ProgressRing(),
                    )
                    : const Icon(FluentIcons.refresh),
            label: Text(AppLocalizations.of(context)!.rescrapeDetails),
            onPressed:
                _isRescrapingDetails || _currentGogGame.url.isEmpty
                    ? null
                    : _rescrapeDetails,
          ),
        ],
      ),
      children: [
        Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(
              maxWidth: screenshotSectionMaxWidth,
            ),
            child: GogHeader(gogGame: _currentGogGame),
          ),
        ),
        const SizedBox(height: 60),
        Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(
              maxWidth: screenshotSectionMaxWidth,
            ),
            child: SizedBox(
              height: 600,
              child: GogScreenshotSection(gogGames: _currentGogGame),
            ),
          ),
        ),
        const SizedBox(height: 20),
        Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(
              maxWidth: screenshotSectionMaxWidth,
            ),
            child: DescriptionSection(gogGame: _currentGogGame),
          ),
        ),
      ],
    );
  }
}
