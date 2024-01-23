import 'package:anime_app/domain/repositories/anime_respository.dart';

class GetFavoriteAnimeStatus {
  final AnimeRepository animeRepository;

  const GetFavoriteAnimeStatus({required this.animeRepository});

  Future<bool> execute({required int id}) {
    return animeRepository.isAddedToFavorite(id: id);
  }
}
