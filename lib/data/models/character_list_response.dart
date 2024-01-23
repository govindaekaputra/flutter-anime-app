import 'package:anime_app/data/models/character_model.dart';
import 'package:equatable/equatable.dart';

class CharacterListResponse extends Equatable {
  final List<CharacterModel> data;

  const CharacterListResponse({
    required this.data,
  });

  factory CharacterListResponse.fromJson(Map<String, dynamic> json) =>
      CharacterListResponse(
        data: List<CharacterModel>.from(
            json["data"].map((x) => CharacterModel.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };

  @override
  List<Object?> get props => [data];
}
