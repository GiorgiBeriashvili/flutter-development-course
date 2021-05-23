import 'package:assignment_05/core/constants.dart' as constants;
import 'package:assignment_05/core/router.dart';
import 'package:assignment_05/data/repositories/repositories.dart';
import 'package:assignment_05/logic/blocs/blocs.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BlogApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) => MultiBlocProvider(
        providers: [
          BlocProvider<UserBloc>(
            create: (context) => UserBloc(
              userRepository: UserRepository(dio: Dio()),
            )..add(UserStarted()),
          ),
          BlocProvider<PostBloc>(
            create: (context) => PostBloc(
              postRepository: PostRepository(dio: Dio()),
            ),
          ),
        ],
        child: MaterialApp(
          title: constants.appTitle,
          theme: ThemeData.dark(),
          debugShowCheckedModeBanner: false,
          onGenerateRoute: MainRouter.onGenerateRoute,
        ),
      );
}
