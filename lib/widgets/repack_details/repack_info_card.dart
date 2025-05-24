import 'package:fit_flutter_fluent/data/repack.dart';
import 'package:fluent_ui/fluent_ui.dart';

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
      padding: const EdgeInsets.symmetric(vertical: 8.0), // Increased vertical padding
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            icon,
            size: 18, // Consistent icon size
            color: theme.accentColor.defaultBrushFor(theme.brightness),
          ),
          const SizedBox(width: 12), // Slightly increased spacing
          Expanded( // Use Expanded to allow label and value to take space
            child: RichText(
              text: TextSpan(
                style: theme.typography.body, // Default text style
                children: [
                  TextSpan(
                    text: '$label: ',
                    style: theme.typography.bodyStrong,
                  ),
                  TextSpan(
                    text: value,
                    style: theme.typography.body?.copyWith(
                      color: theme.resources.textFillColorSecondary, // Softer color for value
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
    // Define these strings, potentially using AppLocalizations
    const String genresLabel = "Genres";
    const String companyLabel = "Company";
    const String languageLabel = "Language";
    const String originalSizeLabel = "Original Size";
    const String repackSizeLabel = "Repack Size";

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
                FluentIcons.info_solid, // Using info_solid for a filled look
                color: theme.accentColor.defaultBrushFor(theme.brightness),
                size: 20,
              ),
              const SizedBox(width: 8),
              Text(
                'Repack Information',
                style: theme.typography.subtitle?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 12.0), // Adjusted padding
            child: Divider(
              style: DividerThemeData(
                thickness: 1,
                horizontalMargin: EdgeInsets.zero,
                verticalMargin: EdgeInsets.zero,
              ),
            ),
          ),
          _InfoRow(icon: FluentIcons.tag, label: genresLabel, value: repack.genres),
          _InfoRow(icon: FluentIcons.people, label: companyLabel, value: repack.company), // Changed icon to People for company
          _InfoRow(icon: FluentIcons.locale_language, label: languageLabel, value: repack.language),
          _InfoRow(icon: FluentIcons.hard_drive, label: originalSizeLabel, value: repack.originalSize), // Changed icon
          _InfoRow(icon: FluentIcons.publish_content, label: repackSizeLabel, value: repack.repackSize), // Changed icon
        ],
      ),
    );
  }
}
