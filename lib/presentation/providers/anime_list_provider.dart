import 'package:anime_app/common/constant.dart';
import 'package:anime_app/domain/entities/anime.dart';
import 'package:anime_app/domain/usecases/get_season_anime.dart';
import 'package:anime_app/domain/usecases/get_top_anime.dart';
import 'package:flutter/foundation.dart';

class AnimeListProvider extends ChangeNotifier {
  final GetTopAnime getTopAnime;
  final GetSeasonAnime getSeasonAnime;

  AnimeListProvider({
    required this.getTopAnime,
    required this.getSeasonAnime,
  });

  List<Anime> _topSeriesAnime = const [];
  List<Anime> get topSeriesAnime => _topSeriesAnime;

  RequestState _topSeriesAnimeState = RequestState.empty;
  RequestState get topSeriesAnimeState => _topSeriesAnimeState;

  List<Anime> _topMoviesAnime = const [];
  List<Anime> get topMoviesAnime => _topMoviesAnime;

  RequestState _topMoviesAnimeState = RequestState.empty;
  RequestState get topMoviesAnimeState => _topMoviesAnimeState;

  List<Anime> _seasonNowAnime = const [];
  List<Anime> get seasonNowAnime => _seasonNowAnime;

  RequestState _seasonNowAnimeState = RequestState.empty;
  RequestState get seasonNowAnimeState => _seasonNowAnimeState;

  List<Anime> _seasonUpcomingAnime = const [];
  List<Anime> get seasonUpcomingAnime => _seasonUpcomingAnime;

  RequestState _seasonUpcomingAnimeState = RequestState.empty;
  RequestState get seasonUpcomingAnimeState => _seasonUpcomingAnimeState;

  String _message = '';
  String get message => _message;

  Future<void> fetchTopSeriesAnime() async {
    _topSeriesAnimeState = RequestState.loading;
    notifyListeners();

    final result = await getTopAnime.execute(animeType: AnimeType.tv);
    result.fold(
      (failure) {
        _topSeriesAnimeState = RequestState.error;
        _message = failure.message;
        notifyListeners();
      },
      (data) {
        _topSeriesAnimeState = RequestState.loaded;
        _topSeriesAnime = data;
        notifyListeners();
      },
    );
  }

  Future<void> fetchTopMoviesAnime() async {
    _topMoviesAnimeState = RequestState.loading;
    notifyListeners();

    final result = await getTopAnime.execute(animeType: AnimeType.movie);
    result.fold((failure) {
      _topMoviesAnimeState = RequestState.error;
      _message = failure.message;
      notifyListeners();
    }, (data) {
      _topMoviesAnimeState = RequestState.loaded;
      _topMoviesAnime = data;
      notifyListeners();
    });
  }

  Future<void> fetchSeasonNowAnime() async {
    _seasonNowAnimeState = RequestState.loading;
    notifyListeners();

    final result = await getSeasonAnime.execute(animeSeason: AnimeSeason.now);
    result.fold((failure) {
      _seasonNowAnimeState = RequestState.error;
      _message = failure.message;
      notifyListeners();
    }, (data) {
      _seasonNowAnimeState = RequestState.loaded;
      _seasonNowAnime = data;
      notifyListeners();
    });
  }

  Future<void> fetchSeasonUpcomingAnime() async {
    _seasonUpcomingAnimeState = RequestState.loading;
    notifyListeners();

    final result =
        await getSeasonAnime.execute(animeSeason: AnimeSeason.upcoming);
    result.fold((failure) {
      _seasonUpcomingAnimeState = RequestState.error;
      _message = failure.message;
      notifyListeners();
    }, (data) {
      _seasonUpcomingAnimeState = RequestState.loaded;
      _seasonUpcomingAnime = data;
      notifyListeners();
    });
  }
}
