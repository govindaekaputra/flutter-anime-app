import 'package:anime_app/domain/entities/favorite_anime.dart';
import 'package:equatable/equatable.dart';

class FavoriteAnimeTable extends Equatable {
  final int malId;
  final String imageUrl;
  final String title;
  final String? type;
  final String? synopsis;

  const FavoriteAnimeTable({
    required this.malId,
    required this.imageUrl,
    required this.title,
    required this.type,
    required this.synopsis,
  });

  factory FavoriteAnimeTable.fromJson(Map<String, dynamic> json) =>
      FavoriteAnimeTable(
        malId: json["mal_id"],
        imageUrl: json["image_url"],
        title: json["title"],
        type: json["type"],
        synopsis: json["synopsis"],
      );

  Map<String, dynamic> toJson() => {
        "mal_id": malId,
        "title": title,
        "image_url": imageUrl,
        "type": type,
        "synopsis": synopsis,
      };

  factory FavoriteAnimeTable.fromEntity(FavoriteAnime anime) =>
      FavoriteAnimeTable(
        malId: anime.malId,
        imageUrl: anime.imageUrl,
        title: anime.title,
        type: anime.type,
        synopsis: anime.synopsis,
      );

  FavoriteAnime toEntity() => FavoriteAnime(
        malId: malId,
        imageUrl: imageUrl,
        title: title,
        type: type,
        synopsis: synopsis,
      );

  @override
  List<Object?> get props => [
        malId,
        title,
        imageUrl,
        type,
        synopsis,
      ];
}
