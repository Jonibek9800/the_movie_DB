  import '../../configuration/configuration.dart';
import 'network_client.dart';

enum MediaType { movie, tv }

extension MediaTypeAsString on MediaType {
  String asString() {
    switch (this) {
      case MediaType.movie:
        return "movie";
      case MediaType.tv:
        return 'tv';
      default:
        return 'movie';
    }
  }
}

class AccountApiClient {
  final networkClient = NetworkClient();

  Future<int> getAccountInfo(String sessionId) async {
    parser(dynamic json) {
      final jsonMap = json as Map<String, dynamic>;
      final response = jsonMap['id'] as int;
      return response;
    }

    final result = await networkClient.get(
      "/account",
      parser,
      {"api_key": Configuration.apiKey, "session_id": sessionId},
    );
    return result;
  }

  Future<String> markAsFavorite(
      {required int acountId,
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
    final result = await networkClient.post(
      "/account/$acountId/favorite",
      parser,
      parameters,
      <String, dynamic>{
        "api_key": Configuration.apiKey,
        "session_id": sessionId,
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

    final result = await networkClient.get(
      "/movie/$movieId/account_states",
      parser,
      {"session_id": sesionId, "api_key": Configuration.apiKey},
    );
    return result;
  }

}