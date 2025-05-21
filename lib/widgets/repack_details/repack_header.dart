import 'package:cached_network_image/cached_network_image.dart';
import 'package:fit_flutter_fluent/data/repack.dart';
import 'package:fit_flutter_fluent/widgets/fluent_chip.dart';
import 'package:fluent_ui/fluent_ui.dart';

class RepackHeader extends StatefulWidget {
  final Repack repack;
  const RepackHeader({super.key, required this.repack});

  @override
  State<RepackHeader> createState() => _RepackHeaderState();
}

class _RepackHeaderState extends State<RepackHeader> {
  String _overflowText(String text, int maxLength) {
    return text.length > maxLength
        ? '${text.substring(0, maxLength)}...'
        : text;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: CachedNetworkImage(
                imageUrl: widget.repack.cover,
                fit: BoxFit.cover,
                width: 100,
                height: 100,
              ),
            ),
            const SizedBox(width: 40),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  _overflowText(widget.repack.title, 39),
                  style: const TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 15),
                Text(
                  widget.repack.company,
                  style: const TextStyle(fontSize: 14),
                ),
              ],
            ),
          ],
        ),
        const SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children:
              widget.repack.genres
                  .split(',')
                  .map(
                    (g) => Padding(
                      padding: const EdgeInsets.only(right: 12.0),
                      child: FluentChip(label: g.trim()),
                    ),
                  )
                  .toList(),
        ),
        const SizedBox(height: 20),
        FilledButton(
          style: ButtonStyle(
            backgroundColor: WidgetStateProperty.all(
              FluentTheme.of(context).accentColor,
            ),
            padding: WidgetStateProperty.all(
              const EdgeInsets.only(right: 80, left: 15, top: 15, bottom: 15),
            ),
          ),
          child: Text(
            "Download",
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w500,
              fontSize: 14,
            ),
          ),
          onPressed: () {},
        ),
      ],
    );
  }
}
