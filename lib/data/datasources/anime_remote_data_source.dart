import 'dart:convert';

import 'package:anime_app/common/constant.dart';
import 'package:anime_app/common/exception.dart';
import 'package:anime_app/data/models/anime_detail_response.dart';
import 'package:anime_app/data/models/anime_list_response.dart';
import 'package:anime_app/data/models/character_list_response.dart';
import 'package:anime_app/data/models/character_model.dart';
import 'package:anime_app/data/models/genre_list_response.dart';
import 'package:anime_app/data/models/genre_model.dart';
import 'package:anime_app/data/models/recommendation_list_response.dart';
import 'package:anime_app/data/models/recommendation_model.dart';
import 'package:http/http.dart' as http;

import 'package:anime_app/data/models/anime_model.dart';

abstract class AnimeRemoteDataSource {
  Future<List<AnimeModel>> getTopAnime({
    required AnimeType animeType,
    int? page,
    int? limit,
  });
  Future<List<AnimeModel>> getSeasonAnime({
    required AnimeSeason animeSeason,
    int? page,
    int? limit,
  });
  Future<List<AnimeModel>> getSearchAnime({
    String? keyword,
    List<int>? genres,
    AnimeType? animeType,
    AnimeStatus? animeStatus,
    AnimeRating? animeRating,
    int? page,
    int? limit,
  });
  Future<List<GenreModel>> getGenresAnime();
  Future<AnimeModel> getAnimeById({required int id});
  Future<List<CharacterModel>> getAnimeCharactersByAnimeId({required int id});
  Future<List<RecommendationModel>> getAnimeRecommendationsByAnimeId(
      {required int id});
}

class AnimeRemoteDataSourceImpl implements AnimeRemoteDataSource {
  static const baseUrl = 'https://api.jikan.moe/v4';
  final http.Client client;

  AnimeRemoteDataSourceImpl({required this.client});

  @override
  Future<AnimeModel> getAnimeById({required int id}) async {
    final response = await client.get(Uri.parse('$baseUrl/anime/$id'));
    final result = json.decode(response.body);
    if (response.statusCode == 200) {
      return AnimeDetailResponse.fromJson(result).data;
    } else {
      throw ServerException(message: result['message']);
    }
  }

  @override
  Future<List<AnimeModel>> getSearchAnime({
    String? keyword,
    List<int>? genres,
    AnimeType? animeType,
    AnimeStatus? animeStatus,
    AnimeRating? animeRating,
    int? page,
    int? limit,
  }) async {
    final url =
        '$baseUrl/anime?q=${keyword ?? ""}&genres=${genres?.join(",").toString() ?? ""}${animeType != null ? '&type=${animeType.name}' : ''}${animeStatus != null ? '&status=${animeStatus.name}' : ''}${animeRating != null ? '&rating=${animeRating.name}' : ''}&page=${page ?? 1}&limit=${limit ?? 10}';
    final response = await client.get(Uri.parse(url));
    final result = json.decode(response.body);
    if (response.statusCode == 200) {
      return AnimeListResponse.fromJson(result).data;
    } else {
      throw ServerException(message: result['message']);
    }
  }

  @override
  Future<List<AnimeModel>> getSeasonAnime({
    required AnimeSeason animeSeason,
    int? page,
    int? limit,
  }) async {
    final response = await client.get(Uri.parse(
        '$baseUrl/seasons/${animeSeason.name}?page=${page ?? 1}&limit=${limit ?? 10}'));
    final result = json.decode(response.body);
    if (response.statusCode == 200) {
      return AnimeListResponse.fromJson(result).data;
    } else {
      throw ServerException(message: result['message']);
    }
  }

  @override
  Future<List<AnimeModel>> getTopAnime(
      {required AnimeType animeType, int? page, int? limit}) async {
    final response = await client.get(Uri.parse(
        '$baseUrl/top/anime?type=${animeType.name}&page=${page ?? 1}&limit=${limit ?? 10}'));
    final result = json.decode(response.body);
    if (response.statusCode == 200) {
      return AnimeListResponse.fromJson(result).data;
    } else {
      throw ServerException(message: result['message']);
    }
  }

  @override
  Future<List<GenreModel>> getGenresAnime() async {
    final response =
        await client.get(Uri.parse('$baseUrl/genres/anime?filter=genres'));
    final result = json.decode(response.body);
    if (response.statusCode == 200) {
      return GenreListResponse.fromJson(result).data;
    } else {
      throw ServerException(message: result['message']);
    }
  }

  @override
  Future<List<CharacterModel>> getAnimeCharactersByAnimeId(
      {required int id}) async {
    final response =
        await client.get(Uri.parse('$baseUrl/anime/$id/characters'));
    final result = json.decode(response.body);
    if (response.statusCode == 200) {
      return CharacterListResponse.fromJson(result).data;
    } else {
      throw ServerException(message: result['message']);
    }
  }

  @override
  Future<List<RecommendationModel>> getAnimeRecommendationsByAnimeId(
      {required int id}) async {
    final response =
        await client.get(Uri.parse('$baseUrl/anime/$id/recommendations'));
    final result = json.decode(response.body);
    if (response.statusCode == 200) {
      return RecommendationListResponse.fromJson(result).data;
    } else {
      throw ServerException(message: result['message']);
    }
  }
}
