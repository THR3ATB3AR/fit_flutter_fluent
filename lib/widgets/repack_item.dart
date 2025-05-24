import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:fit_flutter_fluent/data/repack.dart';

class RepackItem extends StatelessWidget {
  final Repack repack;
  final double itemHeight;

  const RepackItem({super.key, required this.repack, required this.itemHeight});

  @override
  Widget build(BuildContext context) {
    return Card(
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
    );
  }
}
