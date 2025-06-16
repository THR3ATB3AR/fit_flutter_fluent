import 'package:fit_flutter_fluent/data/repack.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:fit_flutter_fluent/l10n/generated/app_localizations.dart';

class _InfoRow extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;

  const _InfoRow({
    required this.icon,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    final theme = FluentTheme.of(context);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0), 
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            icon,
            size: 18, 
            color: theme.accentColor.defaultBrushFor(theme.brightness),
          ),
          const SizedBox(width: 12), 
          Expanded( 
            child: RichText(
              text: TextSpan(
                style: theme.typography.body, 
                children: [
                  TextSpan(
                    text: '$label: ',
                    style: theme.typography.bodyStrong,
                  ),
                  TextSpan(
                    text: value,
                    style: theme.typography.body?.copyWith(
                      color: theme.resources.textFillColorSecondary, 
                    )
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class RepackInfoCard extends StatelessWidget {
  final Repack repack;

  const RepackInfoCard({super.key, required this.repack});

  @override
  Widget build(BuildContext context) {
    final theme = FluentTheme.of(context);
    String genresLabel = AppLocalizations.of(context)!.genres;
    String companyLabel = AppLocalizations.of(context)!.company;
    String languageLabel = AppLocalizations.of(context)!.language;
    String originalSizeLabel = AppLocalizations.of(context)!.originalSize;
    String repackSizeLabel = AppLocalizations.of(context)!.repackSize;

    return Card(
      borderRadius: BorderRadius.circular(8.0),
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              Icon(
                FluentIcons.info_solid, 
                color: theme.accentColor.defaultBrushFor(theme.brightness),
                size: 20,
              ),
              const SizedBox(width: 8),
              Text(
                AppLocalizations.of(context)!.repackInformation,
                style: theme.typography.subtitle?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 12.0), 
            child: Divider(
              style: DividerThemeData(
                thickness: 1,
                horizontalMargin: EdgeInsets.zero,
                verticalMargin: EdgeInsets.zero,
              ),
            ),
          ),
          _InfoRow(icon: FluentIcons.tag, label: genresLabel, value: repack.genres),
          _InfoRow(icon: FluentIcons.people, label: companyLabel, value: repack.company), 
          _InfoRow(icon: FluentIcons.locale_language, label: languageLabel, value: repack.language),
          _InfoRow(icon: FluentIcons.hard_drive, label: originalSizeLabel, value: repack.originalSize), 
          _InfoRow(icon: FluentIcons.publish_content, label: repackSizeLabel, value: repack.repackSize), 
        ],
      ),
    );
  }
}
