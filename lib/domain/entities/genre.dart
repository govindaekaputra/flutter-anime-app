import 'package:equatable/equatable.dart';

class Genre extends Equatable {
  final int malId;
  final String name;
  final String url;

  const Genre({
    required this.malId,
    required this.name,
    required this.url,
  });

  @override
  List<Object?> get props => [malId, name, url];
}
