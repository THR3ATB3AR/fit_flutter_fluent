import 'package:cached_network_image/cached_network_image.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter/material.dart' as m;
import 'package:fit_flutter_fluent/data/repack.dart';

class RepackItem extends StatelessWidget {
  final Repack repack;
  final double itemHeight;

  const RepackItem({super.key, required this.repack, required this.itemHeight});

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: repack.title,
      child: m.Card(
        margin: const EdgeInsets.all(8.0),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(8.0),
          child: CachedNetworkImage(
            imageUrl: repack.cover,
            fit: BoxFit.cover,
            width: itemHeight * 0.65,
          ),
        ),
      ),
    );
  }
}
