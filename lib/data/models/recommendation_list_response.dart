import 'package:anime_app/data/models/recommendation_model.dart';
import 'package:equatable/equatable.dart';

class RecommendationListResponse extends Equatable {
  final List<RecommendationModel> data;

  const RecommendationListResponse({
    required this.data,
  });

  factory RecommendationListResponse.fromJson(Map<String, dynamic> json) =>
      RecommendationListResponse(
        data: List<RecommendationModel>.from(
            json["data"].map((x) => RecommendationModel.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };

  @override
  List<Object?> get props => [data];
}
