import 'dart:io';

import 'package:anime_app/common/constant.dart';
import 'package:anime_app/common/exception.dart';
import 'package:anime_app/common/failure.dart';
import 'package:anime_app/data/datasources/anime_local_data_source.dart';
import 'package:anime_app/data/datasources/anime_remote_data_source.dart';
import 'package:anime_app/data/models/favorite_anime_table.dart';
import 'package:anime_app/domain/entities/anime.dart';
import 'package:anime_app/domain/entities/character.dart';
import 'package:anime_app/domain/entities/favorite_anime.dart';
import 'package:anime_app/domain/entities/genre.dart';
import 'package:anime_app/domain/entities/recommendation.dart';
import 'package:anime_app/domain/repositories/anime_respository.dart';
import 'package:dartz/dartz.dart';

class AnimeRepositoryImpl implements AnimeRepository {
  final AnimeRemoteDataSource animeRemoteDataSource;
  final AnimeLocalDataSource animeLocalDataSource;

  const AnimeRepositoryImpl({
    required this.animeRemoteDataSource,
    required this.animeLocalDataSource,
  });

  @override
  Future<Either<Failure, Anime>> getAnimeById({required int id}) async {
    try {
      final result = await animeRemoteDataSource.getAnimeById(id: id);
      return Right(result.toEntity());
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message.toString()));
    } on SocketException {
      return const Left(ConnectionFailure('Failed to connect to the network'));
    }
  }

  @override
  Future<Either<Failure, List<Character>>> getAnimeCharactersByAnimeId(
      {required int id}) async {
    try {
      final result =
          await animeRemoteDataSource.getAnimeCharactersByAnimeId(id: id);
      return Right(result.map((e) => e.toEntity()).toList());
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message.toString()));
    } on SocketException {
      return const Left(ConnectionFailure('Failed to connect to the network'));
    }
  }

  @override
  Future<Either<Failure, List<Recommendation>>>
      getAnimeRecommendationsByAnimeId({required int id}) async {
    try {
      final result =
          await animeRemoteDataSource.getAnimeRecommendationsByAnimeId(id: id);
      return Right(result.map((e) => e.toEntity()).toList());
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message.toString()));
    } on SocketException {
      return const Left(ConnectionFailure('Failed to connect to the network'));
    }
  }

  @override
  Future<Either<Failure, List<FavoriteAnime>>> getFavorites({
    int? page,
    int? limit,
  }) async {
    try {
      final result = await animeLocalDataSource.getFavorites(
        page: page,
        limit: limit,
      );
      return Right(result.map((e) => e.toEntity()).toList());
    } on DatabaseException catch (e) {
      return Left(DatabaseFailure(e.message));
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<Either<Failure, List<Genre>>> getGenresAnime() async {
    try {
      final result = await animeRemoteDataSource.getGenresAnime();
      return Right(result.map((e) => e.toEntity()).toList());
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message.toString()));
    } on SocketException {
      return const Left(ConnectionFailure('Failed to connect to the network'));
    }
  }

  @override
  Future<Either<Failure, List<Anime>>> getSearchAnime({
    String? keyword,
    List<int>? genres,
    AnimeType? animeType,
    AnimeStatus? animeStatus,
    AnimeRating? animeRating,
    int? page,
    int? limit,
  }) async {
    try {
      final result = await animeRemoteDataSource.getSearchAnime(
        keyword: keyword,
        genres: genres,
        animeType: animeType,
        animeStatus: animeStatus,
        animeRating: animeRating,
        page: page,
        limit: limit,
      );
      return Right(result.map((e) => e.toEntity()).toList());
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message.toString()));
    } on SocketException {
      return const Left(ConnectionFailure('Failed to connect to the network'));
    }
  }

  @override
  Future<Either<Failure, List<Anime>>> getSeasonAnime({
    required AnimeSeason animeSeason,
    int? page,
    int? limit,
  }) async {
    try {
      final result = await animeRemoteDataSource.getSeasonAnime(
        animeSeason: animeSeason,
        page: page,
        limit: limit,
      );
      return Right(result.map((e) => e.toEntity()).toList());
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message.toString()));
    } on SocketException {
      return const Left(ConnectionFailure('Failed to connect to the network'));
    }
  }

  @override
  Future<Either<Failure, List<Anime>>> getTopAnime({
    required AnimeType animeType,
    int? page,
    int? limit,
  }) async {
    try {
      final result = await animeRemoteDataSource.getTopAnime(
        animeType: animeType,
        page: page,
        limit: limit,
      );
      return Right(result.map((e) => e.toEntity()).toList());
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message.toString()));
    } on SocketException {
      return const Left(ConnectionFailure('Failed to connect to the network'));
    }
  }

  @override
  Future<Either<Failure, String>> insertFavorite(
      {required FavoriteAnime favoriteAnime}) async {
    try {
      await animeLocalDataSource.insertFavorite(
          favoriteAnime: FavoriteAnimeTable.fromEntity(favoriteAnime));
      return const Right('');
    } on DatabaseException catch (e) {
      return Left(DatabaseFailure(e.message));
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<bool> isAddedToFavorite({required int id}) async {
    final result = await animeLocalDataSource.getFavoriteById(id: id);
    return result != null;
  }

  @override
  Future<Either<Failure, String>> removeFavorite({required int id}) async {
    try {
      await animeLocalDataSource.removeFavorite(id: id);
      return const Right('');
    } on DatabaseException catch (e) {
      return Left(DatabaseFailure(e.message));
    } catch (e) {
      rethrow;
    }
  }
}
