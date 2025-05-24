// services/repack_service.dart
import 'dart:async';
import 'dart:io';
import 'package:fit_flutter_fluent/data/repack.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqlite3/sqlite3.dart';
import 'package:http/http.dart' as http;

class RepackService {
  RepackService._privateConstructor();
  static final RepackService _instance = RepackService._privateConstructor();
  static RepackService get instance => _instance;

  final StreamController<void> _controller = StreamController<void>.broadcast();
  Stream<void> get repacksStream => _controller.stream;

  List<Repack> newRepacks = [];
  List<Repack> popularRepacks = [];
  List<Repack> everyRepack = [];
  Map<String, String> allRepacksNames = {};
  Map<String, String> failedRepacks = {};

  bool isDataLoadedInMemory = false;

  Future<void> init() async {
    await initializeDatabase();
    if (!isDataLoadedInMemory && (await _hasDataToLoad())) {
      await loadRepacks();
    } else if (isDataLoadedInMemory) {
      _controller.add(null); // Notify if already loaded (e.g. hot reload)
    }
    // Startup rescrape of new/popular is handled in main.dart after this init
  }

  Future<void> _downloadDatabase(String url, String savePath) async {
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      final file = File(savePath);
      await file.writeAsBytes(response.bodyBytes);
    } else {
      throw Exception('Failed to download database: ${response.statusCode}');
    }
  }

  Future<bool> _hasDataToLoad() async {
    final dbPath =
        '${await _getAppDataPath()}/repacks.db'; // Use / for path segments
    if (!File(dbPath).existsSync()) {
      return false;
    }
    return await checkTablesNotEmpty();
  }

  Future<void> initializeDatabase() async {
    final dbPath = '${await _getAppDataPath()}/repacks.db';
    const dbUrl =
        'https://github.com/THR3ATB3AR/fit_flutter_assets/raw/refs/heads/main/repacks.db';

    if (!File(dbPath).existsSync()) {
      try {
        print("Database not found, downloading from $dbUrl");
        await _downloadDatabase(dbUrl, dbPath);
        print("Database downloaded successfully.");
      } catch (e) {
        print("Failed to download database: $e. Will create empty tables.");
        // If download fails, we proceed to create tables, so the app can still function with scraped data.
      }
    }

    final db = sqlite3.open(dbPath);

    db.execute('''
      CREATE TABLE IF NOT EXISTS new_repacks (
        title TEXT PRIMARY KEY, url TEXT, releaseDate TEXT, cover TEXT, genres TEXT,
        language TEXT, company TEXT, originalSize TEXT, repackSize TEXT,
        downloadLinks TEXT, repackFeatures TEXT, description TEXT, screenshots TEXT
      )
    ''');
    // ... (other table creations are identical) ...
    db.execute('''
      CREATE TABLE IF NOT EXISTS popular_repacks (
        title TEXT PRIMARY KEY, url TEXT, releaseDate TEXT, cover TEXT, genres TEXT,
        language TEXT, company TEXT, originalSize TEXT, repackSize TEXT,
        downloadLinks TEXT, repackFeatures TEXT, description TEXT, screenshots TEXT
      )
    ''');
    db.execute('''
      CREATE TABLE IF NOT EXISTS every_repack (
        title TEXT PRIMARY KEY, url TEXT, releaseDate TEXT, cover TEXT, genres TEXT,
        language TEXT, company TEXT, originalSize TEXT, repackSize TEXT,
        downloadLinks TEXT, repackFeatures TEXT, description TEXT, screenshots TEXT
      )
    ''');
    db.execute('''
      CREATE TABLE IF NOT EXISTS all_repacks_names (
        title TEXT PRIMARY KEY, url TEXT
      )
    ''');
    db.execute('''
      CREATE TABLE IF NOT EXISTS failed_repacks (
        title TEXT PRIMARY KEY, url TEXT
      )
    ''');
    db.dispose();
  }

  Future<void> loadRepacks() async {
    final dbPath = '${await _getAppDataPath()}/repacks.db';
    if (!File(dbPath).existsSync()) {
      print(
        "RepackService: Database file not found at $dbPath. Cannot load repacks.",
      );
      isDataLoadedInMemory = false;
      _controller.add(null);
      return;
    }

    final db = sqlite3.open(dbPath);
    try {
      final newRepacksResult = db.select('SELECT * FROM new_repacks');
      newRepacks =
          newRepacksResult.map((row) => Repack.fromSqlite(row)).toList();

      final popularRepacksResult = db.select('SELECT * FROM popular_repacks');
      popularRepacks =
          popularRepacksResult.map((row) => Repack.fromSqlite(row)).toList();

      final everyRepackResult = db.select('SELECT * FROM every_repack');
      everyRepack =
          everyRepackResult.map((row) => Repack.fromSqlite(row)).toList();
      everyRepack.sort(
        (a, b) => a.title.compareTo(b.title),
      ); // Ensure sorted on load

      final allRepacksNamesResult = db.select(
        'SELECT * FROM all_repacks_names',
      );
      allRepacksNames = {
        for (var row in allRepacksNamesResult)
          row['title'] as String: row['url'] as String,
      };

      final failedRepacksResult = db.select('SELECT * FROM failed_repacks');
      failedRepacks = {
        for (var row in failedRepacksResult)
          row['title'] as String: row['url'] as String,
      };

      isDataLoadedInMemory = true;
      print("Repacks loaded from database into memory.");
    } catch (e) {
      print("Error loading repacks from database: $e");
      isDataLoadedInMemory = false;
      // Clear lists on error to ensure consistent state
      newRepacks.clear();
      popularRepacks.clear();
      everyRepack.clear();
      allRepacksNames.clear();
      failedRepacks.clear();
    } finally {
      db.dispose();
    }
    _controller.add(null);
  }

  Future<void> saveNewRepackList() async {
    final db = sqlite3.open('${await _getAppDataPath()}/repacks.db');
    db.execute('BEGIN TRANSACTION');
    db.execute('DELETE FROM new_repacks');
    final stmt = db.prepare(
      'INSERT INTO new_repacks (title, url, releaseDate, cover, genres, language, company, originalSize, repackSize, downloadLinks, repackFeatures, description, screenshots) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)',
    );
    for (var repack in newRepacks) {
      stmt.execute(repack.toSqliteParams());
    }
    stmt.dispose();
    db.execute('COMMIT');
    db.dispose();
    isDataLoadedInMemory = true; // Data is now in memory and DB
    _controller.add(null);
    print("New repacks list saved to DB. Count: ${newRepacks.length}");
  }

  Future<void> savePopularRepackList() async {
    final db = sqlite3.open('${await _getAppDataPath()}/repacks.db');
    db.execute('BEGIN TRANSACTION');
    db.execute('DELETE FROM popular_repacks');
    final stmt = db.prepare(
      'INSERT INTO popular_repacks (title, url, releaseDate, cover, genres, language, company, originalSize, repackSize, downloadLinks, repackFeatures, description, screenshots) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)',
    );
    for (var repack in popularRepacks) {
      stmt.execute(repack.toSqliteParams());
    }
    stmt.dispose();
    db.execute('COMMIT');
    db.dispose();
    isDataLoadedInMemory = true;
    _controller.add(null);
    print("Popular repacks list saved to DB. Count: ${popularRepacks.length}");
  }

  Future<void> saveEveryRepackList() async {
    final db = sqlite3.open('${await _getAppDataPath()}/repacks.db');
    db.execute('BEGIN TRANSACTION');
    db.execute('DELETE FROM every_repack');
    final stmt = db.prepare(
      'INSERT INTO every_repack (title, url, releaseDate, cover, genres, language, company, originalSize, repackSize, downloadLinks, repackFeatures, description, screenshots) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)',
    );
    for (var repack in everyRepack) {
      stmt.execute(repack.toSqliteParams());
    }
    stmt.dispose();
    db.execute('COMMIT');
    db.dispose();
    isDataLoadedInMemory = true;
    _controller.add(null);
    print("EveryRepack list saved to DB. Count: ${everyRepack.length}");
  }

  Future<void> saveSingleEveryRepack(Repack repack) async {
    // Check if repack already exists by URL (primary unique content identifier)
    // or Title (primary key in DB) to avoid duplicates if this is called multiple times
    // For now, assume scrapeMissingRepacks logic prevents adding duplicates to everyRepack list.
    if (everyRepack.any((r) => r.url == repack.url)) {
      // Optional: Update if found, or just skip
      // print("Repack ${repack.title} already in everyRepack list, skipping saveSingle or updating.");
      // To update: remove old, add new, then save to DB.
      // everyRepack.removeWhere((r) => r.url == repack.url);
      // everyRepack.add(repack);
      // For simplicity, this function assumes it's a new one to be added to DB.
    }

    final db = sqlite3.open('${await _getAppDataPath()}/repacks.db');
    // Use INSERT OR REPLACE to handle cases where a title might already exist
    final stmt = db.prepare(
      'INSERT OR REPLACE INTO every_repack (title, url, releaseDate, cover, genres, language, company, originalSize, repackSize, downloadLinks, repackFeatures, description, screenshots) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)',
    );
    stmt.execute(repack.toSqliteParams());
    stmt.dispose();
    db.dispose();
    // No need to set isDataLoadedInMemory = true here as this is for single additions
    _controller.add(null); // Notify UI of change
  }

  Future<void> saveAllRepackList() async {
    final db = sqlite3.open('${await _getAppDataPath()}/repacks.db');
    db.execute('BEGIN TRANSACTION');
    db.execute('DELETE FROM all_repacks_names');
    final stmt = db.prepare(
      'INSERT INTO all_repacks_names (title, url) VALUES (?, ?)',
    );
    for (var entry in allRepacksNames.entries) {
      stmt.execute([entry.key, entry.value]);
    }
    stmt.dispose();
    db.execute('COMMIT');
    db.dispose();
    // isDataLoadedInMemory is more about full data sets like new/popular/every
    _controller.add(null);
    print("All repacks names saved to DB. Count: ${allRepacksNames.length}");
  }

  Future<void> deleteFailedRepacksFromAllRepackNames() async {
    if (failedRepacks.isEmpty) return;
    final db = sqlite3.open('${await _getAppDataPath()}/repacks.db');
    db.execute('BEGIN TRANSACTION');
    final stmt = db.prepare('DELETE FROM all_repacks_names WHERE url = ?');
    for (var url in failedRepacks.values) {
      stmt.execute([url]);
    }
    stmt.dispose();
    db.execute('COMMIT');
    db.dispose();
    // Also remove from in-memory allRepacksNames
    for (var failedUrl in failedRepacks.values) {
      allRepacksNames.removeWhere((title, url) => url == failedUrl);
    }
    _controller.add(null);
    print(
      "Failed repacks deleted from all_repacks_names. Count: ${failedRepacks.length}",
    );
  }

  Future<void> saveFailedRepack(String title, String url) async {
    final db = sqlite3.open('${await _getAppDataPath()}/repacks.db');
    final stmt = db.prepare(
      'INSERT OR IGNORE INTO failed_repacks (title, url) VALUES (?, ?)',
    );
    stmt.execute([title, url]);
    stmt.dispose();
    db.dispose();
    failedRepacks[title] = url; // Ensure in-memory map is updated
    _controller.add(null);
  }

  Future<bool> checkTablesNotEmpty() async {
    final db = sqlite3.open('${await _getAppDataPath()}/repacks.db');
    // Check if at least one of the core data tables has data,
    // or if all_repacks_names has data, indicating a previous scrape attempt.
    final tablesToPotentiallyHaveData = [
      'new_repacks',
      'popular_repacks',
      'every_repack',
      'all_repacks_names',
    ];
    bool hasAnyData = false;
    for (var table in tablesToPotentiallyHaveData) {
      final result = db.select('SELECT COUNT(*) AS count FROM $table');
      if (result.first['count'] as int > 0) {
        hasAnyData = true;
        break;
      }
    }
    db.dispose();
    return hasAnyData;
  }

  Future<void> clearAllTables() async {
    // Renamed from forceClearAllData for clarity if used by settings
    final db = sqlite3.open('${await _getAppDataPath()}/repacks.db');
    // This is the original clearAllTables, less destructive than forceClearAllData
    final tablesToClear = [
      'new_repacks',
      'popular_repacks',
      'all_repacks_names',
    ]; // Does not clear 'every_repack' or 'failed_repacks'

    db.execute('BEGIN TRANSACTION');
    for (var table in tablesToClear) {
      db.execute('DELETE FROM $table');
    }
    db.execute('COMMIT');
    db.dispose();

    newRepacks.clear();
    popularRepacks.clear();
    // everyRepack.clear(); // Not cleared by this function
    allRepacksNames.clear();
    // failedRepacks.clear(); // Not cleared

    // If everyRepack is not cleared, isDataLoadedInMemory might still be true if everyRepack had data.
    // This function's original intent seemed to be for a partial clear.
    // For settings "force delete", a more comprehensive clear is needed.
    // Let's assume this function keeps its original scope.
    // If new/popular/allnames are empty, but everyRepack has data, isDataLoadedInMemory should reflect that.
    isDataLoadedInMemory = everyRepack.isNotEmpty;

    _controller.add(null);
    print("Cleared new_repacks, popular_repacks, all_repacks_names.");
  }

  Future<void> forceClearAllData() async {
    // This is the comprehensive clear for the settings "Force Rescrape"
    final dbPath = '${await _getAppDataPath()}/repacks.db';
    final db = sqlite3.open(dbPath);
    final tables = [
      'new_repacks',
      'popular_repacks',
      'every_repack',
      'all_repacks_names',
      'failed_repacks',
    ];
    db.execute('BEGIN TRANSACTION');
    for (var table in tables) {
      db.execute('DELETE FROM $table');
    }
    db.execute('COMMIT');
    db.dispose();

    newRepacks.clear();
    popularRepacks.clear();
    everyRepack.clear();
    allRepacksNames.clear();
    failedRepacks.clear();
    isDataLoadedInMemory = false; // All data is gone

    _controller.add(null);
    print("All repack data forcefully cleared from DB and memory.");
  }

  Future<String> _getAppDataPath() async {
    final appDataDir = await getApplicationSupportDirectory();
    // Use platform-agnostic path joining if possible, but this is common for Windows.
    // For cross-platform, consider the 'path' package.
    final directoryPath =
        '${appDataDir.path}${Platform.pathSeparator}FitFlutter${Platform.pathSeparator}cache';
    final directory = Directory(directoryPath);
    if (!await directory.exists()) {
      await directory.create(recursive: true);
    }
    return directory.path;
  }

  void notifyListeners() {
    _controller.add(null);
  }
}
