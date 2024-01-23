import 'package:anime_app/data/models/genre_model.dart';
import 'package:anime_app/domain/entities/anime.dart';
import 'package:equatable/equatable.dart';

class AnimeModel extends Equatable {
  final int malId;
  final String url;
  final Map<String, AnimeImageModel> images;
  final bool approved;
  final String title;
  final String? type;
  final String? source;
  final int? episodes;
  final String? status;
  final bool airing;
  final AiredModel aired;
  final String? duration;
  final String? rating;
  final double? score;
  final int? scoredBy;
  final int? rank;
  final int? popularity;
  final int? members;
  final int? favorites;
  final String? synopsis;
  final String? season;
  final int? year;
  final BroadcastModel broadcast;
  final List<GenreModel> genres;

  const AnimeModel({
    required this.malId,
    required this.url,
    required this.images,
    required this.approved,
    required this.title,
    required this.type,
    required this.source,
    required this.episodes,
    required this.status,
    required this.airing,
    required this.aired,
    required this.duration,
    required this.rating,
    required this.score,
    required this.scoredBy,
    required this.rank,
    required this.popularity,
    required this.members,
    required this.favorites,
    required this.synopsis,
    required this.season,
    required this.year,
    required this.broadcast,
    required this.genres,
  });

  factory AnimeModel.fromJson(Map<String, dynamic> json) => AnimeModel(
        malId: json["mal_id"],
        url: json["url"],
        images: Map.from(json["images"]).map((k, v) =>
            MapEntry<String, AnimeImageModel>(k, AnimeImageModel.fromJson(v))),
        approved: json["approved"],
        title: json["title"],
        type: json["type"],
        source: json["source"],
        episodes: json["episodes"],
        status: json["status"],
        airing: json["airing"],
        aired: AiredModel.fromJson(json["aired"]),
        duration: json["duration"],
        rating: json["rating"],
        score: json["score"]?.toDouble(),
        scoredBy: json["scored_by"],
        rank: json["rank"],
        popularity: json["popularity"],
        members: json["members"],
        favorites: json["favorites"],
        synopsis: json["synopsis"],
        season: json["season"],
        year: json["year"],
        broadcast: BroadcastModel.fromJson(json["broadcast"]),
        genres: List<GenreModel>.from(
            json["genres"].map((x) => GenreModel.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "mal_id": malId,
        "url": url,
        "images": Map.from(images)
            .map((k, v) => MapEntry<String, dynamic>(k, v.toJson())),
        "approved": approved,
        "title": title,
        "type": type,
        "source": source,
        "episodes": episodes,
        "status": status,
        "airing": airing,
        "aired": aired.toJson(),
        "duration": duration,
        "rating": rating,
        "score": score,
        "scored_by": scoredBy,
        "rank": rank,
        "popularity": popularity,
        "members": members,
        "favorites": favorites,
        "synopsis": synopsis,
        "season": season,
        "year": year,
        "broadcast": broadcast.toJson(),
        "genres": List<dynamic>.from(genres.map((x) => x.toJson())),
      };

  Anime toEntity() => Anime(
        malId: malId,
        url: url,
        images: Map.from(images)
            .map((k, v) => MapEntry<String, AnimeImage>(k, v.toEntity())),
        approved: approved,
        title: title,
        type: type,
        source: source,
        episodes: episodes,
        status: status,
        airing: airing,
        aired: aired.toEntity(),
        duration: duration,
        rating: rating,
        score: score,
        scoredBy: scoredBy,
        rank: rank,
        popularity: popularity,
        members: members,
        favorites: favorites,
        synopsis: synopsis,
        season: season,
        year: year,
        broadcast: broadcast.toEntity(),
        genres: genres.map((e) => e.toEntity()).toList(),
      );

  @override
  List<Object?> get props => [
        malId,
        url,
        images,
        approved,
        title,
        type,
        source,
        episodes,
        status,
        airing,
        aired,
        duration,
        rating,
        score,
        scoredBy,
        rank,
        popularity,
        members,
        favorites,
        synopsis,
        season,
        year,
        broadcast,
        genres,
      ];
}

class BroadcastModel extends Equatable {
  final String? string;

  const BroadcastModel({
    required this.string,
  });

  factory BroadcastModel.fromJson(Map<String, dynamic> json) => BroadcastModel(
        string: json["string"],
      );

  Map<String, dynamic> toJson() => {
        "string": string,
      };

  Broadcast toEntity() => Broadcast(string: string);

  @override
  List<Object?> get props => [string];
}

class AiredModel extends Equatable {
  final String string;

  const AiredModel({
    required this.string,
  });

  factory AiredModel.fromJson(Map<String, dynamic> json) => AiredModel(
        string: json["string"],
      );

  Map<String, dynamic> toJson() => {
        "string": string,
      };

  Aired toEntity() => Aired(string: string);

  @override
  List<Object?> get props => [string];
}

class AnimeImageModel extends Equatable {
  final String imageUrl;
  final String smallImageUrl;
  final String largeImageUrl;

  const AnimeImageModel({
    required this.imageUrl,
    required this.smallImageUrl,
    required this.largeImageUrl,
  });

  factory AnimeImageModel.fromJson(Map<String, dynamic> json) =>
      AnimeImageModel(
        imageUrl: json["image_url"],
        smallImageUrl: json["small_image_url"],
        largeImageUrl: json["large_image_url"],
      );

  Map<String, dynamic> toJson() => {
        "image_url": imageUrl,
        "small_image_url": smallImageUrl,
        "large_image_url": largeImageUrl,
      };

  AnimeImage toEntity() => AnimeImage(
      imageUrl: imageUrl,
      smallImageUrl: smallImageUrl,
      largeImageUrl: largeImageUrl);

  @override
  List<Object?> get props => [imageUrl, smallImageUrl, largeImageUrl];
}
