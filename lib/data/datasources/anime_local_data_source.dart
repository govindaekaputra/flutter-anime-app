import 'package:anime_app/common/exception.dart';
import 'package:anime_app/data/datasources/db/database_helper.dart';
import 'package:anime_app/data/models/favorite_anime_table.dart';

abstract class AnimeLocalDataSource {
  Future<void> insertFavorite({required FavoriteAnimeTable favoriteAnime});
  Future<void> removeFavorite({required int id});
  Future<FavoriteAnimeTable?> getFavoriteById({required int id});
  Future<List<FavoriteAnimeTable>> getFavorites({
    int? page,
    int? limit,
  });
}

class AnimeLocalDataSourceImpl implements AnimeLocalDataSource {
  final DatabaseHelper databaseHelper;

  const AnimeLocalDataSourceImpl({required this.databaseHelper});

  @override
  Future<FavoriteAnimeTable?> getFavoriteById({required int id}) async {
    final result = await databaseHelper.getFavoriteById(id);
    if (result != null) {
      return FavoriteAnimeTable.fromJson(result);
    } else {
      return null;
    }
  }

  @override
  Future<List<FavoriteAnimeTable>> getFavorites({int? page, int? limit}) async {
    final result = await databaseHelper.getFavorites(
      page: page,
      limit: limit,
    );
    return result.map((e) => FavoriteAnimeTable.fromJson(e)).toList();
  }

  @override
  Future<void> insertFavorite(
      {required FavoriteAnimeTable favoriteAnime}) async {
    try {
      await databaseHelper.insertFavorite(favoriteAnime);
    } catch (e) {
      throw DatabaseException(e.toString());
    }
  }

  @override
  Future<void> removeFavorite({required int id}) async {
    try {
      await databaseHelper.removeFavorite(id);
    } catch (e) {
      throw DatabaseException(e.toString());
    }
  }
}
