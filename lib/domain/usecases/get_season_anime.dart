import 'package:anime_app/common/constant.dart';
import 'package:anime_app/common/failure.dart';
import 'package:anime_app/domain/entities/anime.dart';
import 'package:dartz/dartz.dart';

import 'package:anime_app/domain/repositories/anime_respository.dart';

class GetSeasonAnime {
  final AnimeRepository animeRepository;

  const GetSeasonAnime({required this.animeRepository});

  Future<Either<Failure, List<Anime>>> execute({
    required AnimeSeason animeSeason,
    int page = 1,
    int limit = 10,
  }) {
    return animeRepository.getSeasonAnime(
      animeSeason: animeSeason,
      page: page,
      limit: limit,
    );
  }
}
