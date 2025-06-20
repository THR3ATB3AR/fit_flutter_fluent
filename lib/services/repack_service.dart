import 'dart:async';
import 'dart:io';
import 'package:fit_flutter_fluent/data/gog_game.dart';
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
  List<GogGame> gogGames = []; 

  bool isDataLoadedInMemory = false;

  Future<void> init() async {
    await initializeDatabase();
    if (!isDataLoadedInMemory && (await _hasDataToLoad())) {
      await loadRepacks();
    } else if (isDataLoadedInMemory) {
      _controller.add(null); 
    }
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
        '${await _getAppDataPath()}/repacks.db'; 
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
      }
    }

    final db = sqlite3.open(dbPath);

    db.execute('''
      CREATE TABLE IF NOT EXISTS new_repacks (
        title TEXT, url TEXT PRIMARY KEY, releaseDate TEXT, cover TEXT, genres TEXT,
        language TEXT, company TEXT, originalSize TEXT, repackSize TEXT,
        downloadLinks TEXT, updates TEXT, repackFeatures TEXT, description TEXT, screenshots TEXT
      )
    ''');
    db.execute('''
      CREATE TABLE IF NOT EXISTS popular_repacks (
        title TEXT, url TEXT PRIMARY KEY, releaseDate TEXT, cover TEXT, genres TEXT,
        language TEXT, company TEXT, originalSize TEXT, repackSize TEXT,
        downloadLinks TEXT, updates TEXT, repackFeatures TEXT, description TEXT, screenshots TEXT
      )
    ''');
    db.execute('''
      CREATE TABLE IF NOT EXISTS every_repack (
        title TEXT, url TEXT PRIMARY KEY, releaseDate TEXT, cover TEXT, genres TEXT,
        language TEXT, company TEXT, originalSize TEXT, repackSize TEXT,
        downloadLinks TEXT, updates TEXT, repackFeatures TEXT, description TEXT, screenshots TEXT
      )
    ''');
    db.execute('''
      CREATE TABLE IF NOT EXISTS all_repacks_names (
        title TEXT, url TEXT PRIMARY KEY
      )
    ''');
    db.execute('''
      CREATE TABLE IF NOT EXISTS failed_repacks (
        title TEXT, url TEXT PRIMARY KEY
      )
    ''');
    db.execute('''
    CREATE TABLE IF NOT EXISTS gog_games (
      id INTEGER PRIMARY KEY,
      title TEXT,
      slug TEXT,
      url TEXT,
      description TEXT,
      developer TEXT,
      publisher TEXT,
      updateDate TEXT,
      cover TEXT,
      genres TEXT,
      screenshots TEXT,
      languages TEXT,
      userRating INTEGER,
      windowsDownloadSize INTEGER
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
      );

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

      final gogGamesResult = db.select('SELECT * FROM gog_games');
      gogGames = gogGamesResult.map((row) => GogGame.fromSqlite(row)).toList();
      gogGames.sort((a, b) => a.title.compareTo(b.title));

      isDataLoadedInMemory = true;
      print("Repacks loaded from database into memory.");
    } catch (e) {
      print("Error loading repacks from database: $e");
      isDataLoadedInMemory = false;
      newRepacks.clear();
      popularRepacks.clear();
      everyRepack.clear();
      allRepacksNames.clear();
      failedRepacks.clear();
      gogGames.clear();
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
      'INSERT INTO new_repacks (title, url, releaseDate, cover, genres, language, company, originalSize, repackSize, downloadLinks, updates, repackFeatures, description, screenshots) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)',
    );
    for (var repack in newRepacks) {
      stmt.execute(repack.toSqliteParams());
    }
    stmt.dispose();
    db.execute('COMMIT');
    db.dispose();
    isDataLoadedInMemory = true; 
    _controller.add(null);
    print("New repacks list saved to DB. Count: ${newRepacks.length}");
  }

  Future<void> savePopularRepackList() async {
    final db = sqlite3.open('${await _getAppDataPath()}/repacks.db');
    db.execute('BEGIN TRANSACTION');
    db.execute('DELETE FROM popular_repacks');
    final stmt = db.prepare(
      'INSERT INTO popular_repacks (title, url, releaseDate, cover, genres, language, company, originalSize, repackSize, downloadLinks, updates, repackFeatures, description, screenshots) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)',
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
      'INSERT INTO every_repack (title, url, releaseDate, cover, genres, language, company, originalSize, repackSize, downloadLinks, updates, repackFeatures, description, screenshots) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)',
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
    if (everyRepack.any((r) => r.url == repack.url)) {
    }

    final db = sqlite3.open('${await _getAppDataPath()}/repacks.db');
    final stmt = db.prepare(
      'INSERT OR REPLACE INTO every_repack (title, url, releaseDate, cover, genres, language, company, originalSize, repackSize, downloadLinks, updates, repackFeatures, description, screenshots) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)',
    );
    stmt.execute(repack.toSqliteParams());
    stmt.dispose();
    db.dispose();
    _controller.add(null); 
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
    failedRepacks[title] = url; 
    _controller.add(null);
  }

  Future<void> saveGogGamesList() async { // <-- Pass the list as an argument
  final db = sqlite3.open('${await _getAppDataPath()}/repacks.db');
  db.execute('BEGIN TRANSACTION');
  db.execute('DELETE FROM gog_games');
  
  final stmt = db.prepare(
    '''
    INSERT INTO gog_games (
      id, title, slug, url, description, developer, publisher, updateDate, 
      cover, genres, screenshots, languages, userRating, windowsDownloadSize
    ) 
    VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)
    '''
  );
  
  for (var game in gogGames) {
    stmt.execute(game.toSqliteParams());
  }
  
  stmt.dispose();
  db.execute('COMMIT');
  db.dispose();
  
  gogGames.sort((a, b) => a.title.compareTo(b.title));
  isDataLoadedInMemory = true;
  notifyListeners();
  print("GOG games list saved to DB. Count: ${gogGames.length}");
}

  Future<bool> checkTablesNotEmpty() async {
    final db = sqlite3.open('${await _getAppDataPath()}/repacks.db');
    final tablesToPotentiallyHaveData = [
      'new_repacks',
      'popular_repacks',
      'every_repack',
      'all_repacks_names',
      'gog_games',
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
    final db = sqlite3.open('${await _getAppDataPath()}/repacks.db');
    final tablesToClear = [
      'new_repacks',
      'popular_repacks',
      'all_repacks_names',
      'gog_games',
    ]; 

    db.execute('BEGIN TRANSACTION');
    for (var table in tablesToClear) {
      db.execute('DELETE FROM $table');
    }
    db.execute('COMMIT');
    db.dispose();

    newRepacks.clear();
    popularRepacks.clear();
    allRepacksNames.clear();
    isDataLoadedInMemory = everyRepack.isNotEmpty;

    _controller.add(null);
    print("Cleared new_repacks, popular_repacks, all_repacks_names.");
  }

  Future<void> forceClearAllData() async {
    final dbPath = '${await _getAppDataPath()}/repacks.db';
    final db = sqlite3.open(dbPath);
    final tables = [
      'new_repacks',
      'popular_repacks',
      'every_repack',
      'all_repacks_names',
      'failed_repacks',
      'gog_games',
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
    gogGames.clear();
    isDataLoadedInMemory = false; 

    _controller.add(null);
    print("All repack data forcefully cleared from DB and memory.");
  }

  Future<String> _getAppDataPath() async {
    final appDataDir = await getApplicationSupportDirectory();
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
