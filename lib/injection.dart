import 'package:anime_app/data/datasources/anime_local_data_source.dart';
import 'package:anime_app/data/datasources/anime_remote_data_source.dart';
import 'package:anime_app/data/datasources/db/database_helper.dart';
import 'package:anime_app/data/repositories/anime_repository_impl.dart';
import 'package:anime_app/domain/repositories/anime_respository.dart';
import 'package:anime_app/domain/usecases/get_anime_by_id.dart';
import 'package:anime_app/domain/usecases/get_anime_characters_by_anime_id.dart';
import 'package:anime_app/domain/usecases/get_anime_recommendations_by_anime_id.dart';
import 'package:anime_app/domain/usecases/get_favorite_anime.dart';
import 'package:anime_app/domain/usecases/get_favorite_anime_status.dart';
import 'package:anime_app/domain/usecases/get_genres_anime.dart';
import 'package:anime_app/domain/usecases/get_season_anime.dart';
import 'package:anime_app/domain/usecases/get_top_anime.dart';
import 'package:anime_app/domain/usecases/remove_favorite_anime.dart';
import 'package:anime_app/domain/usecases/save_favorite_anime.dart';
import 'package:anime_app/domain/usecases/search_anime.dart';
import 'package:anime_app/presentation/providers/anime_detail_provider.dart';
import 'package:anime_app/presentation/providers/anime_list_provider.dart';
import 'package:anime_app/presentation/providers/favorite_anime_list_provider.dart';
import 'package:anime_app/presentation/providers/genres_anime_provider.dart';
import 'package:anime_app/presentation/providers/search_anime_provider.dart';
import 'package:anime_app/presentation/providers/season_now_anime_list_provider.dart';
import 'package:anime_app/presentation/providers/season_upcoming_anime_list_provider.dart';
import 'package:anime_app/presentation/providers/top_movies_anime_list_provider.dart';
import 'package:anime_app/presentation/providers/top_series_anime_list_provider.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;

final locator = GetIt.instance;

void init() {
  // provider
  locator.registerFactory(
    () => AnimeListProvider(
      getTopAnime: locator(),
      getSeasonAnime: locator(),
    ),
  );
  locator.registerFactory(
    () => TopSeriesAnimeListProvider(
      getTopAnime: locator(),
    ),
  );
  locator.registerFactory(
    () => TopMoviesAnimeListProvider(
      getTopAnime: locator(),
    ),
  );
  locator.registerFactory(
    () => SeasonNowAnimeListProvider(
      getSeasonAnime: locator(),
    ),
  );
  locator.registerFactory(
    () => SeasonUpcomingAnimeListProvider(
      getSeasonAnime: locator(),
    ),
  );
  locator.registerFactory(
    () => AnimeDetailProvider(
      getAnimeById: locator(),
      getAnimeCharactersByAnimeId: locator(),
      getAnimeRecommendationsByAnimeId: locator(),
      saveFavoriteAnime: locator(),
      removeFavoriteAnime: locator(),
      getFavoriteAnimeStatus: locator(),
    ),
  );
  locator.registerFactory(
    () => FavoriteAnimeListProvider(
      getFavoriteAnime: locator(),
    ),
  );
  locator.registerFactory(
    () => GenresAnimeProvider(
      getGenresAnime: locator(),
    ),
  );
  locator.registerFactory(
    () => SearchAnimeProvider(
      searchAnime: locator(),
    ),
  );

  // use case
  locator.registerLazySingleton(
    () => GetTopAnime(
      animeRepository: locator(),
    ),
  );
  locator.registerLazySingleton(
    () => GetSeasonAnime(
      animeRepository: locator(),
    ),
  );
  locator.registerLazySingleton(
    () => GetAnimeById(
      animeRepository: locator(),
    ),
  );
  locator.registerLazySingleton(
    () => GetAnimeCharactersByAnimeId(
      animeRepository: locator(),
    ),
  );
  locator.registerLazySingleton(
    () => GetAnimeRecommendationsByAnimeId(
      animeRepository: locator(),
    ),
  );
  locator.registerLazySingleton(
    () => SaveFavoriteAnime(
      animeRepository: locator(),
    ),
  );
  locator.registerLazySingleton(
    () => RemoveFavoriteAnime(
      animeRepository: locator(),
    ),
  );
  locator.registerLazySingleton(
    () => GetFavoriteAnimeStatus(
      animeRepository: locator(),
    ),
  );
  locator.registerLazySingleton(
    () => GetFavoriteAnime(
      animeRepository: locator(),
    ),
  );
  locator.registerLazySingleton(
    () => GetGenresAnime(
      animeRepository: locator(),
    ),
  );
  locator.registerLazySingleton(
    () => SearchAnime(
      animeRepository: locator(),
    ),
  );

  // repository
  locator.registerLazySingleton<AnimeRepository>(
    () => AnimeRepositoryImpl(
      animeRemoteDataSource: locator(),
      animeLocalDataSource: locator(),
    ),
  );

  // data sources
  locator.registerLazySingleton<AnimeRemoteDataSource>(
    () => AnimeRemoteDataSourceImpl(
      client: locator(),
    ),
  );
  locator.registerLazySingleton<AnimeLocalDataSource>(
    () => AnimeLocalDataSourceImpl(
      databaseHelper: locator(),
    ),
  );

  // external
  locator.registerLazySingleton(() => http.Client());

  // helper
  locator.registerLazySingleton(() => DatabaseHelper());
}
