import 'package:midterm_02/data/models/models.dart';
import 'package:midterm_02/presentation/screens/login_screen.dart';
import 'package:midterm_02/presentation/screens/screens.dart';
import 'package:flutter/material.dart';
import 'package:midterm_02/presentation/screens/transaction/add_transaction_screen.dart';
import 'package:midterm_02/presentation/screens/transaction/edit_transaction_screen.dart';

class AppRouter {
  static Route? onGenerateRoute(RouteSettings routeSettings) {
    if (routeSettings.name == HomeScreen.routeName) {
      final userId = routeSettings.arguments as int;

      return MaterialPageRoute(
        builder: (context) => HomeScreen(userId: userId),
      );
    } else if (routeSettings.name == LoginScreen.routeName) {
      return MaterialPageRoute(
        builder: (context) => const LoginScreen(),
      );
    } else if (routeSettings.name == AddTransactionScreen.routeName) {
      return MaterialPageRoute(
        builder: (context) => const AddTransactionScreen(),
      );
    } else if (routeSettings.name == EditTransactionScreen.routeName) {
      final transaction = routeSettings.arguments as Transaction;

      return MaterialPageRoute(
        builder: (context) => EditTransactionScreen(transaction: transaction),
      );
    }
  }
}
