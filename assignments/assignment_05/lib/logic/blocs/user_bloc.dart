import 'dart:async';

import 'package:assignment_05/data/models/models.dart';
import 'package:assignment_05/data/repositories/repositories.dart';
import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';

part '../events/user_event.dart';
part '../states/user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final UserRepository userRepository;

  UserBloc({
    required this.userRepository,
  }) : super(UserInitial());

  @override
  Stream<UserState> mapEventToState(
    UserEvent event,
  ) async* {
    if (event is UserStarted) {
      yield UserLoadInProgress();

      try {
        final users = await userRepository.readAll();

        yield UserLoadSuccess(users: users);
      } on DioError catch (exception) {
        yield UserLoadFailure(exception: exception);
      }
    }
  }
}
