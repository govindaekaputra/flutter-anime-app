import 'package:anime_app/common/constant.dart';
import 'package:anime_app/domain/entities/anime.dart';
import 'package:anime_app/domain/usecases/get_top_anime.dart';
import 'package:flutter/foundation.dart';

class TopMoviesAnimeListProvider extends ChangeNotifier {
  final GetTopAnime getTopAnime;

  TopMoviesAnimeListProvider({required this.getTopAnime});

  int? _page = 1;
  int? get page => _page;

  final int _limit = 10;
  int get limit => _limit;

  final List<Anime> _topMoviesAnime = [];
  List<Anime> get topMoviesAnime => _topMoviesAnime;

  RequestState _topMoviesAnimeState = RequestState.empty;
  RequestState get topMoviesAnimeState => _topMoviesAnimeState;

  String _message = '';
  String get message => _message;

  void clearPage() {
    _page = 1;
    notifyListeners();
  }

  Future<void> fetchTopMoviesAnime() async {
    if (_page == 1) {
      _topMoviesAnime.clear();
      _topMoviesAnimeState = RequestState.loading;
      notifyListeners();
    }

    final result = await getTopAnime.execute(
      animeType: AnimeType.movie,
      page: _page!,
      limit: _limit,
    );
    result.fold((failure) {
      _topMoviesAnimeState = RequestState.error;
      _message = failure.message;
      notifyListeners();
    }, (data) {
      _topMoviesAnimeState = RequestState.loaded;
      _topMoviesAnime.addAll(data);
      if (data.length < _limit) {
        _page = null;
      } else {
        _page = _page! + 1;
      }
      notifyListeners();
    });
  }
}
