import 'package:equatable/equatable.dart';

class Recommendation extends Equatable {
  final Entry entry;
  final String url;
  final int votes;

  const Recommendation({
    required this.entry,
    required this.url,
    required this.votes,
  });

  @override
  List<Object?> get props => [
        entry,
        url,
        votes,
      ];
}

class Entry extends Equatable {
  final int malId;
  final String url;
  final Map<String, Image> images;
  final String title;

  const Entry({
    required this.malId,
    required this.url,
    required this.images,
    required this.title,
  });

  @override
  List<Object?> get props => [
        malId,
        url,
        images,
        title,
      ];
}

class Image extends Equatable {
  final String imageUrl;
  final String smallImageUrl;
  final String largeImageUrl;

  const Image({
    required this.imageUrl,
    required this.smallImageUrl,
    required this.largeImageUrl,
  });

  @override
  List<Object?> get props => [
        imageUrl,
        smallImageUrl,
        largeImageUrl,
      ];
}
