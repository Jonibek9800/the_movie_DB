import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:themoviedb/domain/blocs/auth_bloc.dart';

import '../../domain/api_client/apiClientException.dart';

abstract class AuthViewCubitState {}

class AuthViewCubitFormFillInProgressState extends AuthViewCubitState {
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AuthViewCubitFormFillInProgressState &&
          runtimeType == other.runtimeType;

  @override
  int get hashCode => 0;
}

class AuthViewCubitErrorState extends AuthViewCubitState {
  final String? errorMassage;

  AuthViewCubitErrorState(this.errorMassage);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AuthViewCubitErrorState &&
          runtimeType == other.runtimeType &&
          errorMassage == other.errorMassage;

  @override
  int get hashCode => errorMassage.hashCode;
}

class AuthViewCubitProgressState extends AuthViewCubitState {
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AuthViewCubitProgressState && runtimeType == other.runtimeType;

  @override
  int get hashCode => 0;
}

class AuthViewCubitSuccessState extends AuthViewCubitState {
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AuthViewCubitSuccessState && runtimeType == other.runtimeType;

  @override
  int get hashCode => 0;
}

class AuthViewCubit extends Cubit<AuthViewCubitState> {
  final AuthBloc authBloc;
  late final StreamSubscription<AuthState> authBlocSubscription;

  AuthViewCubit(super.initialState, this.authBloc) {
    // authBloc.add(AuthCheckStatusEvent());
    _onState(authBloc.state);
    authBlocSubscription = authBloc.stream.listen(_onState);
  }

  bool _isValid(String login, String password) =>
      login.isEmpty || password.isEmpty;

  void auth({required String login, required String password}) {
    if (_isValid(login, password)) {
      final state = AuthViewCubitErrorState("Заполгите поля логин и пароль.");
      emit(state);
      return;
    }
    authBloc.add(AuthLoginEvent(login: login, password: password));
  }

  void _onState(AuthState state) {
    if (state is AuthUnAuthorizedState) {
      emit(AuthViewCubitFormFillInProgressState());
    } else if (state is AuthAuthorizedState) {
      emit(AuthViewCubitSuccessState());
    } else if (state is AuthFailureState) {
      final message = _mapErrorToMessage(state.error);
      final newState = AuthViewCubitErrorState(message);
      emit(newState);
    } else if (state is AuthInProgressState) {
      emit(AuthViewCubitProgressState());
    } else if (state is AuthCheckStatusInProgressState) {
      emit(AuthViewCubitProgressState());
    }
  }

  String _mapErrorToMessage(Object error) {
    if (error is! ApiClientException) {
      return "Неизвестная ошибка попробуйте позже";
    }
    switch (error.type) {
      case ApiClientExceptionType.network:
        return "Сервер временно недоступен. Проверте подключени к интернету";
      case ApiClientExceptionType.auth:
        return "Неверний логин или пароль";
      case ApiClientExceptionType.other:
        return "Произашла ошибка попробйте сново";
      default:
        return "Unknown error";
    }
  }

  @override
  Future<void> close() {
    authBlocSubscription.cancel();
    return super.close();
  }
}

