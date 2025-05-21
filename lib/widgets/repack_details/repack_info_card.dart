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
      padding: const EdgeInsets.symmetric(
        vertical: 6.0,
      ), // Increased vertical padding
      child: Row(
        crossAxisAlignment:
            CrossAxisAlignment.start, // Align icon with first line of text
        children: [
          Icon(
            icon,
            size: 18,
            color: theme.accentColor.defaultBrushFor(theme.brightness),
          ),
          const SizedBox(width: 10),
          Text(
            '$label: ',
            style: theme.typography.bodyStrong?.copyWith(
              // Or use a slightly dimmer color if bodyStrong is too much
              // color: theme.resources.textFillColorSecondary,
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: theme.typography.body,
              softWrap: true, // Ensure text wraps
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
    final String genresLabel =
        "Genres"; // AppLocalizations.of(context)!.genres;
    final String companyLabel =
        "Company"; // AppLocalizations.of(context)!.company;
    final String languageLabel =
        "Language"; // AppLocalizations.of(context)!.language;
    final String originalSizeLabel =
        "Original Size"; // AppLocalizations.of(context)!.originalSize;
    final String repackSizeLabel =
        "Repack Size"; // AppLocalizations.of(context)!.repackSize;

    return Card(
      borderRadius: BorderRadius.circular(8),
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
                'Repack info',
                style: theme.typography.subtitle?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 8.0,
            ), // Added padding for divider
            child: Divider(
              style: DividerThemeData(
                thickness: 2,
                horizontalMargin: EdgeInsets.zero,
                verticalMargin: EdgeInsets.zero,
              ),
            ),
          ),
          _InfoRow(
            icon: FluentIcons.tag,
            label: genresLabel,
            value: repack.genres,
          ),
          _InfoRow(
            icon: FluentIcons.developer_tools,
            label: companyLabel,
            value: repack.company,
          ), // Changed icon
          _InfoRow(
            icon: FluentIcons.locale_language,
            label: languageLabel,
            value: repack.language,
          ),
          _InfoRow(
            icon: FluentIcons.size_legacy,
            label: originalSizeLabel,
            value: repack.originalSize,
          ),
          _InfoRow(
            icon: FluentIcons.save_all,
            label: repackSizeLabel,
            value: repack.repackSize,
          ), // Changed icon
        ],
      ),
    );
  }
}
