import 'dart:async';

import 'package:flutter/material.dart';

import '../../domain/api_client/apiClientException.dart';
import '../../domain/services/auth_service.dart';
import '../../global_context_helper.dart';
import '../../ui/navigator/main_navigator.dart';

class AuthModel {
  final _authService = AuthService();

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

  bool _isValid(String login, String password) =>
      login.isEmpty || password.isEmpty;

  Future<String?> _login(String login, String password) async {
    try {
      await model._authService.login(login, password);
    } on ApiClientException catch (e) {
      switch (e.type) {
        case ApiClientExceptionType.network:
          return
              "Сервер временно недоступен. Проверте подключени к интернету";
        case ApiClientExceptionType.auth:
          return "Неверний логин или пароль";
        case ApiClientExceptionType.other:
          return "Произашла ошибка попробйте сново";
        default:
          print(e);
      }
    } catch (error) {
      print("auth_model $error");
      return "Неизвестная ошибка попробуйте позже";
    }
    return null;
  }

  Future<void> auth(BuildContext context) async {
    final login = model.loginTextControl.text;
    final password = model.passwordTextControl.text;
    if (_isValid(login, password)) {
      model._errorMassage = "Заполгите поля логин и пароль.";
      notifyListeners();
      return;
    }
    model._errorMassage = null;
    model._isAuthProgress = true;
    notifyListeners();

    model._errorMassage = await _login(login, password);
    model._isAuthProgress = false;
    if (model._errorMassage != null) {
      notifyListeners();
      return;
    }
    authNavigation();
  }

  void authNavigation() {
    final context = GlobalContextHelper.state.currentContext;
    MainNavigation.resetNavigation(context!);
  }
}
