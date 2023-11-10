import 'package:themoviedb/domain/api_client/account_api_client.dart';
import 'package:themoviedb/domain/api_client/auth_api_client.dart';

import '../data_providerss/session_data_provider.dart';

class AuthService {
  final _sessionDataProvider = SessionDataProvider();
  final accountApiClient = AccountApiClient();
  final authApiClient = AuthApiClient();

  Future<bool> isAuth() async {
    final sessionId = await _sessionDataProvider.getSessionId();
    final isAuth = sessionId != null;
    return isAuth;
  }

  Future<void> login(String login, String password) async {
    final sessionId = await authApiClient.auth(username: login, password: password);
    final accountId = await accountApiClient.getAccountInfo(sessionId);

    await _sessionDataProvider.setSessionId(sessionId);
    await _sessionDataProvider.setAccountId(accountId);
  }
}
