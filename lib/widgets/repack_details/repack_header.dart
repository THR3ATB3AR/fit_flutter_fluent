import 'package:cached_network_image/cached_network_image.dart';
import 'package:fit_flutter_fluent/data/repack.dart';
import 'package:fluent_ui/fluent_ui.dart';

class RepackHeader extends StatefulWidget {
  final Repack repack;
  const RepackHeader({super.key, required this.repack});

  @override
  State<RepackHeader> createState() => _RepackHeaderState();
}

class _RepackHeaderState extends State<RepackHeader> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            CachedNetworkImage(
              imageUrl: widget.repack.cover,
              fit: BoxFit.cover,
              width: 100,
              height: 300,
            ),
            const SizedBox(width: 10),
            Column(
              children: [
                Text(
                  widget.repack.title,
                  style: const TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  widget.repack.company,
                  style: const TextStyle(fontSize: 12),
                ),
              ],
            )
          ],
        )
      ],
    );
  }
}