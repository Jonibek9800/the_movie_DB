// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'popular_movie_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PopularMoviesResponse _$PopularMoviesResponseFromJson(
        Map<String, dynamic> json) =>
    PopularMoviesResponse(
      page: json['page'] as int,
      movies: (json['results'] as List<dynamic>)
          .map((e) => Movie.fromJson(e as Map<String, dynamic>))
          .toList(),
      totalPages: json['total_pages'] as int,
      totalResult: json['total_result'] as int?,
    );

Map<String, dynamic> _$PopularMoviesResponseToJson(
        PopularMoviesResponse instance) =>
    <String, dynamic>{
      'page': instance.page,
      'results': instance.movies.map((e) => e.toJson()).toList(),
      'total_pages': instance.totalPages,
      'total_result': instance.totalResult,
    };
