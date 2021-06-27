import 'package:midterm_02/core/constants.dart' as constants;
import 'package:midterm_02/core/router.dart';
import 'package:midterm_02/logic/blocs/blocs.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:midterm_02/presentation/screens/screens.dart';

class PersonalExpensesApp extends StatelessWidget {
  const PersonalExpensesApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => BlocProvider(
        create: (context) => AuthenticationBloc(),
        child: MaterialApp(
          title: constants.appTitle,
          theme: ThemeData.dark(),
          debugShowCheckedModeBanner: false,
          initialRoute: LoginScreen.routeName,
          onGenerateRoute: AppRouter.onGenerateRoute,
        ),
      );
}
