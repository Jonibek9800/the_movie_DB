import 'package:json_annotation/json_annotation.dart';
import 'package:themoviedb/domain/entity/movies.dart';

part 'popular_movie_response.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
class PopularMoviesResponse {
  final int page;
  @JsonKey(name: "results")
  final List<Movie> movies;
  final int totalPages;
  final int? totalResult;


  const PopularMoviesResponse({
    required this.page,
    required this.movies,
    required this.totalPages,
    required this.totalResult,

  });

  factory PopularMoviesResponse.fromJson(Map<String, dynamic> json) =>
      _$PopularMoviesResponseFromJson(json);

  Map<String, dynamic> toJson() => _$PopularMoviesResponseToJson(this);
}
