import 'package:assignment_06/core/constants.dart' as constants;
import 'package:assignment_06/core/router.dart';
import 'package:assignment_06/data/repositories/repositories.dart';
import 'package:assignment_06/logic/blocs/blocs.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SpaceTelescopeNewsApp extends StatelessWidget {
  const SpaceTelescopeNewsApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => MultiBlocProvider(
        providers: [
          BlocProvider<NewsBloc>(
            create: (context) => NewsBloc(
              newsRepository: NewsRepository(dio: Dio()),
            )..add(NewsStarted()),
          ),
          BlocProvider<NewsReleaseBloc>(
            create: (context) => NewsReleaseBloc(
              newsReleaseRepository: NewsReleaseRepository(dio: Dio()),
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
