import 'package:anime_app/common/constant.dart';
import 'package:anime_app/domain/entities/anime.dart';
import 'package:anime_app/domain/usecases/get_season_anime.dart';
import 'package:flutter/foundation.dart';

class SeasonUpcomingAnimeListProvider extends ChangeNotifier {
  final GetSeasonAnime getSeasonAnime;

  SeasonUpcomingAnimeListProvider({required this.getSeasonAnime});

  int? _page = 1;
  int? get page => _page;

  final int _limit = 10;
  int get limit => _limit;

  final List<Anime> _seasonUpcomingAnime = [];
  List<Anime> get seasonUpcomingAnime => _seasonUpcomingAnime;

  RequestState _seasonUpcomingAnimeState = RequestState.empty;
  RequestState get seasonUpcomingAnimeState => _seasonUpcomingAnimeState;

  String _message = '';
  String get message => _message;

  void clearPage() {
    _page = 1;
    notifyListeners();
  }

  Future<void> fetchSeasonUpcomingAnime() async {
    if (_page == 1) {
      _seasonUpcomingAnime.clear();
      _seasonUpcomingAnimeState = RequestState.loading;
      notifyListeners();
    }

    final result = await getSeasonAnime.execute(
      animeSeason: AnimeSeason.upcoming,
      page: _page!,
      limit: _limit,
    );
    result.fold((failure) {
      _seasonUpcomingAnimeState = RequestState.error;
      _message = failure.message;
      notifyListeners();
    }, (data) {
      _seasonUpcomingAnimeState = RequestState.loaded;
      _seasonUpcomingAnime.addAll(data);
      if (data.length < _limit) {
        _page = null;
      } else {
        _page = _page! + 1;
      }
      notifyListeners();
    });
  }
}
