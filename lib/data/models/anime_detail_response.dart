import 'package:anime_app/data/models/anime_model.dart';
import 'package:equatable/equatable.dart';

class AnimeDetailResponse extends Equatable {
  final AnimeModel data;

  const AnimeDetailResponse({
    required this.data,
  });

  factory AnimeDetailResponse.fromJson(Map<String, dynamic> json) =>
      AnimeDetailResponse(
        data: AnimeModel.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "data": data.toJson(),
      };

  @override
  List<Object?> get props => [data];
}
