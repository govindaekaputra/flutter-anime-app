import 'package:anime_app/domain/entities/character.dart';
import 'package:equatable/equatable.dart';

class CharacterModel extends Equatable {
  final DataCharacterModel character;
  final String role;
  final int favorites;
  final List<VoiceActorModel> voiceActors;

  const CharacterModel({
    required this.character,
    required this.role,
    required this.favorites,
    required this.voiceActors,
  });

  factory CharacterModel.fromJson(Map<String, dynamic> json) => CharacterModel(
        character: DataCharacterModel.fromJson(json["character"]),
        role: json["role"],
        favorites: json["favorites"],
        voiceActors: List<VoiceActorModel>.from(
            json["voice_actors"].map((x) => VoiceActorModel.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "character": character.toJson(),
        "role": role,
        "favorites": favorites,
        "voice_actors": voiceActors.map((e) => e.toJson()),
      };

  Character toEntity() => Character(
        character: character.toEntity(),
        role: role,
        favorites: favorites,
        voiceActors: voiceActors.map((e) => e.toEntity()).toList(),
      );

  @override
  List<Object?> get props => [character, role, favorites, voiceActors];
}

class DataCharacterModel extends Equatable {
  final int malId;
  final String url;
  final CharacterImagesModel images;
  final String name;

  const DataCharacterModel({
    required this.malId,
    required this.url,
    required this.images,
    required this.name,
  });

  factory DataCharacterModel.fromJson(Map<String, dynamic> json) =>
      DataCharacterModel(
        malId: json["mal_id"],
        url: json["url"],
        images: CharacterImagesModel.fromJson(json["images"]),
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "mal_id": malId,
        "url": url,
        "images": images.toJson(),
        "name": name,
      };

  DataCharacter toEntity() => DataCharacter(
        malId: malId,
        url: url,
        images: images.toEntity(),
        name: name,
      );

  @override
  List<Object?> get props => [malId, url, images, name];
}

class VoiceActorModel extends Equatable {
  final PersonModel person;
  final String language;

  const VoiceActorModel({
    required this.person,
    required this.language,
  });

  factory VoiceActorModel.fromJson(Map<String, dynamic> json) =>
      VoiceActorModel(
        person: PersonModel.fromJson(json["person"]),
        language: json["language"],
      );

  Map<String, dynamic> toJson() => {
        "person": person.toJson(),
        "language": language,
      };

  VoiceActor toEntity() => VoiceActor(
        person: person.toEntity(),
        language: language,
      );

  @override
  List<Object?> get props => [person, language];
}

class PersonModel extends Equatable {
  final int malId;
  final String url;
  final PersonImagesModel images;
  final String name;

  const PersonModel({
    required this.malId,
    required this.url,
    required this.images,
    required this.name,
  });

  factory PersonModel.fromJson(Map<String, dynamic> json) => PersonModel(
        malId: json["mal_id"],
        url: json["url"],
        images: PersonImagesModel.fromJson(json["images"]),
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "mal_id": malId,
        "url": url,
        "images": images.toJson(),
        "name": name,
      };

  Person toEntity() => Person(
        malId: malId,
        url: url,
        images: images.toEntity(),
        name: name,
      );

  @override
  List<Object?> get props => [malId, url, images, name];
}

class CharacterImagesModel extends Equatable {
  final JpgModel jpg;
  final WebpModel webp;

  const CharacterImagesModel({
    required this.jpg,
    required this.webp,
  });

  factory CharacterImagesModel.fromJson(Map<String, dynamic> json) =>
      CharacterImagesModel(
        jpg: JpgModel.fromJson(json["jpg"]),
        webp: WebpModel.fromJson(json["webp"]),
      );

  Map<String, dynamic> toJson() => {
        "jpg": jpg.toJson(),
        "webp": webp.toJson(),
      };

  CharacterImages toEntity() => CharacterImages(
        jpg: jpg.toEntity(),
        webp: webp.toEntity(),
      );

  @override
  List<Object?> get props => [jpg, webp];
}

class PersonImagesModel extends Equatable {
  final JpgModel jpg;

  const PersonImagesModel({
    required this.jpg,
  });

  factory PersonImagesModel.fromJson(Map<String, dynamic> json) =>
      PersonImagesModel(
        jpg: JpgModel.fromJson(json["jpg"]),
      );

  Map<String, dynamic> toJson() => {
        "jpg": jpg.toJson(),
      };

  PersonImages toEntity() => PersonImages(
        jpg: jpg.toEntity(),
      );

  @override
  List<Object?> get props => [jpg];
}

class JpgModel extends Equatable {
  final String imageUrl;

  const JpgModel({
    required this.imageUrl,
  });

  factory JpgModel.fromJson(Map<String, dynamic> json) => JpgModel(
        imageUrl: json["image_url"],
      );

  Map<String, dynamic> toJson() => {
        "image_url": imageUrl,
      };

  Jpg toEntity() => Jpg(
        imageUrl: imageUrl,
      );

  @override
  List<Object?> get props => [imageUrl];
}

class WebpModel extends Equatable {
  final String imageUrl;
  final String smallImageUrl;

  const WebpModel({
    required this.imageUrl,
    required this.smallImageUrl,
  });

  factory WebpModel.fromJson(Map<String, dynamic> json) => WebpModel(
        imageUrl: json["image_url"],
        smallImageUrl: json["small_image_url"],
      );

  Map<String, dynamic> toJson() => {
        "image_url": imageUrl,
        "small_image_url": smallImageUrl,
      };

  Webp toEntity() => Webp(
        imageUrl: imageUrl,
        smallImageUrl: smallImageUrl,
      );

  @override
  List<Object?> get props => [imageUrl, smallImageUrl];
}
