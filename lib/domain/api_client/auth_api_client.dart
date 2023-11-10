import '../../configuration/configuration.dart';
import 'network_client.dart';

class AuthApiClient {
  final networkClient = NetworkClient();

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

  Future<String> _makeToken() async {
    parser(dynamic json) {
      final jsonMap = json as Map<String, dynamic>;
      final token = jsonMap["request_token"] as String;
      return token;
    }

    final result = await networkClient.get(
      "/authentication/token/new",
      parser,
      {"api_key": Configuration.apiKey},
    );
    return result;
  }

  Future<String> _validateUser(
      {required username,
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
    final result = await networkClient
        .post("/authentication/token/validate_with_login", parser, parameters, {
      "api_key": Configuration.apiKey,
    });
    return result;
  }

  Future<String> _makeSession({required String requesToken}) async {
    parser(dynamic json) {
      final jsonMap = json as Map<String, dynamic>;
      final sessionId = jsonMap["session_id"] as String;
      return sessionId;
    }

    final parameters = <String, dynamic>{"request_token": requesToken};
    final result = await networkClient
        .post("/authentication/session/new", parser, parameters, {
      "api_key": Configuration.apiKey,
    });
    return result;
  }
}