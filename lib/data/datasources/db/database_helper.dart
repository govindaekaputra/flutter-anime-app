import 'package:anime_app/data/models/favorite_anime_table.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static DatabaseHelper? _databaseHelper;

  DatabaseHelper._instance() {
    _databaseHelper = this;
  }

  factory DatabaseHelper() => _databaseHelper ?? DatabaseHelper._instance();

  static const String _tblFavoriteAnime = 'favorite_anime';

  static Database? _database;

  Future<Database?> get database async {
    return _database ?? await _initDb();
  }

  Future<Database> _initDb() async {
    final path = await getDatabasesPath();
    final databasePath = '$path/anime.db';
    var db = await openDatabase(databasePath, version: 1, onCreate: _onCreate);
    return db;
  }

  Future _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE $_tblFavoriteAnime (
        mal_id INTEGER PRIMARY KEY,
        image_url TEXT,
        title TEXT,
        type TEXT,
        synopsis TEXT
      );
      ''');
  }

  Future<int> insertFavorite(FavoriteAnimeTable favoriteAnime) async {
    final db = await database;
    return await db!.insert(_tblFavoriteAnime, favoriteAnime.toJson());
  }

  Future<int> removeFavorite(int id) async {
    final db = await database;
    return await db!.delete(
      _tblFavoriteAnime,
      where: 'mal_id = ?',
      whereArgs: [id],
    );
  }

  Future<Map<String, dynamic>?> getFavoriteById(int id) async {
    final db = await database;
    final result = await db!.query(
      _tblFavoriteAnime,
      where: 'mal_id = ?',
      whereArgs: [id],
    );
    return result.isNotEmpty ? result.first : null;
  }

  Future<List<Map<String, dynamic>>> getFavorites({
    int? page,
    int? limit,
  }) async {
    final db = await database;
    final List<Map<String, dynamic>> results = await db!.query(
      _tblFavoriteAnime,
      limit: limit ?? 10,
      offset: page != null ? page - 1 : 0,
    );

    return results;
  }
}
