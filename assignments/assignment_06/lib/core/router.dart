import 'package:assignment_06/data/models/models.dart';
import 'package:assignment_06/presentation/screens/screens.dart';
import 'package:flutter/material.dart';

class MainRouter {
  static Route? onGenerateRoute(RouteSettings routeSettings) {
    if (routeSettings.name == HomeScreen.routeName) {
      return MaterialPageRoute(
        builder: (context) => const HomeScreen(),
      );
    } else if (routeSettings.name == NewsReleaseScreen.routeName) {
      final news = routeSettings.arguments as News;

      return MaterialPageRoute(
        builder: (context) => NewsReleaseScreen(news: news),
      );
    }
  }
}
