import 'dart:async';
import 'dart:convert';
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
    await initializeDatabase(); // Ensures DB file exists and tables are created
    // Only load from DB if not already in memory.
    // This is crucial for preventing reloads on every RepackSlider init.
    if (!isDataLoadedInMemory && (await _hasDataToLoad())) {
      await loadRepacks();
    } else if (isDataLoadedInMemory) {
      // If data is already in memory, ensure listeners are notified
      // in case the init is called and UI expects an update.
      _controller.add(null);
    }
  }

  Future<void> _downloadDatabase(String url, String savePath) async {
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      final file = File(savePath);
      await file.writeAsBytes(response.bodyBytes);
    } else {
      throw Exception('Failed to download database');
    }
  }

  Future<bool> _hasDataToLoad() async {
    final dbPath = '${await _getAppDataPath()}\\repacks.db';
    if (!File(dbPath).existsSync()) {
        return false; 
    }
    return await checkTablesNotEmpty();
  }

  Future<void> initializeDatabase() async {
    final dbPath = '${await _getAppDataPath()}\\repacks.db';
    const dbUrl =
        'https://github.com/THR3ATB3AR/fit_flutter_assets/raw/refs/heads/main/repacks.db';

    // Sprawdź, czy plik bazy danych już istnieje
    if (!File(dbPath).existsSync()) {
      // Pobierz bazę danych z URL-a
      await _downloadDatabase(dbUrl, dbPath);
    }

    final db = sqlite3.open(dbPath);

    // Sprawdź, czy tabele istnieją i utwórz je, jeśli nie istnieją
    db.execute('''
      CREATE TABLE IF NOT EXISTS new_repacks (
        title TEXT PRIMARY KEY,
        url TEXT,
        releaseDate TEXT,
        cover TEXT,
        genres TEXT,
        language TEXT,
        company TEXT,
        originalSize TEXT,
        repackSize TEXT,
        downloadLinks TEXT,
        repackFeatures TEXT,
        description TEXT,
        screenshots TEXT
      )
    ''');

    db.execute('''
      CREATE TABLE IF NOT EXISTS popular_repacks (
        title TEXT PRIMARY KEY,
        url TEXT,
        releaseDate TEXT,
        cover TEXT,
        genres TEXT,
        language TEXT,
        company TEXT,
        originalSize TEXT,
        repackSize TEXT,
        downloadLinks TEXT,
        repackFeatures TEXT,
        description TEXT,
        screenshots TEXT
      )
    ''');

    db.execute('''
      CREATE TABLE IF NOT EXISTS every_repack (
        title TEXT PRIMARY KEY,
        url TEXT,
        releaseDate TEXT,
        cover TEXT,
        genres TEXT,
        language TEXT,
        company TEXT,
        originalSize TEXT,
        repackSize TEXT,
        downloadLinks TEXT,
        repackFeatures TEXT,
        description TEXT,
        screenshots TEXT
      )
    ''');

    db.execute('''
      CREATE TABLE IF NOT EXISTS all_repacks_names (
        title TEXT PRIMARY KEY,
        url TEXT
      )
    ''');

    db.execute('''
      CREATE TABLE IF NOT EXISTS failed_repacks (
        title TEXT PRIMARY KEY,
        url TEXT
      )
    ''');

    db.dispose();
  }

  Future<void> loadRepacks() async {
    final dbPath = '${await _getAppDataPath()}\\repacks.db';
    if (!File(dbPath).existsSync()) {
      print("RepackService: Database file not found at $dbPath. Cannot load repacks.");
      isDataLoadedInMemory = false; // Ensure flag is false
      _controller.add(null); // Notify listeners (e.g., to show empty state)
      return;
    }

    final db = sqlite3.open(dbPath);
    try {
      final newRepacksResult = db.select('SELECT * FROM new_repacks');
      final popularRepacksResult = db.select('SELECT * FROM popular_repacks');
      final everyRepackResult = db.select('SELECT * FROM every_repack');
      final allRepacksNamesResult = db.select('SELECT * FROM all_repacks_names');
      final failedRepacksResult = db.select('SELECT * FROM failed_repacks');

      newRepacks = newRepacksResult.map((row) => Repack.fromSqlite(row)).toList();
      popularRepacks =
          popularRepacksResult.map((row) => Repack.fromSqlite(row)).toList();
      everyRepack =
          everyRepackResult.map((row) => Repack.fromSqlite(row)).toList();
      allRepacksNames = {
        for (var row in allRepacksNamesResult)
          row['title'] as String: row['url'] as String
      };
      failedRepacks = {
        for (var row in failedRepacksResult)
          row['title'] as String: row['url'] as String
      };

      isDataLoadedInMemory = true; // Data is now in memory
    } catch (e) {
      print("Error loading repacks from database: $e");
      isDataLoadedInMemory = false; // Reset flag on error
      // Optionally clear lists
      newRepacks.clear();
      popularRepacks.clear();
      // ... etc.
    } finally {
      db.dispose();
    }
    _controller.add(null); // Notify listeners
  }

  Future<void> saveNewRepackList() async {
    final db = sqlite3.open('${await _getAppDataPath()}\\repacks.db');
    db.execute('DELETE FROM new_repacks');
    final stmt = db.prepare(
        'INSERT INTO new_repacks VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)');

    for (var repack in newRepacks) {
      stmt.execute([
        repack.title,
        repack.url,
        repack.releaseDate.toIso8601String(),
        repack.cover,
        repack.genres,
        repack.language,
        repack.company,
        repack.originalSize,
        repack.repackSize,
        jsonEncode(repack.downloadLinks),
        repack.repackFeatures,
        repack.description,
        jsonEncode(repack.screenshots)
      ]);
    }

    stmt.dispose();
    db.dispose();
    isDataLoadedInMemory = true; // Ensure it's true as data is now in memory and DB
    _controller.add(null);
  }

  Future<void> savePopularRepackList() async {
    final db = sqlite3.open('${await _getAppDataPath()}\\repacks.db');
    db.execute('DELETE FROM popular_repacks');
    final stmt = db.prepare(
        'INSERT INTO popular_repacks VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)');

    for (var repack in popularRepacks) {
      print("Saving popular repack: ${repack.title}");
      stmt.execute([
        repack.title,
        repack.url,
        repack.releaseDate.toIso8601String(),
        repack.cover,
        repack.genres,
        repack.language,
        repack.company,
        repack.originalSize,
        repack.repackSize,
        jsonEncode(repack.downloadLinks),
        repack.repackFeatures,
        repack.description,
        jsonEncode(repack.screenshots)
      ]);
    }

    stmt.dispose();
    db.dispose();
    isDataLoadedInMemory = true;
    _controller.add(null);
  }

  Future<void> saveEveryRepackList() async {
    final db = sqlite3.open('${await _getAppDataPath()}\\repacks.db');
    db.execute('DELETE FROM every_repack');
    final stmt = db.prepare(
        'INSERT INTO every_repack VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)');

    for (var repack in everyRepack) {
      stmt.execute([
        repack.title,
        repack.url,
        repack.releaseDate.toIso8601String(),
        repack.cover,
        repack.genres,
        repack.language,
        repack.company,
        repack.originalSize,
        repack.repackSize,
        jsonEncode(repack.downloadLinks),
        repack.repackFeatures,
        repack.description,
        jsonEncode(repack.screenshots)
      ]);
    }

    stmt.dispose();
    db.dispose();
    _controller.add(null);
  }

  Future<void> saveSingleEveryRepack(Repack repack) async {
    final db = sqlite3.open('${await _getAppDataPath()}\\repacks.db');
    final stmt = db.prepare(
        'INSERT INTO every_repack VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)');

    stmt.execute([
      repack.title,
      repack.url,
      repack.releaseDate.toIso8601String(),
      repack.cover,
      repack.genres,
      repack.language,
      repack.company,
      repack.originalSize,
      repack.repackSize,
      jsonEncode(repack.downloadLinks),
      repack.repackFeatures,
      repack.description,
      jsonEncode(repack.screenshots)
    ]);

    stmt.dispose();
    db.dispose();
    _controller.add(null);
  }

  Future<void> saveAllRepackList() async {
    final db = sqlite3.open('${await _getAppDataPath()}\\repacks.db');
    db.execute('DELETE FROM all_repacks_names');
    final stmt = db.prepare('INSERT INTO all_repacks_names VALUES (?, ?)');

    for (var entry in allRepacksNames.entries) {
      stmt.execute([entry.key, entry.value]);
    }

    stmt.dispose();
    db.dispose();
    _controller.add(null);
  }

  Future<void> deleteFailedRepacksFromAllRepackNames() async {
    final db = sqlite3.open('${await _getAppDataPath()}\\repacks.db');
    final stmt = db.prepare('DELETE FROM all_repacks_names WHERE url = ?');

    for (var url in failedRepacks.values) {
      stmt.execute([url]);
    }

    stmt.dispose();
    db.dispose();
    _controller.add(null);
  }

  Future<void> saveFailedRepack(String title, String url) async {
    final db = sqlite3.open('${await _getAppDataPath()}\\repacks.db');
    final stmt = db.prepare('INSERT INTO failed_repacks VALUES (?, ?)');

    stmt.execute([title, url]);

    stmt.dispose();
    db.dispose();
    _controller.add(null);
  }

  Future<bool> checkTablesNotEmpty() async {
    final db = sqlite3.open('${await _getAppDataPath()}\\repacks.db');
    final tables = [
      'new_repacks',
      'popular_repacks',
      'every_repack',
      'all_repacks_names'
    ];

    for (var table in tables) {
      final result = db.select('SELECT COUNT(*) AS count FROM $table');
      if (result.first['count'] == 0) {
        db.dispose();
        return false;
      }
    }

    db.dispose();
    return true;
  }

  Future<void> clearAllTables() async {
    final db = sqlite3.open('${await _getAppDataPath()}\\repacks.db');
    final tables = ['new_repacks', 'popular_repacks', 'all_repacks_names'];

    for (var table in tables) {
      db.execute('DELETE FROM $table');
    }
    newRepacks.clear();
    popularRepacks.clear();
    everyRepack.clear();
    allRepacksNames.clear();
    isDataLoadedInMemory = false;
    db.dispose();
    _controller.add(null);
  }

  Future<String> _getAppDataPath() async {
    final appDataDir = await getApplicationSupportDirectory();
    final directory = Directory('${appDataDir.path}\\FitFlutter\\cache');
    if (!await directory.exists()) {
      await directory.create(recursive: true);
    }
    return directory.path;
  }

  void notifyListeners() {
    _controller.add(null);
  }
}
