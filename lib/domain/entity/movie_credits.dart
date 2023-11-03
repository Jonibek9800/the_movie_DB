import 'package:json_annotation/json_annotation.dart';

part 'movie_credits.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
class MovieCredits {
  int? id;
  List<Cast>? cast;
  List<Crew>? crew;

  MovieCredits({this.id, this.cast, this.crew});

  factory MovieCredits.fromJson(Map<String, dynamic> json) => _$MovieCreditsFromJson(json);

  Map<String, dynamic> toJson() => _$MovieCreditsToJson(this);

}

@JsonSerializable(fieldRename: FieldRename.snake)
class Cast {
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

  Cast(
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

  factory Cast.fromJson(Map<String, dynamic> json) => _$CastFromJson(json);

  Map<String, dynamic> toJson() => _$CastToJson(this);
}

@JsonSerializable(fieldRename: FieldRename.snake)
class Crew {
  bool? adult;
  int? gender;
  int? id;
  String? knownForDepartment;
  String? name;
  String? originalName;
  double? popularity;
  String? profilePath;
  String? creditId;
  String? department;
  String? job;

  Crew(
      {this.adult,
        this.gender,
        this.id,
        this.knownForDepartment,
        this.name,
        this.originalName,
        this.popularity,
        this.profilePath,
        this.creditId,
        this.department,
        this.job});


  factory Crew.fromJson(Map<String, dynamic> json) => _$CrewFromJson(json);

  Map<String, dynamic> toJson() => _$CrewToJson(this);

  // Crew.fromJson(Map<String, dynamic> json) {
  //   adult = json['adult'];
  //   gender = json['gender'];
  //   id = json['id'];
  //   knownForDepartment = json['known_for_department'];
  //   name = json['name'];
  //   originalName = json['original_name'];
  //   popularity = json['popularity'];
  //   profilePath = json['profile_path'];
  //   creditId = json['credit_id'];
  //   department = json['department'];
  //   job = json['job'];
  // }
  //
  // Map<String, dynamic> toJson() {
  //   final Map<String, dynamic> data = new Map<String, dynamic>();
  //   data['adult'] = this.adult;
  //   data['gender'] = this.gender;
  //   data['id'] = this.id;
  //   data['known_for_department'] = this.knownForDepartment;
  //   data['name'] = this.name;
  //   data['original_name'] = this.originalName;
  //   data['popularity'] = this.popularity;
  //   data['profile_path'] = this.profilePath;
  //   data['credit_id'] = this.creditId;
  //   data['department'] = this.department;
  //   data['job'] = this.job;
  //   return data;
  // }
}