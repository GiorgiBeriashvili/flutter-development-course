import 'package:final_examination/presentation/screens/login_screen.dart';
import 'package:final_examination/presentation/screens/screens.dart';
import 'package:flutter/material.dart';

class AppRouter {
  static Route? onGenerateRoute(RouteSettings routeSettings) {
    if (routeSettings.name == TodosScreen.routeName) {
      final userId = routeSettings.arguments as String;

      return MaterialPageRoute(
        builder: (context) => TodosScreen(userId: userId),
      );
    } else if (routeSettings.name == LoginScreen.routeName) {
      return MaterialPageRoute(
        builder: (context) => const LoginScreen(),
      );
    }
  }
}
