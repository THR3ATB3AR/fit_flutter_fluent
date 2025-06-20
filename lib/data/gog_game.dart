import 'dart:convert';

class GogGame {
  final int id;
  final String title;
  final String slug;
  final String url;
  final String description;
  final String developer;
  final String publisher;
  final DateTime updateDate;
  final String cover;
  final List<String> genres;
  final List<String> screenshots;
  final List<String> languages;
  final int? userRating;
  final int? windowsDownloadSize;

  GogGame({
    required this.id,
    required this.title,
    required this.slug,
    String? url,
    required this.description,
    required this.developer,
    required this.publisher,
    required this.updateDate,
    required this.cover,
    required this.genres,
    required this.screenshots,
    required this.languages,
    this.userRating,
    this.windowsDownloadSize,
  }) : url = url ?? 'https://gog-games.to/game/$slug';

  factory GogGame.fromSqlite(Map<String, dynamic> row) {
    return GogGame(
      id: row['id'] as int,
      title: row['title'] as String,
      slug: row['slug'] as String,
      url: row['url'] as String,
      description: row['description'] as String,
      developer: row['developer'] as String,
      publisher: row['publisher'] as String,
      updateDate:
          DateTime.tryParse(row['updateDate'] as String) ?? DateTime(1970),
      cover: row['cover'] as String,
      genres:
          (jsonDecode(row['genres'] as String) as List<dynamic>).cast<String>(),
      screenshots:
          (jsonDecode(row['screenshots'] as String) as List<dynamic>)
              .cast<String>(),
      languages:
          (jsonDecode(row['languages'] as String) as List<dynamic>)
              .cast<String>(),
      userRating: row['userRating'] as int?,
      windowsDownloadSize: row['windowsDownloadSize'] as int?,
    );
  }

  List<dynamic> toSqliteParams() {
    return [
      id,
      title,
      slug,
      url,
      description,
      developer,
      publisher,
      updateDate.toIso8601String(),
      cover,
      jsonEncode(genres),
      jsonEncode(screenshots),
      jsonEncode(languages),
      userRating,
      windowsDownloadSize,
    ];
  }
}
