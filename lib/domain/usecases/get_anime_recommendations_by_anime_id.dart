import 'package:anime_app/common/failure.dart';
import 'package:anime_app/domain/entities/recommendation.dart';
import 'package:anime_app/domain/repositories/anime_respository.dart';
import 'package:dartz/dartz.dart';

class GetAnimeRecommendationsByAnimeId {
  final AnimeRepository animeRepository;

  const GetAnimeRecommendationsByAnimeId({required this.animeRepository});

  Future<Either<Failure, List<Recommendation>>> execute({required int id}) {
    return animeRepository.getAnimeRecommendationsByAnimeId(id: id);
  }
}
