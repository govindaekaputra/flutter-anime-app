import 'package:anime_app/common/constant.dart';
import 'package:anime_app/domain/entities/favorite_anime.dart';
import 'package:anime_app/domain/usecases/get_favorite_anime.dart';
import 'package:flutter/foundation.dart';

class FavoriteAnimeListProvider extends ChangeNotifier {
  final GetFavoriteAnime getFavoriteAnime;

  FavoriteAnimeListProvider({required this.getFavoriteAnime});

  int? _page = 1;
  int? get page => _page;

  final int _limit = 10;
  int get limit => _limit;

  final List<FavoriteAnime> _favoritesAnime = [];
  List<FavoriteAnime> get favoritesAnime => _favoritesAnime;

  RequestState _favoritesAnimeState = RequestState.empty;
  RequestState get favoritesAnimeState => _favoritesAnimeState;

  String _message = '';
  String get message => _message;

  void clearPage() {
    _page = 1;
    notifyListeners();
  }

  Future<void> loadFavoritesAnime() async {
    if (page == 1) {
      _favoritesAnime.clear();
      _favoritesAnimeState = RequestState.loading;
      notifyListeners();
    }
    final result = await getFavoriteAnime.execute(page: _page, limit: _limit);
    result.fold((failure) {
      _favoritesAnimeState = RequestState.error;
      _message = failure.message;
      notifyListeners();
    }, (data) {
      _favoritesAnimeState = RequestState.loaded;
      _favoritesAnime.addAll(data);
      if (data.length < _limit) {
        _page = null;
      } else {
        _page = _page! + 1;
      }
      notifyListeners();
    });
  }
}
