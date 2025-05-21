import 'package:fit_flutter_fluent/widgets/repack_details/features_description_section.dart';
import 'package:fit_flutter_fluent/widgets/repack_details/repack_header.dart';
import 'package:fit_flutter_fluent/widgets/repack_details/screenshot_section.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:fit_flutter_fluent/data/repack.dart';

class RepackDetails extends StatefulWidget {
  final Repack selectedRepack;
  const RepackDetails({super.key, required this.selectedRepack});

  @override
  State<RepackDetails> createState() => _RepackDetailsState();
}

class _RepackDetailsState extends State<RepackDetails> {
  @override
  Widget build(BuildContext context) {
    const double screenshotSectionMaxWidth = 1400.0;

    return ScaffoldPage.scrollable(
      children: [
        Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(
              maxWidth: screenshotSectionMaxWidth,
            ),
            child: RepackHeader(repack: widget.selectedRepack),
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
              child: ScreenshotSection(repack: widget.selectedRepack),
            ),
          ),
        ),
        const SizedBox(height: 20),
        Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(
              maxWidth: screenshotSectionMaxWidth,
            ),
            child: FeaturesDescriptionSection(repack: widget.selectedRepack),
          ),
        ),
      ],
    );
  }
}
