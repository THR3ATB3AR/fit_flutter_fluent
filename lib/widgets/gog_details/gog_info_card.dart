import 'package:fit_flutter_fluent/data/gog_game.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:fit_flutter_fluent/l10n/generated/app_localizations.dart';
import 'package:flutter/material.dart' show Icons;
import 'package:intl/intl.dart';

class _InfoRow extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;

  const _InfoRow({
    required this.icon,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    final theme = FluentTheme.of(context);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0), 
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            icon,
            size: 18, 
            color: theme.accentColor.defaultBrushFor(theme.brightness),
          ),
          const SizedBox(width: 12), 
          Expanded( 
            child: RichText(
              text: TextSpan(
                style: theme.typography.body, 
                children: [
                  TextSpan(
                    text: '$label: ',
                    style: theme.typography.bodyStrong,
                  ),
                  TextSpan(
                    text: value,
                    style: theme.typography.body?.copyWith(
                      color: theme.resources.textFillColorSecondary, 
                    )
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class GogGameInfoCard extends StatelessWidget {
  final GogGame gogGame;

  const GogGameInfoCard({super.key, required this.gogGame});

  String _formatBytes(int? bytes) {
    if (bytes == null || bytes <= 0) return 'N/A';
    const suffixes = ["B", "KB", "MB", "GB", "TB"];
    var i = 0;
    double dbl = bytes.toDouble();
    while (dbl >= 1024 && i < suffixes.length -1) {
      dbl /= 1024;
      i++;
    }
    return '${dbl.toStringAsFixed(2)} ${suffixes[i]}';
  }

  @override
  Widget build(BuildContext context) {
    final theme = FluentTheme.of(context);
    String genresLabel = AppLocalizations.of(context)!.genres;
    String companyLabel = AppLocalizations.of(context)!.company;
    String developerLabel = AppLocalizations.of(context)!.developer;
    String languageLabel = AppLocalizations.of(context)!.language;
    String userRatingLabel = AppLocalizations.of(context)!.userRating;
    String downloadSizeLabel = AppLocalizations.of(context)!.downloadSize;
    String lastUpdateLabel = AppLocalizations.of(context)!.lastUpdate;

    return Card(
      borderRadius: BorderRadius.circular(8.0),
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              Icon(
                FluentIcons.info_solid, 
                color: theme.accentColor.defaultBrushFor(theme.brightness),
                size: 20,
              ),
              const SizedBox(width: 8),
              Text(
                AppLocalizations.of(context)!.gogGameDetails,
                style: theme.typography.subtitle?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 12.0), 
            child: Divider(
              style: DividerThemeData(
                thickness: 1,
                horizontalMargin: EdgeInsets.zero,
                verticalMargin: EdgeInsets.zero,
              ),
            ),
          ),
          _InfoRow(icon: FluentIcons.tag, label: genresLabel, value: gogGame.genres.join(', ')),
          _InfoRow(icon: FluentIcons.people, label: companyLabel, value: gogGame.publisher), 
          _InfoRow(icon: FluentIcons.developer_tools, label: developerLabel, value: gogGame.developer),
          _InfoRow(icon: FluentIcons.locale_language, label: languageLabel, value: gogGame.languages.join(', ')),
          if (gogGame.userRating != null && gogGame.userRating! > 0)
            _InfoWidgetRow(
              icon: FluentIcons.favorite_star,
              label: userRatingLabel,
              valueWidget: _StarRating(rating: gogGame.userRating),
            ),
          _InfoRow(icon: FluentIcons.hard_drive, label: downloadSizeLabel, value: _formatBytes(gogGame.windowsDownloadSize)),
          _InfoRow(icon: FluentIcons.history, label: lastUpdateLabel, value: DateFormat.yMMMMd(Localizations.localeOf(context).toString()).format(gogGame.updateDate)),
        ],
      ),
    );
  }
}

class _StarRating extends StatelessWidget {
  final int? rating; // GOG rating is out of 50
  const _StarRating({this.rating});

  @override
  Widget build(BuildContext context) {
    final theme = FluentTheme.of(context);
    if (rating == null || rating == 0) {
      return const SizedBox.shrink();
    }
    
    // Convert GOG's 0-50 scale to a 0-5 star scale
    final double starRating = (rating! / 10.0).clamp(0.0, 5.0);
    final int fullStars = starRating.floor();
    final bool hasHalfStar = (starRating - fullStars) >= 0.5;

    return Row(
      children: List.generate(5, (index) {
        IconData icon;
        if (index < fullStars) {
          icon = Icons.star_rate;
        } else if (index == fullStars && hasHalfStar) {
          icon = Icons.star_half; 
        } else {
          icon = Icons.star_rate_outlined;
        }
        return Icon(
          icon,
          size: 16,
          color: theme.accentColor.defaultBrushFor(theme.brightness),
        );
      }),
    );
  }
}

// --- ADD THIS INFO ROW VARIANT FOR WIDGETS ---
class _InfoWidgetRow extends StatelessWidget {
  final IconData icon;
  final String label;
  final Widget valueWidget;

  const _InfoWidgetRow({
    required this.icon,
    required this.label,
    required this.valueWidget,
  });

  @override
  Widget build(BuildContext context) {
    final theme = FluentTheme.of(context);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center, // Center align for stars
        children: [
          Icon(
            icon,
            size: 18,
            color: theme.accentColor.defaultBrushFor(theme.brightness),
          ),
          const SizedBox(width: 12),
          Text(
            '$label: ',
            style: theme.typography.bodyStrong,
          ),
          Expanded(child: valueWidget),
        ],
      ),
    );
  }
}
