import 'package:anime_app/domain/entities/recommendation.dart';
import 'package:equatable/equatable.dart';

class RecommendationModel extends Equatable {
  final EntryModel entry;
  final String url;
  final int votes;

  const RecommendationModel({
    required this.entry,
    required this.url,
    required this.votes,
  });

  factory RecommendationModel.fromJson(Map<String, dynamic> json) =>
      RecommendationModel(
        entry: EntryModel.fromJson(json["entry"]),
        url: json["url"],
        votes: json["votes"],
      );

  Map<String, dynamic> toJson() => {
        "entry": entry.toJson(),
        "url": url,
        "votes": votes,
      };

  Recommendation toEntity() => Recommendation(
        entry: entry.toEntity(),
        url: url,
        votes: votes,
      );

  @override
  List<Object?> get props => [
        entry,
        url,
        votes,
      ];
}

class EntryModel extends Equatable {
  final int malId;
  final String url;
  final Map<String, ImageModel> images;
  final String title;

  const EntryModel({
    required this.malId,
    required this.url,
    required this.images,
    required this.title,
  });

  factory EntryModel.fromJson(Map<String, dynamic> json) => EntryModel(
        malId: json["mal_id"],
        url: json["url"],
        images: Map.from(json["images"]).map(
            (k, v) => MapEntry<String, ImageModel>(k, ImageModel.fromJson(v))),
        title: json["title"],
      );

  Map<String, dynamic> toJson() => {
        "mal_id": malId,
        "url": url,
        "images": Map.from(images)
            .map((k, v) => MapEntry<String, dynamic>(k, v.toJson())),
        "title": title,
      };

  Entry toEntity() => Entry(
        malId: malId,
        url: url,
        images: Map.from(images)
            .map((k, v) => MapEntry<String, Image>(k, v.toEntity())),
        title: title,
      );

  @override
  List<Object?> get props => [
        malId,
        url,
        images,
        title,
      ];
}

class ImageModel extends Equatable {
  final String imageUrl;
  final String smallImageUrl;
  final String largeImageUrl;

  const ImageModel({
    required this.imageUrl,
    required this.smallImageUrl,
    required this.largeImageUrl,
  });

  factory ImageModel.fromJson(Map<String, dynamic> json) => ImageModel(
        imageUrl: json["image_url"],
        smallImageUrl: json["small_image_url"],
        largeImageUrl: json["large_image_url"],
      );

  Map<String, dynamic> toJson() => {
        "image_url": imageUrl,
        "small_image_url": smallImageUrl,
        "large_image_url": largeImageUrl,
      };

  Image toEntity() => Image(
        imageUrl: imageUrl,
        smallImageUrl: smallImageUrl,
        largeImageUrl: largeImageUrl,
      );

  @override
  List<Object?> get props => [
        imageUrl,
        smallImageUrl,
        largeImageUrl,
      ];
}
