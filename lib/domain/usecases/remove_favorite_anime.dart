import 'package:anime_app/common/failure.dart';
import 'package:anime_app/domain/repositories/anime_respository.dart';
import 'package:dartz/dartz.dart';

class RemoveFavoriteAnime {
  final AnimeRepository animeRepository;

  const RemoveFavoriteAnime({required this.animeRepository});

  Future<Either<Failure, String>> execute({required int id}) {
    return animeRepository.removeFavorite(id: id);
  }
}
