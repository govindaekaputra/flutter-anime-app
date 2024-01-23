import 'package:equatable/equatable.dart';

class FavoriteAnime extends Equatable {
  final int malId;
  final String imageUrl;
  final String title;
  final String? type;
  final String? synopsis;

  const FavoriteAnime({
    required this.malId,
    required this.imageUrl,
    required this.title,
    required this.type,
    required this.synopsis,
  });

  @override
  List<Object?> get props => [
        malId,
        imageUrl,
        title,
        type,
        synopsis,
      ];
}
