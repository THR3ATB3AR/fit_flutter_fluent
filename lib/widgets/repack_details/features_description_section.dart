import 'package:fit_flutter_fluent/widgets/repack_details/repack_info_card.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:fit_flutter_fluent/data/repack.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:flutter_html/flutter_html.dart';
import 'package:url_launcher/url_launcher.dart';

class FeaturesDescriptionSection extends StatelessWidget {
  final Repack repack;
  const FeaturesDescriptionSection({super.key, required this.repack});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 2,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _buildSectionCard(
                context,
                title: AppLocalizations.of(context)!.aboutGame,
                content: repack.description,
              ),
              const SizedBox(height: 16),
              _buildSectionCard(
                context,
                title: AppLocalizations.of(context)!.features,
                content: repack.repackFeatures,
              ),
            ],
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          flex: 1,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              RepackInfoCard(repack: repack),
              const SizedBox(height: 16),
              repack.updates == null 
                  ? Container()
                  :
              _buildHtmlSectionCard(
                context,
                title: "Updates & Patches",
                htmlContent: repack.updates!,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildSectionCard(BuildContext context,
      {required String title, required String content}) {
    final theme = FluentTheme.of(context);
    return Card(
      borderRadius: BorderRadius.circular(8.0),
      padding: EdgeInsets.zero,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.only(
                left: 16.0, top: 16.0, right: 16.0, bottom: 8.0),
            child: Text(
              title,
              style: theme.typography.subtitle
                  ?.copyWith(fontWeight: FontWeight.w600),
            ),
          ),
          const Divider(
            style: DividerThemeData(
              thickness: 1,
              horizontalMargin: EdgeInsets.zero,
              verticalMargin: EdgeInsets.zero,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              content,
              style: theme.typography.body,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHtmlSectionCard(BuildContext context,
      {required String title, required String htmlContent}) {
    final theme = FluentTheme.of(context);

    Future<void> _launchUrl(String? urlString) async {
      if (urlString != null) {
        final uri = Uri.parse(urlString);
        if (await canLaunchUrl(uri)) {
          await launchUrl(uri, mode: LaunchMode.externalApplication);
        } else {
          debugPrint('Could not launch $uri');
        }
      }
    }

    return Card(
      borderRadius: BorderRadius.circular(8.0),
      padding: EdgeInsets.zero,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.only(
                left: 16.0, top: 16.0, right: 16.0, bottom: 8.0),
            child: Row(
              children: [
                Icon(FluentIcons.sync_occurence, size: 20, color: theme.accentColor.defaultBrushFor(theme.brightness)),
                const SizedBox(width: 8.0),
                Text(
                  title,
                  style: theme.typography.subtitle
                      ?.copyWith(fontWeight: FontWeight.w600),
                ),
              ],
            ),
          ),
          const Divider(
            style: DividerThemeData(
              thickness: 1,
              horizontalMargin: EdgeInsets.zero,
              verticalMargin: EdgeInsets.zero,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Html(
              data: htmlContent,
              onLinkTap: (url, _, __) => _launchUrl(url),
              style: {
                "body": Style(
                  fontFamily: theme.typography.body?.fontFamily,
                  fontSize: FontSize(theme.typography.body!.fontSize!),
                  color: theme.typography.body?.color,
                  margin: Margins.zero,
                  padding: HtmlPaddings.zero,
                ),
                "a": Style(
                  color: theme.accentColor.defaultBrushFor(theme.brightness),
                  textDecoration: TextDecoration.underline,
                  textDecorationColor: theme.accentColor.defaultBrushFor(theme.brightness),
                ),
                "div": Style(
                  padding: HtmlPaddings.symmetric(vertical: 8.0),
                ),
              },
            ),
          ),
        ],
      ),
    );
  }
}