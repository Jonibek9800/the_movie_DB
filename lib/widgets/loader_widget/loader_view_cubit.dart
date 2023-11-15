import 'dart:async';

import 'package:bloc/bloc.dart';

import '../../domain/blocs/auth_bloc.dart';

enum LoaderViewCubitState { unknown, authorized, unAuthorized }

class LoaderViewCubit extends Cubit<LoaderViewCubitState> {
  final AuthBloc authBloc;
  late final StreamSubscription<AuthState> authBlocSubscription;

  LoaderViewCubit(
    super.initialState,
    this.authBloc,
  ) {
    Future.microtask(() {
      authBloc.add(AuthCheckStatusEvent());
      _onState(authBloc.state);
      authBlocSubscription = authBloc.stream.listen(_onState);
    });
  }

  void _onState(AuthState state) {
    if (state is AuthAuthorizedState) {
      emit(LoaderViewCubitState.authorized);
    } else if (state is AuthUnAuthorizedState) {
      emit(LoaderViewCubitState.unAuthorized);
    }
  }

  @override
  Future<void> close() {
    authBlocSubscription.cancel();
    return super.close();
  }
}
