import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:fit_flutter_fluent/data/repack.dart';

class RepackItem extends StatelessWidget {
  final Repack repack;
  final double itemHeight;

  const RepackItem({super.key, required this.repack, required this.itemHeight});

  String _overflowText(String text, int maxLength) {
    return text.length > maxLength
        ? '${text.substring(0, maxLength)}...'
        : text;
  }

  @override
  Widget build(BuildContext context) {
    return Tooltip(
        verticalOffset: 120,
        waitDuration: const Duration(milliseconds: 1000),
        exitDuration: const Duration(milliseconds: 0),
        richMessage: TextSpan(
          text: '${_overflowText(repack.title, 30)}\n',
          style: const TextStyle(fontWeight: FontWeight.bold),
          children: [
            TextSpan(
                text:
                    '{AppLocalizations.of(context)!.genres}: ${repack.genres}\n',
                children: [
                  TextSpan(
                    text:
                        '{AppLocalizations.of(context)!.company}: ${repack.company}\n',
                  ),
                  TextSpan(
                    text:
                        '{AppLocalizations.of(context)!.language}: ${repack.language}\n',
                  ),
                  TextSpan(
                    text:
                        '{AppLocalizations.of(context)!.originalSize}: ${repack.originalSize}\n',
                  ),
                  TextSpan(
                      text:
                          '{AppLocalizations.of(context)!.repackSize}: ${repack.repackSize}'),
                ]),
          ],
        ),
        child: Card(
          margin: const EdgeInsets.all(8.0),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(8.0),
            child: CachedNetworkImage(
              imageUrl: repack.cover,
              fit: BoxFit.cover,
              width: itemHeight * 0.65,
            ),
          ),
        ));
  }
}
