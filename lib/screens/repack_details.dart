import 'package:fit_flutter_fluent/widgets/repack_details/repack_header.dart';
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
    return ScaffoldPage.scrollable(children: [
      RepackHeader(repack: widget.selectedRepack),
    ]);
  }
}