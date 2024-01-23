import 'package:anime_app/domain/entities/genre.dart';
import 'package:equatable/equatable.dart';

class Anime extends Equatable {
  final int malId;
  final String url;
  final Map<String, AnimeImage> images;
  final bool approved;
  final String title;
  final String? type;
  final String? source;
  final int? episodes;
  final String? status;
  final bool airing;
  final Aired aired;
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
  final Broadcast broadcast;
  final List<Genre> genres;

  const Anime({
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

class Broadcast extends Equatable {
  final String? string;

  const Broadcast({
    required this.string,
  });

  @override
  List<Object?> get props => [string];
}

class Aired extends Equatable {
  final String string;

  const Aired({
    required this.string,
  });

  @override
  List<Object?> get props => [string];
}

class AnimeImage extends Equatable {
  final String imageUrl;
  final String smallImageUrl;
  final String largeImageUrl;

  const AnimeImage({
    required this.imageUrl,
    required this.smallImageUrl,
    required this.largeImageUrl,
  });

  @override
  List<Object?> get props => [imageUrl, smallImageUrl, largeImageUrl];
}
