import 'package:anime_app/common/failure.dart';
import 'package:anime_app/domain/entities/favorite_anime.dart';
import 'package:anime_app/domain/repositories/anime_respository.dart';
import 'package:dartz/dartz.dart';

class SaveFavoriteAnime {
  final AnimeRepository animeRepository;

  const SaveFavoriteAnime({required this.animeRepository});

  Future<Either<Failure, String>> execute(
      {required FavoriteAnime favoriteAnime}) {
    return animeRepository.insertFavorite(favoriteAnime: favoriteAnime);
  }
}
