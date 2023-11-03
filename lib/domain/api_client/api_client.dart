import 'dart:convert';
import 'dart:io';

import 'package:themoviedb/domain/entity/movie_details.dart';
import 'package:themoviedb/domain/entity/popular_movie_response.dart';

import '../entity/movie_credits.dart';

enum ApiClientExceptionType { Network, Auth, Other, SessionExpaired }

class ApiClientException implements Exception {
  final ApiClientExceptionType type;

  ApiClientException(this.type);
}

enum MediaType { Movie, TV }

extension MediaTypeAsString on MediaType {
  String asString() {
    switch (this) {
      case MediaType.Movie:
        return "movie";
      case MediaType.TV:
        return 'tv';
      default:
        return 'movie';
    }
  }
}

class ApiClient {
  final _client = HttpClient();
  static const _host = 'https://api.themoviedb.org/3';
  static const _imageUrl = 'https://image.tmdb.org/t/p/w500';
  static const _apiKey = 'fed5cdfaae2b427421d53f81b241f49f';

  static String imageUrl(String path) => _imageUrl + path;

  Future<String> auth({
    required username,
    required String password,
  }) async {
    final token = await _makeToken();
    final validToken = await _validateUser(
        username: username, password: password, requesToken: token);
    final sessionId = await _makeSession(requesToken: validToken);
    return sessionId;
  }

  Uri makeUri(String path, [Map<String, dynamic>? parameters]) {
    final uri = Uri.parse("$_host$path");
    if (parameters != null) {
      return uri.replace(queryParameters: parameters);
    } else {
      return uri;
    }
  }

  Future<T> _get<T>(String path,
      T Function(dynamic json) parser, [
        Map<String, dynamic>? parameters,
      ]) async {
    final url = makeUri(path, parameters);
    try {
      final request = await _client.getUrl(url);
      final response = await request.close();
      final dynamic json = await response.jsonDecode();
      _validateResponse(response, json);
      final result = parser(json);
      return result;
    } on SocketException {
      throw ApiClientException(ApiClientExceptionType.Network);
    } on ApiClientException {
      rethrow;
    } catch (error) {
      print('error: ${error}');
      throw ApiClientException(ApiClientExceptionType.Other);
    }
  }

  Future<T> _post<T>(String path, T Function(dynamic json) parser,
      Map<String, dynamic>? bodyParameters,
      [Map<String, dynamic>? urlParameters]) async {
    try {
      final url = makeUri(path, urlParameters);
      final request = await _client.postUrl(url);
      request.headers.contentType = ContentType.json;
      request.write(jsonEncode(bodyParameters));
      final response = await request.close();
      final dynamic json = await response.jsonDecode();
      _validateResponse(response, json);
      final token = parser(json);
      return token;
    } on SocketException {
      throw ApiClientException(ApiClientExceptionType.Network);
    } on ApiClientException {
      rethrow;
    } catch (error) {
      print("error: $error");
      throw ApiClientException(ApiClientExceptionType.Other);
    }
  }

  Future<String> _makeToken() async {
    parser(dynamic json) {
      final jsonMap = json as Map<String, dynamic>;
      final token = jsonMap["request_token"] as String;
      return token;
    }

    final result = _get(
      "/authentication/token/new",
      parser,
      {"api_key": _apiKey},
    );
    return result;
  }

  Future<int> getAccountInfo(String sessionId) async {
    parser(dynamic json) {
      final jsonMap = json as Map<String, dynamic>;
      final response = jsonMap['id'] as int;
      return response;
    }

    final result = _get(
      "/account",
      parser,
      {"api_key": _apiKey, "session_id": sessionId},
    );
    return result;
  }

  Future<String> markAsFavorite({required int acountId,
    required String sessionId,
    required MediaType mediaType,
    required int mediaId,
    required bool isFavorite}) async {
    parser(dynamic json) {
      final jsonMap = json as Map<String, dynamic>;
      final token = jsonMap["status_message"] as String;
      return token;
    }

    final parameters = <String, dynamic>{
      "media_type": mediaType.asString(),
      "media_id": mediaId.toString(),
      "favorite": isFavorite
    };
    final result = _post(
      "/account/$acountId/favorite",
      parser,
      parameters,
      <String, dynamic>{
        "api_key": _apiKey,
        "session_id": sessionId,
      },
    );
    return result;
  }

  Future<String> _validateUser({required username,
    required String password,
    required String requesToken}) async {
    parser(dynamic json) {
      final jsonMap = json as Map<String, dynamic>;
      final token = jsonMap["request_token"] as String;
      return token;
    }

    final parameters = <String, dynamic>{
      "username": username,
      "password": password,
      "request_token": requesToken
    };
    final result =
    _post("/authentication/token/validate_with_login", parser, parameters, {
      "api_key": _apiKey,
    });
    return result;
  }

  Future<String> _makeSession({required String requesToken}) async {
    parser(dynamic json) {
      final jsonMap = json as Map<String, dynamic>;
      final sesionId = jsonMap["session_id"] as String;
      return sesionId;
    }

    final parameters = <String, dynamic>{"request_token": requesToken};
    final result = _post("/authentication/session/new", parser, parameters, {
      "api_key": _apiKey,
    });
    return result;
  }

// Запрос получение популярных фильмов
  Future<PopularMoviesResponse> popularMovies(int page, String language) async {
    parser(dynamic json) {
      final jsonMap = json as Map<String, dynamic>;
      final response = PopularMoviesResponse.fromJson(jsonMap);
      return response;
    }

    final result = _get(
      "/movie/popular",
      parser,
      {"api_key": _apiKey, "language": language, "page": page.toString()},
    );
    return result;
  }

// Поисковой заппрос фильма
  Future<PopularMoviesResponse> searchMovie(int page, String local,
      String query) async {
    parser(dynamic json) {
      final jsonMap = json as Map<String, dynamic>;
      final response = PopularMoviesResponse.fromJson(jsonMap);
      return response;
    }

    final result = _get(
      "/search/movie",
      parser,
      {
        "api_key": _apiKey,
        "language": local,
        "page": page.toString(),
        'query': query,
        'include_adult': true.toString()
      },
    );
    return result;
  }

  Future<MoviesDatails> movieDetails(int movieId, String local) async {
    parser(dynamic json) {
      final jsonMap = json as Map<String, dynamic>;
      final response = MoviesDatails.fromJson(jsonMap);
      return response;
    }

    final result = _get(
      "/movie/$movieId",
      parser,
      {
        "append_to_response": "videos",
        "api_key": _apiKey,
        "language": local,
      },
    );
    return result;
  }

  Future<bool> isFavorite(int movieId, String sesionId) async {
    parser(dynamic json) {
      final jsonMap = json as Map<String, dynamic>;
      final response = jsonMap['favorite'] as bool;
      return response;
    }

    final result = _get(
      "/movie/$movieId/account_states",
      parser,
      {"session_id": sesionId, "api_key": _apiKey},
    );
    return result;
  }

  Future<MovieCredits> movieCredits(int movieId, String local) async {
    parser(dynamic json) {
      final jsonMap = json as Map<String, dynamic>;
      final response = MovieCredits.fromJson(jsonMap);
      return response;
    }

    final result = _get(
      "/movie/$movieId/credits",
      parser,
      {
        "api_key": _apiKey,
        "language": local,
      },
    );
    return result;
  }

  void _validateResponse(HttpClientResponse response, dynamic json) {
    if (response.statusCode == 401) {
      final status = json["status_code"];
      final code = status is int ? status : 0;
      if (code == 30) {
        throw ApiClientException(ApiClientExceptionType.Auth);
      } else if (code == 3) {
        throw ApiClientException(ApiClientExceptionType.SessionExpaired);
      } else {
        throw ApiClientException(ApiClientExceptionType.Other);
      }
    }
  }
}

extension HttpClientResponceJsonDecode on HttpClientResponse {
  Future<dynamic> jsonDecode() async {
    return transform(utf8.decoder)
        .toList()
        .then((value) => value.join())
        .then((value) => json.decode(value));
  }
}
