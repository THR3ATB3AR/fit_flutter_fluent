import 'package:fit_flutter_fluent/widgets/repack_details/features_description_section.dart';
import 'package:fit_flutter_fluent/widgets/repack_details/repack_header.dart';
import 'package:fit_flutter_fluent/widgets/repack_details/screenshot_section.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:fit_flutter_fluent/data/repack.dart';
import 'package:url_launcher/url_launcher.dart'; 
import 'package:fit_flutter_fluent/services/scraper_service.dart'; 
import 'package:fit_flutter_fluent/services/repack_service.dart'; 
import 'package:fit_flutter_fluent/l10n/generated/app_localizations.dart';


class RepackDetails extends StatefulWidget {
  final Repack selectedRepack;
  const RepackDetails({super.key, required this.selectedRepack});

  @override
  State<RepackDetails> createState() => _RepackDetailsState();
}

class _RepackDetailsState extends State<RepackDetails> {
  late Repack _currentRepack;
  bool _isRescrapingDetails = false;

  final ScraperService _scraperService = ScraperService.instance;
  final RepackService _repackService = RepackService.instance;

  @override
  void initState() {
    super.initState();
    _currentRepack = widget.selectedRepack;
  }

  Future<void> _openRepackUrl() async {
    if (_currentRepack.url.isEmpty) {
      _showInfoBar(
        title: AppLocalizations.of(context)!.error,
        content: AppLocalizations.of(context)!.repackUrlIsNotAvailable,
        severity: InfoBarSeverity.error,
      );
      return;
    }
    final uri = Uri.tryParse(_currentRepack.url);
    if (uri != null) {
      if (await canLaunchUrl(uri)) {
        try {
          await launchUrl(uri, mode: LaunchMode.externalApplication);
        } catch (e) {
          _showInfoBar(
            title: AppLocalizations.of(context)!.error,
            content: AppLocalizations.of(context)!.couldNotLaunchUrl(e.toString()),
            severity: InfoBarSeverity.error,
          );
        }
      } else {
        _showInfoBar(
          title: AppLocalizations.of(context)!.error,
          content: AppLocalizations.of(context)!.couldNotLaunch(_currentRepack.url),
          severity: InfoBarSeverity.error,
        );
      }
    } else {
      _showInfoBar(
        title: AppLocalizations.of(context)!.error,
        content: AppLocalizations.of(context)!.invalidUrlFormat(_currentRepack.url),
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
      final String urlToScrape = _currentRepack.url;
      if (urlToScrape.isEmpty) {
        throw Exception("Repack URL is empty, cannot rescrape.");
      }

      Repack newRepackData = await _scraperService.scrapeRepackFromSearch(
        urlToScrape,
      );

      _repackService.everyRepack.removeWhere((r) => r.url == newRepackData.url);
      _repackService.everyRepack.add(newRepackData);
      _repackService.everyRepack.sort((a, b) => a.title.compareTo(b.title));
      await _repackService.saveSingleEveryRepack(newRepackData);

      if (mounted) {
        setState(() {
          _currentRepack = newRepackData;
        });
        _showInfoBar(
          title: AppLocalizations.of(context)!.success,
          content:
              AppLocalizations.of(context)!.detailsHaveBeenRescraped(newRepackData.title),
          severity: InfoBarSeverity.success,
        );
      }
    } catch (e) {
      _showInfoBar(
        title: AppLocalizations.of(context)!.errorRescraping,
        content: AppLocalizations.of(context)!.failedToRescrapeDetails(e.toString()),
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
            onPressed: _currentRepack.url.isNotEmpty ? _openRepackUrl : null,
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
                _isRescrapingDetails || _currentRepack.url.isEmpty
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
            child: RepackHeader(repack: _currentRepack), 
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
              child: ScreenshotSection(
                repack: _currentRepack,
              ), 
            ),
          ),
        ),
        const SizedBox(height: 20),
        Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(
              maxWidth: screenshotSectionMaxWidth,
            ),
            child: FeaturesDescriptionSection(
              repack: _currentRepack,
            ), 
          ),
        ),
      ],
    );
  }
}
