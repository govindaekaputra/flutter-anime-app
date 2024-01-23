import 'package:anime_app/common/failure.dart';
import 'package:anime_app/domain/entities/character.dart';
import 'package:anime_app/domain/repositories/anime_respository.dart';
import 'package:dartz/dartz.dart';

class GetAnimeCharactersByAnimeId {
  final AnimeRepository animeRepository;

  const GetAnimeCharactersByAnimeId({required this.animeRepository});

  Future<Either<Failure, List<Character>>> execute({required int id}) {
    return animeRepository.getAnimeCharactersByAnimeId(id: id);
  }
}
