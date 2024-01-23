import 'package:equatable/equatable.dart';

class Character extends Equatable {
  final DataCharacter character;
  final String role;
  final int favorites;
  final List<VoiceActor> voiceActors;

  const Character({
    required this.character,
    required this.role,
    required this.favorites,
    required this.voiceActors,
  });

  @override
  List<Object?> get props => [character, role, favorites, voiceActors];
}

class DataCharacter extends Equatable {
  final int malId;
  final String url;
  final CharacterImages images;
  final String name;

  const DataCharacter({
    required this.malId,
    required this.url,
    required this.images,
    required this.name,
  });

  @override
  List<Object?> get props => [malId, url, images, name];
}

class VoiceActor extends Equatable {
  final Person person;
  final String language;

  const VoiceActor({
    required this.person,
    required this.language,
  });

  @override
  List<Object?> get props => [person, language];
}

class Person extends Equatable {
  final int malId;
  final String url;
  final PersonImages images;
  final String name;

  const Person({
    required this.malId,
    required this.url,
    required this.images,
    required this.name,
  });

  @override
  List<Object?> get props => [malId, url, images, name];
}

class CharacterImages extends Equatable {
  final Jpg jpg;
  final Webp webp;

  const CharacterImages({
    required this.jpg,
    required this.webp,
  });

  @override
  List<Object?> get props => [jpg, webp];
}

class PersonImages extends Equatable {
  final Jpg jpg;

  const PersonImages({
    required this.jpg,
  });

  @override
  List<Object?> get props => [jpg];
}

class Jpg extends Equatable {
  final String imageUrl;

  const Jpg({
    required this.imageUrl,
  });

  @override
  List<Object?> get props => [imageUrl];
}

class Webp extends Equatable {
  final String imageUrl;
  final String smallImageUrl;

  const Webp({
    required this.imageUrl,
    required this.smallImageUrl,
  });

  @override
  List<Object?> get props => [imageUrl, smallImageUrl];
}
