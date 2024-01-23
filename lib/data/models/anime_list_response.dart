import 'package:anime_app/data/models/anime_model.dart';
import 'package:equatable/equatable.dart';

class AnimeListResponse extends Equatable {
  final List<AnimeModel> data;

  const AnimeListResponse({
    required this.data,
  });

  factory AnimeListResponse.fromJson(Map<String, dynamic> json) =>
      AnimeListResponse(
        data: List<AnimeModel>.from(
            json["data"].map((x) => AnimeModel.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };

  @override
  List<Object?> get props => [data];
}
