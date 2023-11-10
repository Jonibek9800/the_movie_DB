import 'package:flutter/cupertino.dart';
import 'package:themoviedb/ui/navigator/main_navigator.dart';

import '../../domain/data_providerss/session_data_provider.dart';
import '../../domain/services/auth_service.dart';

class LoaderViewModel {
  final BuildContext context;
  final authService = AuthService();

  LoaderViewModel(this.context) {
    asyncInit();
  }

  Future<void> asyncInit() async {
    await checkAuth();
  }

  Future<void> checkAuth() async {
    final isAuth = await authService.isAuth();
    final nextScreen = isAuth
        ? MainNavigationRouteNames.mainScreen
        : MainNavigationRouteNames.auth;
    Navigator.of(context).pushReplacementNamed(nextScreen);
  }

}
