
import 'package:json_annotation/json_annotation.dart';

part 'movie_credit_details.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
class MovieCreditsDetails {
  bool? adult;
  int? gender;
  int? id;
  String? knownForDepartment;
  String? name;
  String? originalName;
  double? popularity;
  String? profilePath;
  int? castId;
  String? character;
  String? creditId;
  int? order;

  MovieCreditsDetails(
      {this.adult,
        this.gender,
        this.id,
        this.knownForDepartment,
        this.name,
        this.originalName,
        this.popularity,
        this.profilePath,
        this.castId,
        this.character,
        this.creditId,
        this.order});


  factory MovieCreditsDetails.fromJson(Map<String, dynamic> json) => _$MovieCreditsDetailsFromJson(json);

  Map<String, dynamic> toJson() => _$MovieCreditsDetailsToJson(this);
}