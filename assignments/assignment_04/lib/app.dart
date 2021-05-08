import 'package:assignment_04/repositories/repositories.dart';
import 'package:flutter/material.dart';
import 'package:assignment_04/constants.dart' as constants;

import 'package:assignment_04/screens/screens.dart';
import 'package:provider/provider.dart';

class MoviesApp extends StatelessWidget {
  const MoviesApp({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => ChangeNotifierProvider.value(
        value: MovieRepository(),
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: constants.appTitle,
          theme: ThemeData.dark(),
          initialRoute: MoviesScreen.routeName,
          routes: {
            MoviesScreen.routeName: (context) => MoviesScreen(),
            MoviesAddScreen.routeName: (context) => MoviesAddScreen(),
            MoviesDetailsScreen.routeName: (context) => MoviesDetailsScreen(),
            MoviesEditScreen.routeName: (context) => MoviesEditScreen(),
          },
        ),
      );
}
