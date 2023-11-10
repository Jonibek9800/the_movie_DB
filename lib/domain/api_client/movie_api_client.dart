import 'package:themoviedb/domain/entity/movie_details.dart';
import 'package:themoviedb/domain/entity/popular_movie_response.dart';

import '../entity/movie_credits.dart';
import 'network_client.dart';


class MovieApiClient {
  final networkClient = NetworkClient();

// Запрос получение популярных фильмов
  Future<PopularMoviesResponse> popularMovies(int page, String language,
      String apiKey) async {
    parser(dynamic json) {
      final jsonMap = json as Map<String, dynamic>;
      final response = PopularMoviesResponse.fromJson(jsonMap);
      return response;
    }

    final result = await networkClient.get(
      "/movie/popular",
      parser,
      {
        "api_key": apiKey,
        "language": language,
        "page": page.toString()
      },
    );
    return result;
  }

// Поисковой заппрос фильма
  Future<PopularMoviesResponse> searchMovie(int page, String local,
      String query, String apiKey) async {
    parser(dynamic json) {
      final jsonMap = json as Map<String, dynamic>;
      final response = PopularMoviesResponse.fromJson(jsonMap);
      return response;
    }
    final result = await networkClient.get(
      "/search/movie",
      parser,
      {
        "api_key": apiKey,
        "language": local,
        "page": page.toString(),
        'query': query,
        'include_adult': true.toString()
      },
    );
    return result;
  }

  Future<MoviesDatails> movieDetails(int movieId, String local,
      String apiKey) async {
    parser(dynamic json) {
      final jsonMap = json as Map<String, dynamic>;
      final response = MoviesDatails.fromJson(jsonMap);
      return response;
    }

    final result = await networkClient.get(
      "/movie/$movieId",
      parser,
      {
        "append_to_response": "videos",
        "api_key": apiKey,
        "language": local,
      },
    );
    return result;
  }


  Future<MovieCredits> movieCredits(int movieId, String local,
      String apiKey) async {
    parser(dynamic json) {
      final jsonMap = json as Map<String, dynamic>;
      final response = MovieCredits.fromJson(jsonMap);
      return response;
    }

    final result = await networkClient.get(
      "/movie/$movieId/credits",
      parser,
      {
        "api_key": apiKey,
        "language": local,
      },
    );
    return result;
  }
}
