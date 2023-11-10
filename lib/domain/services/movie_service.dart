import 'package:themoviedb/configuration/configuration.dart';

import '../api_client/movie_api_client.dart';
import '../entity/popular_movie_response.dart';

class MovieService {
  final _movieApiCliet = MovieApiClient();

  Future<PopularMoviesResponse> popularMovie(int page, String locale) async =>
      _movieApiCliet.popularMovies(
        page,
        locale,
        Configuration.apiKey,
      );

  Future<PopularMoviesResponse> searchMovie(
          int page, String local, String query) async =>
      _movieApiCliet.searchMovie(
        page,
        local,
        query,
        Configuration.apiKey,
      );
}
