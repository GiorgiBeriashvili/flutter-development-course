import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:midterm_02/core/exceptions.dart';

part '../events/authentication_event.dart';
part '../states/authentication_state.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  AuthenticationBloc() : super(AuthenticationInitial());

  @override
  Stream<AuthenticationState> mapEventToState(
    AuthenticationEvent event,
  ) async* {
    if (event is AuthenticationInitialized) {
      yield AuthenticationInitial();
    } else if (event is AuthenticationStarted) {
      yield AuthenticationLoadInProgress();

      try {
        final userId = event.userId;

        yield AuthenticationLoadSuccess(userId: userId);
      } on AuthenticationException catch (exception) {
        yield AuthenticationLoadFailure(exception: exception);
      }
    }
  }
}
