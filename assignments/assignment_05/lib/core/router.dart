import 'package:assignment_05/presentation/screens/screens.dart';
import 'package:flutter/material.dart';

class MainRouter {
  static Route? onGenerateRoute(RouteSettings routeSettings) {
    if (routeSettings.name == HomeScreen.routeName) {
      return MaterialPageRoute(
        builder: (context) => HomeScreen(),
      );
    } else if (routeSettings.name == PostsScreen.routeName) {
      final userId = routeSettings.arguments as int;

      return MaterialPageRoute(
        builder: (context) => PostsScreen(userId: userId),
      );
    } else if (routeSettings.name == AddPostScreen.routeName) {
      final userId = routeSettings.arguments as int;

      return MaterialPageRoute(
        builder: (context) => AddPostScreen(userId: userId),
      );
    }
  }
}
