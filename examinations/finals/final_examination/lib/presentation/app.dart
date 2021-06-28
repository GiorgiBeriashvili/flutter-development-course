import 'package:final_examination/core/constants.dart' as constants;
import 'package:final_examination/core/router.dart';
import 'package:final_examination/core/theme.dart';
import 'package:final_examination/logic/blocs/blocs.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:final_examination/presentation/screens/screens.dart';

class TodoListApp extends StatelessWidget {
  const TodoListApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => BlocProvider(
        create: (context) => AuthenticationBloc(),
        child: MaterialApp(
          title: constants.appTitle,
          theme: AppTheme.themeData(context),
          debugShowCheckedModeBanner: false,
          initialRoute: LoginScreen.routeName,
          onGenerateRoute: AppRouter.onGenerateRoute,
        ),
      );
}
