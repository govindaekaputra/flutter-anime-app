import 'package:anime_app/common/constant.dart';
import 'package:anime_app/common/failure.dart';
import 'package:anime_app/domain/entities/anime.dart';
import 'package:anime_app/domain/entities/character.dart';
import 'package:anime_app/domain/entities/favorite_anime.dart';
import 'package:anime_app/domain/entities/genre.dart';
import 'package:anime_app/domain/entities/recommendation.dart';
import 'package:dartz/dartz.dart';

abstract class AnimeRepository {
  Future<Either<Failure, List<Anime>>> getTopAnime(
      {required AnimeType animeType, int? page, int? limit});
  Future<Either<Failure, List<Anime>>> getSeasonAnime(
      {required AnimeSeason animeSeason, int? page, int? limit});
  Future<Either<Failure, List<Anime>>> getSearchAnime({
    String? keyword,
    List<int>? genres,
    AnimeType? animeType,
    AnimeStatus? animeStatus,
    AnimeRating? animeRating,
    int? page,
    int? limit,
  });
  Future<Either<Failure, List<Genre>>> getGenresAnime();
  Future<Either<Failure, Anime>> getAnimeById({required int id});
  Future<Either<Failure, List<Character>>> getAnimeCharactersByAnimeId(
      {required int id});
  Future<Either<Failure, List<Recommendation>>>
      getAnimeRecommendationsByAnimeId({required int id});
  Future<Either<Failure, String>> insertFavorite(
      {required FavoriteAnime favoriteAnime});
  Future<Either<Failure, String>> removeFavorite({required int id});
  Future<bool> isAddedToFavorite({required int id});
  Future<Either<Failure, List<FavoriteAnime>>> getFavorites({
    int? page,
    int? limit,
  });
}
