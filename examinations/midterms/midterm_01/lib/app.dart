import 'package:flutter/material.dart';
import 'package:midterm_01/constants.dart' as constants;

import 'package:midterm_01/screens/screens.dart';

class ClothesShopApp extends StatelessWidget {
  const ClothesShopApp({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => MaterialApp(
        debugShowCheckedModeBanner: false,
        title: constants.appTitle,
        initialRoute: '/',
        routes: {
          ClothesScreen.routeName: (context) => ClothesScreen(),
          ClothesAddScreen.routeName: (context) => ClothesAddScreen(),
          ClothesDetailsScreen.routeName: (context) => ClothesDetailsScreen(),
          ClothesEditScreen.routeName: (context) => ClothesEditScreen(),
        },
      );
}
