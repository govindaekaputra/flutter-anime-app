import 'package:anime_app/domain/entities/genre.dart';
import 'package:equatable/equatable.dart';

class GenreModel extends Equatable {
  final int malId;
  final String name;
  final String url;

  const GenreModel({
    required this.malId,
    required this.name,
    required this.url,
  });

  factory GenreModel.fromJson(Map<String, dynamic> json) => GenreModel(
        malId: json["mal_id"],
        name: json["name"],
        url: json["url"],
      );

  Map<String, dynamic> toJson() => {
        "mal_id": malId,
        "name": name,
        "url": url,
      };

  Genre toEntity() => Genre(malId: malId, name: name, url: url);

  @override
  List<Object?> get props => [malId, name, url];
}
