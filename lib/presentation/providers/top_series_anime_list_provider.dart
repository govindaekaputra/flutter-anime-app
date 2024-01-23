import 'package:anime_app/common/constant.dart';
import 'package:anime_app/domain/entities/anime.dart';
import 'package:anime_app/domain/usecases/get_top_anime.dart';
import 'package:flutter/foundation.dart';

class TopSeriesAnimeListProvider extends ChangeNotifier {
  final GetTopAnime getTopAnime;

  TopSeriesAnimeListProvider({required this.getTopAnime});

  int? _page = 1;
  int? get page => _page;

  final int _limit = 10;
  int get limit => _limit;

  final List<Anime> _topSeriesAnime = [];
  List<Anime> get topSeriesAnime => _topSeriesAnime;

  RequestState _topSeriesAnimeState = RequestState.empty;
  RequestState get topSeriesAnimeState => _topSeriesAnimeState;

  String _message = '';
  String get message => _message;

  void clearPage() {
    _page = 1;
    notifyListeners();
  }

  Future<void> fetchTopSeriesAnime() async {
    if (_page == 1) {
      _topSeriesAnime.clear();
      _topSeriesAnimeState = RequestState.loading;
      notifyListeners();
    }

    final result = await getTopAnime.execute(
      animeType: AnimeType.tv,
      page: _page!,
      limit: _limit,
    );
    result.fold(
      (failure) {
        _topSeriesAnimeState = RequestState.error;
        _message = failure.message;
        notifyListeners();
      },
      (data) {
        _topSeriesAnimeState = RequestState.loaded;
        _topSeriesAnime.addAll(data);
        if (data.length < _limit) {
          _page = null;
        } else {
          _page = _page! + 1;
        }
        notifyListeners();
      },
    );
  }
}
