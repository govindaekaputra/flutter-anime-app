import 'package:anime_app/data/models/genre_model.dart';
import 'package:equatable/equatable.dart';

class GenreListResponse extends Equatable {
  final List<GenreModel> data;

  const GenreListResponse({
    required this.data,
  });

  factory GenreListResponse.fromJson(Map<String, dynamic> json) =>
      GenreListResponse(
        data: List<GenreModel>.from(
            json["data"].map((x) => GenreModel.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };

  @override
  List<Object?> get props => [data];
}
