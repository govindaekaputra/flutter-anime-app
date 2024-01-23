import 'package:anime_app/common/constant.dart';
import 'package:anime_app/domain/entities/genre.dart';
import 'package:anime_app/domain/usecases/get_genres_anime.dart';
import 'package:flutter/foundation.dart';

class GenresAnimeProvider extends ChangeNotifier {
  final GetGenresAnime getGenresAnime;
  GenresAnimeProvider({
    required this.getGenresAnime,
  });

  List<Genre> _genres = [];
  List<Genre> get genres => _genres;

  RequestState _genresRequestState = RequestState.empty;
  RequestState get genresRequestState => _genresRequestState;

  String _message = '';
  String get message => _message;

  Future<void> fetchGenres() async {
    _genresRequestState = RequestState.loading;
    notifyListeners();

    final result = await getGenresAnime.execute();
    result.fold((failure) {
      _genresRequestState = RequestState.error;
      _message = failure.message;
      notifyListeners();
    }, (data) {
      _genresRequestState = RequestState.loaded;
      _genres = data;
      notifyListeners();
    });
  }
}
