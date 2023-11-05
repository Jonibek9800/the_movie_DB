import 'dart:async';

import 'package:flutter/material.dart';
import 'package:themoviedb/domain/api_client/api_client.dart';

import '../../domain/data_providerss/session_data_provider.dart';
import '../../global_context_helper.dart';
import '../../ui/navigator/main_navigator.dart';

class AuthModel {
  final _apiClient = ApiClient();
  final _sessionDataProvider = SessionDataProvider();

  final loginTextControl = TextEditingController();
  final passwordTextControl = TextEditingController();

  bool _isAuthProgress = false;

  bool get canStartAuth => !_isAuthProgress;

  bool get isAuthProgress => _isAuthProgress;

  String? _errorMassage;

  String? get errorMassege => _errorMassage;
}

class AuthViewModel extends ChangeNotifier {
  AuthModel model = AuthModel();

  Future<void> auth(BuildContext context) async {
    final login = model.loginTextControl.text;
    final password = model.passwordTextControl.text;
    if (login.isEmpty || password.isEmpty) {
      model._errorMassage = "Заполгите поля логин и пароль.";
      notifyListeners();
      return;
    }
    model._errorMassage = null;
    model._isAuthProgress = true;
    notifyListeners();
    String? sessionId;
    int? accountId;
    try {
      sessionId =
          await model._apiClient.auth(username: login, password: password);
      accountId = await model._apiClient.getAccountInfo(sessionId);
    } on ApiClientException catch (e) {
      switch (e.type) {
        case ApiClientExceptionType.Network:
          model._errorMassage =
              "Сервер временно недоступен. Проверте подключени к интернету";
          break;
        case ApiClientExceptionType.Auth:
          model._errorMassage = "Неверний логин или пароль";
          break;
        case ApiClientExceptionType.Other:
          model._errorMassage = "Неизвестная ошибка попробуйте позже";
          break;
        default:
          print(e);
        //notifyListeners();
      }
    } catch (error) {
      model._errorMassage = "Invalid login or password";
      notifyListeners();
    }
    model._isAuthProgress = false;
    if (model._errorMassage != null) {
      notifyListeners();
      return;
    }
    if (sessionId == null || accountId == null) {
      model._errorMassage = "Unknown error try later";
      notifyListeners();
      return;
    }

    await model._sessionDataProvider.setSessionId(sessionId);
    await model._sessionDataProvider.setAccountId(accountId);
    authNavigation();
  }

  void authNavigation() {
    final context = GlobalContextHelper.state.currentContext;
    Navigator.of(context!)
        .pushReplacementNamed(MainNavigationRouteNames.mainScreen);
  }
}
