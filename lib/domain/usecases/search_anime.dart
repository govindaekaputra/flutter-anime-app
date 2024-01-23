import 'package:anime_app/common/constant.dart';
import 'package:anime_app/common/failure.dart';
import 'package:anime_app/domain/entities/anime.dart';
import 'package:anime_app/domain/repositories/anime_respository.dart';
import 'package:dartz/dartz.dart';

class SearchAnime {
  final AnimeRepository animeRepository;

  const SearchAnime({required this.animeRepository});

  Future<Either<Failure, List<Anime>>> execute({
    String keyword = "",
    List<int> genres = const [],
    AnimeType? animeType,
    AnimeStatus? animeStatus,
    AnimeRating? animeRating,
    int page = 1,
    int limit = 10,
  }) {
    return animeRepository.getSearchAnime(
      keyword: keyword,
      genres: genres,
      animeType: animeType,
      animeStatus: animeStatus,
      animeRating: animeRating,
      page: page,
      limit: limit,
    );
  }
}
