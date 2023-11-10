import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:themoviedb/domain/data_providerss/session_data_provider.dart';
import 'package:themoviedb/global_context_helper.dart';
import 'package:themoviedb/ui/navigator/main_navigator.dart';

class MyAppModel extends ChangeNotifier {
  final _sessionDataProvider = SessionDataProvider();
  var _isAuth = false;

  bool get isAuth => _isAuth;

  Future<void> checkAuth() async {
    final sessionId = await _sessionDataProvider.getSessionId();
    _isAuth = sessionId != null;
  }

  Future<void> resetSession() async {
    await _sessionDataProvider.setSessionId(null);
    await _sessionDataProvider.setAccountId(null);
    resetSessionNav();
  }
}

void resetSessionNav() {
  final context = GlobalContextHelper.state.currentContext;
  Navigator.of(context!)
      .pushNamedAndRemoveUntil(MainNavigationRouteNames.auth, (route) => false);
}
