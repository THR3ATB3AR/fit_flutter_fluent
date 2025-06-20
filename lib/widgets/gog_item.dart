import 'package:cached_network_image/cached_network_image.dart';
import 'package:fit_flutter_fluent/data/gog_game.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter/material.dart' as m;

class GogItem extends StatelessWidget {
  final GogGame gogGame;
  final double itemHeight;

  const GogItem({super.key, required this.gogGame, required this.itemHeight});

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: gogGame.title,
      child: m.Card(
        margin: const EdgeInsets.all(8.0),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(8.0),
          child: CachedNetworkImage(
            imageUrl: gogGame.cover,
            fit: BoxFit.cover,
            width: itemHeight * 0.65,
          ),
        ),
      ),
    );
  }
}
