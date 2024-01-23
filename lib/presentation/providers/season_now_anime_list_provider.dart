import 'package:anime_app/common/constant.dart';
import 'package:anime_app/domain/entities/anime.dart';
import 'package:anime_app/domain/usecases/get_season_anime.dart';
import 'package:flutter/foundation.dart';

class SeasonNowAnimeListProvider extends ChangeNotifier {
  final GetSeasonAnime getSeasonAnime;

  SeasonNowAnimeListProvider({required this.getSeasonAnime});

  int? _page = 1;
  int? get page => _page;

  final int _limit = 10;
  int get limit => _limit;

  final List<Anime> _seasonNowAnime = [];
  List<Anime> get seasonNowAnime => _seasonNowAnime;

  RequestState _seasonNowAnimeState = RequestState.empty;
  RequestState get seasonNowAnimeState => _seasonNowAnimeState;

  String _message = '';
  String get message => _message;

  void clearPage() {
    _page = 1;
    notifyListeners();
  }

  Future<void> fetchSeasonNowAnime() async {
    if (_page == 1) {
      _seasonNowAnime.clear();
      _seasonNowAnimeState = RequestState.loading;
      notifyListeners();
    }

    final result = await getSeasonAnime.execute(
      animeSeason: AnimeSeason.now,
      page: _page!,
      limit: _limit,
    );
    result.fold((failure) {
      _seasonNowAnimeState = RequestState.error;
      _message = failure.message;
      notifyListeners();
    }, (data) {
      _seasonNowAnimeState = RequestState.loaded;
      _seasonNowAnime.addAll(data);
      if (data.length < _limit) {
        _page = null;
      } else {
        _page = _page! + 1;
      }
      notifyListeners();
    });
  }
}
