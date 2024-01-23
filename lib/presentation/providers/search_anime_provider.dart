import 'package:anime_app/common/constant.dart';
import 'package:anime_app/domain/entities/anime.dart';
import 'package:anime_app/domain/usecases/search_anime.dart';
import 'package:flutter/foundation.dart';

class SearchAnimeProvider extends ChangeNotifier {
  final SearchAnime searchAnime;
  SearchAnimeProvider({required this.searchAnime});

  final List<int> _genres = [];
  List<int> get genres => _genres;

  AnimeType? _animeType;
  AnimeType? get animeType => _animeType;

  AnimeStatus? _animeStatus;
  AnimeStatus? get animeStatus => _animeStatus;

  AnimeRating? _animeRating;
  AnimeRating? get animeRating => _animeRating;

  String _keyword = '';
  String get keyword => _keyword;

  int? _page = 1;
  int? get page => _page;

  final int _limit = 10;
  int get limit => _limit;

  final List<Anime> _animes = [];
  List<Anime> get animes => _animes;

  RequestState _requestState = RequestState.empty;
  RequestState get requestState => _requestState;

  String _message = '';
  String get message => _message;

  bool isIncludeInGenre(int id) {
    return _genres.indexWhere((element) => element == id) != -1;
  }

  bool isActiveAnimeType(AnimeType value) {
    return _animeType == value;
  }

  bool isActiveAnimeStatus(AnimeStatus value) {
    return _animeStatus == value;
  }

  bool isActiveAnimeRating(AnimeRating value) {
    return _animeRating == value;
  }

  void updateGenre(int id) {
    final index = _genres.indexWhere((element) => element == id);
    if (index != -1) {
      // remove dari genre
      _genres.removeAt(index);
    } else {
      // add genre
      _genres.add(id);
    }
    notifyListeners();
  }

  void updateAnimeType(AnimeType value) {
    if (isActiveAnimeType(value)) {
      _animeType = null;
    } else {
      _animeType = value;
    }
    notifyListeners();
  }

  void updateAnimeStatus(AnimeStatus value) {
    if (isActiveAnimeStatus(value)) {
      _animeStatus = null;
    } else {
      _animeStatus = value;
    }
    notifyListeners();
  }

  void updateAnimeRating(AnimeRating value) {
    if (isActiveAnimeRating(value)) {
      _animeRating = null;
    } else {
      _animeRating = value;
    }
    notifyListeners();
  }

  void updateKeyword(String val) {
    _keyword = val;
    notifyListeners();
  }

  void clearPage() {
    _page = 1;
    notifyListeners();
  }

  Future<void> fetchSearchAnime() async {
    if (_page == 1) {
      _animes.clear();
      _requestState = RequestState.loading;
      notifyListeners();
    }
    final result = await searchAnime.execute(
      keyword: _keyword,
      genres: _genres,
      animeRating: _animeRating,
      animeStatus: _animeStatus,
      animeType: _animeType,
      page: _page!,
      limit: _limit,
    );
    result.fold((failure) {
      _requestState = RequestState.error;
      _message = failure.message;
      notifyListeners();
    }, (data) {
      _requestState = RequestState.loaded;
      _animes.addAll(data);
      if (data.length < _limit) {
        _page = null;
      } else {
        _page = _page! + 1;
      }
      notifyListeners();
    });
  }
}
