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
            children: [
              Card(
                borderRadius: BorderRadius.all(Radius.circular(8)),
                child: Column(
                  mainAxisSize: MainAxisSize.min, 
                  crossAxisAlignment: CrossAxisAlignment.stretch, 
                  children: [
                    Padding( 
                      padding: const EdgeInsets.all(8),
                      child: Text(
                        'About game',
                        style: FluentTheme.of(context).typography.subtitle,
                      ),
                    ),
                    Divider(
                      style: DividerThemeData(
                        horizontalMargin: EdgeInsets.all(0),
                        verticalMargin: EdgeInsets.all(0),
                        thickness: 2,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        repack.description,
                        style: FluentTheme.of(context).typography.body,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16), 
              Card(
                borderRadius: BorderRadius.all(Radius.circular(8)),
                child: Column(
                  mainAxisSize: MainAxisSize.min, 
                  crossAxisAlignment: CrossAxisAlignment.stretch, 
                  children: [
                     Padding( 
                      padding: const EdgeInsets.all(8),
                      child: Text(
                        'Features',
                        style: FluentTheme.of(context).typography.subtitle,
                      ),
                    ),
                    Divider(
                      style: DividerThemeData(
                        horizontalMargin: EdgeInsets.all(0),
                        verticalMargin: EdgeInsets.all(0),
                        thickness: 2,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        repack.repackFeatures,
                        style: FluentTheme.of(context).typography.body,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        const SizedBox(width: 20),
        Expanded(
          flex: 1,
          child: RepackInfoCard(repack: repack),
        ),
      ],
    );
  }
}
