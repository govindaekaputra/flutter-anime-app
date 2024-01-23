import 'package:anime_app/common/constant.dart';
import 'package:anime_app/domain/entities/anime.dart';
import 'package:anime_app/domain/entities/character.dart';
import 'package:anime_app/domain/entities/favorite_anime.dart';
import 'package:anime_app/domain/entities/recommendation.dart';
import 'package:anime_app/domain/usecases/get_anime_by_id.dart';
import 'package:anime_app/domain/usecases/get_anime_characters_by_anime_id.dart';
import 'package:anime_app/domain/usecases/get_anime_recommendations_by_anime_id.dart';
import 'package:anime_app/domain/usecases/get_favorite_anime_status.dart';
import 'package:anime_app/domain/usecases/remove_favorite_anime.dart';
import 'package:anime_app/domain/usecases/save_favorite_anime.dart';
import 'package:flutter/foundation.dart';

class AnimeDetailProvider extends ChangeNotifier {
  final GetAnimeById getAnimeById;
  final GetAnimeCharactersByAnimeId getAnimeCharactersByAnimeId;
  final GetAnimeRecommendationsByAnimeId getAnimeRecommendationsByAnimeId;
  final SaveFavoriteAnime saveFavoriteAnime;
  final RemoveFavoriteAnime removeFavoriteAnime;
  final GetFavoriteAnimeStatus getFavoriteAnimeStatus;

  AnimeDetailProvider({
    required this.getAnimeById,
    required this.getAnimeCharactersByAnimeId,
    required this.getAnimeRecommendationsByAnimeId,
    required this.saveFavoriteAnime,
    required this.removeFavoriteAnime,
    required this.getFavoriteAnimeStatus,
  });

  late Anime _anime;
  Anime get anime => _anime;

  RequestState _animeState = RequestState.empty;
  RequestState get animeState => _animeState;

  List<Character> _characters = const [];
  List<Character> get characters => _characters;

  RequestState _charactersState = RequestState.empty;
  RequestState get charactersState => _charactersState;

  List<Recommendation> _recommendations = const [];
  List<Recommendation> get recommendations => _recommendations;

  RequestState _recommendationsState = RequestState.empty;
  RequestState get recommendationsState => _recommendationsState;

  bool _isAddedToFavorite = false;
  bool get isAddedToFavorite => _isAddedToFavorite;

  String _message = '';
  String get message => _message;

  Future<void> fetchAnimeById({required int id}) async {
    _animeState = RequestState.loading;
    notifyListeners();

    final result = await getAnimeById.execute(id: id);
    result.fold((failure) {
      _animeState = RequestState.error;
      _message = failure.message;
      notifyListeners();
    }, (data) {
      _animeState = RequestState.loaded;
      _anime = data;
      notifyListeners();
    });
  }

  Future<void> fetchAnimeCharactersByAnimeId({required int id}) async {
    _charactersState = RequestState.loading;
    notifyListeners();

    final result = await getAnimeCharactersByAnimeId.execute(id: id);
    result.fold((failure) {
      _charactersState = RequestState.error;
      _message = failure.message;
      notifyListeners();
    }, (data) {
      _charactersState = RequestState.loaded;
      _characters = data;
      notifyListeners();
    });
  }

  Future<void> fetchAnimeRecommendationsByAnimeId({required int id}) async {
    _recommendationsState = RequestState.loading;
    notifyListeners();

    final result = await getAnimeRecommendationsByAnimeId.execute(id: id);
    result.fold((failure) {
      _recommendationsState = RequestState.error;
      _message = failure.message;
      notifyListeners();
    }, (data) {
      _recommendationsState = RequestState.loaded;
      _recommendations = data;
      notifyListeners();
    });
  }

  Future<void> loadFavoriteAnimeStatus({required int id}) async {
    final result = await getFavoriteAnimeStatus.execute(id: id);
    _isAddedToFavorite = result;
    notifyListeners();
  }

  Future<void> addToFavoriteAnime(
      {required FavoriteAnime favoriteAnime}) async {
    await saveFavoriteAnime.execute(favoriteAnime: favoriteAnime);
    await loadFavoriteAnimeStatus(id: favoriteAnime.malId);
  }

  Future<void> removeFromFavoriteAnime({required int id}) async {
    await removeFavoriteAnime.execute(id: id);
    await loadFavoriteAnimeStatus(id: id);
  }
}
