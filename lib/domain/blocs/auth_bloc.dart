import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';

import '../api_client/account_api_client.dart';
import '../api_client/auth_api_client.dart';
import '../data_providers/session_data_provider.dart';

abstract class AuthEvent {}

class AuthCheckStatusEvent extends AuthEvent {}

class AuthLogoutEvent extends AuthEvent {}

class AuthLoginEvent extends AuthEvent {
  final String login;
  final String password;

  AuthLoginEvent({required this.login, required this.password});
}

// enum AuthStateStatus {
//   authorized,
//   notAuthorized,
//   inProgress,
// }

abstract class AuthState {}

class AuthAuthorizedState extends AuthState {
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AuthAuthorizedState && runtimeType == other.runtimeType;

  @override
  int get hashCode => 0;
}

class AuthUnAuthorizedState extends AuthState {
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AuthUnAuthorizedState && runtimeType == other.runtimeType;

  @override
  int get hashCode => 0;
}

class AuthFailureState extends AuthState {
  final Object error;

  AuthFailureState({required this.error});

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AuthFailureState &&
          runtimeType == other.runtimeType &&
          error == other.error;

  @override
  int get hashCode => error.hashCode;

}

class AuthInProgressState extends AuthState {
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AuthInProgressState && runtimeType == other.runtimeType;

  @override
  int get hashCode => 0;
}

class AuthCheckStatusInProgressState extends AuthState {
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AuthCheckStatusInProgressState && runtimeType == other.runtimeType;

  @override
  int get hashCode => 0;
}


//ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final _sessionDataProvider = SessionDataProvider();
  final accountApiClient = AccountApiClient();
  final authApiClient = AuthApiClient();

  AuthBloc(super.initialState) {
    on<AuthEvent>((event, emit) async {
      if (event is AuthCheckStatusEvent) {
       await onAuthCheckedStatusEvent(event, emit);
      } else if (event is AuthLoginEvent) {
        await onAuthLoginEvent(event, emit);
      } else if (event is AuthLogoutEvent) {
        await onAuthLogoutEvent(event, emit);
      }
    }, transformer: sequential());
    add(AuthCheckStatusEvent());
  }

  Future<void> onAuthCheckedStatusEvent(
      AuthCheckStatusEvent event, Emitter<AuthState> emit) async {
    emit(AuthInProgressState());
    final sessionId = await _sessionDataProvider.getSessionId();
    final newState =
       sessionId != null ? AuthAuthorizedState() : AuthUnAuthorizedState();
    emit(newState);
  }

  Future<void> onAuthLoginEvent(AuthLoginEvent event, Emitter<AuthState> emit) async {
    try {
      emit(AuthInProgressState());
      final sessionId = await authApiClient.auth(
          username: event.login, password: event.password);
      final accountId = await accountApiClient.getAccountInfo(sessionId);

      await _sessionDataProvider.setSessionId(sessionId);
      await _sessionDataProvider.setAccountId(accountId);
      emit(AuthAuthorizedState());
    } catch (error) {
      emit(AuthFailureState(error: error));
    }
  }

  Future<void> onAuthLogoutEvent(AuthLogoutEvent event, Emitter<AuthState> emit) async {
    try {
      await _sessionDataProvider.setSessionId(null);
      await _sessionDataProvider.setAccountId(null);
      emit(AuthUnAuthorizedState());
    } catch (error) {
      emit(AuthFailureState(error: error));
    }
  }
}
