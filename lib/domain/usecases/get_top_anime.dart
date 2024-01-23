import 'package:dartz/dartz.dart';

import 'package:anime_app/common/constant.dart';
import 'package:anime_app/common/failure.dart';
import 'package:anime_app/domain/entities/anime.dart';
import 'package:anime_app/domain/repositories/anime_respository.dart';

class GetTopAnime {
  final AnimeRepository animeRepository;

  const GetTopAnime({required this.animeRepository});

  Future<Either<Failure, List<Anime>>> execute({
    required AnimeType animeType,
    int page = 1,
    int limit = 10,
  }) {
    return animeRepository.getTopAnime(
      animeType: animeType,
      page: page,
      limit: limit,
    );
  }
}
