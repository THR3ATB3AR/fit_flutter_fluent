import 'package:fit_flutter_fluent/widgets/repack_details/repack_info_card.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:fit_flutter_fluent/data/repack.dart';

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
                title: 'About game',
                content: repack.description,
              ),
              const SizedBox(height: 16),
              _buildSectionCard(
                context,
                title: 'Features',
                content: repack.repackFeatures,
              ),
            ],
          ),
        ),
        const SizedBox(width: 16), // Consistent spacing
        Expanded(flex: 1, child: RepackInfoCard(repack: repack)),
      ],
    );
  }

  Widget _buildSectionCard(BuildContext context,
      {required String title, required String content}) {
    final theme = FluentTheme.of(context);
    return Card(
      borderRadius: BorderRadius.circular(8.0),
      padding: EdgeInsets.zero, // Control padding internally
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 16.0, top: 16.0, right: 16.0, bottom: 8.0),
            child: Text(
              title,
              style: theme.typography.subtitle?.copyWith(fontWeight: FontWeight.w600),
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
}