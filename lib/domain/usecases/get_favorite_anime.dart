import 'package:anime_app/common/failure.dart';
import 'package:anime_app/domain/entities/favorite_anime.dart';
import 'package:dartz/dartz.dart';

import 'package:anime_app/domain/repositories/anime_respository.dart';

class GetFavoriteAnime {
  final AnimeRepository animeRepository;

  const GetFavoriteAnime({required this.animeRepository});

  Future<Either<Failure, List<FavoriteAnime>>> execute({
    int? page,
    int? limit,
  }) {
    return animeRepository.getFavorites(page: page, limit: limit);
  }
}
