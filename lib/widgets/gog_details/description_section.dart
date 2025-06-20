import 'package:fit_flutter_fluent/data/gog_game.dart';
import 'package:fit_flutter_fluent/widgets/gog_details/gog_info_card.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:fit_flutter_fluent/l10n/generated/app_localizations.dart';

class DescriptionSection extends StatelessWidget {
  final GogGame gogGame;
  const DescriptionSection({super.key, required this.gogGame});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 2,
          child: _buildSectionCard(
            context,
            title: AppLocalizations.of(context)!.aboutGame,
            content: gogGame.description,
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          flex: 1,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [GogGameInfoCard(gogGame: gogGame)],
          ),
        ),
      ],
    );
  }

  Widget _buildSectionCard(
    BuildContext context, {
    required String title,
    required String content,
  }) {
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
              left: 16.0,
              top: 16.0,
              right: 16.0,
              bottom: 8.0,
            ),
            child: Text(
              title,
              style: theme.typography.subtitle?.copyWith(
                fontWeight: FontWeight.w600,
              ),
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
            child: Text(content, style: theme.typography.body),
          ),
        ],
      ),
    );
  }
}
