import 'package:anime_app/common/failure.dart';
import 'package:anime_app/domain/entities/genre.dart';
import 'package:anime_app/domain/repositories/anime_respository.dart';
import 'package:dartz/dartz.dart';

class GetGenresAnime {
  final AnimeRepository animeRepository;

  const GetGenresAnime({required this.animeRepository});

  Future<Either<Failure, List<Genre>>> execute() {
    return animeRepository.getGenresAnime();
  }
}
