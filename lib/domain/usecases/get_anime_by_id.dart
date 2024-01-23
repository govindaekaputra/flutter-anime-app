import 'package:anime_app/common/failure.dart';
import 'package:anime_app/domain/entities/anime.dart';
import 'package:anime_app/domain/repositories/anime_respository.dart';
import 'package:dartz/dartz.dart';

class GetAnimeById {
  final AnimeRepository animeRepository;

  const GetAnimeById({required this.animeRepository});

  Future<Either<Failure, Anime>> execute({required int id}) {
    return animeRepository.getAnimeById(id: id);
  }
}
