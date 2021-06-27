import 'package:flutter/material.dart';
import 'package:midterm_01/constants.dart' as constants;
import 'package:midterm_01/models/models.dart';

import 'package:midterm_01/repositories/repositories.dart';
import 'package:midterm_01/screens/screens.dart';
import 'package:midterm_01/widgets/widgets.dart';

class ClothesScreen extends StatefulWidget {
  static const routeName = '/';

  const ClothesScreen({
    Key? key,
  }) : super(key: key);

  @override
  _ClothesScreenState createState() => _ClothesScreenState();
}

class _ClothesScreenState extends State<ClothesScreen> {
  final _clothing = ClothesRepository().fetch();

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: Text(constants.appTitle),
          centerTitle: true,
        ),
        body: GridView.count(
          crossAxisCount: 2,
          children: List.generate(
            _clothing.length,
            (index) => GestureDetector(
              onTap: () => Navigator.pushNamed(
                context,
                ClothesDetailsScreen.routeName,
                arguments: ClothesDetailsScreenArguments(
                  index: index,
                  clothes: _clothing[index],
                ),
              ).then((value) => setState(() {})),
              onLongPress: () => Navigator.pushNamed(
                context,
                ClothesEditScreen.routeName,
                arguments: ClothesEditScreenArguments(
                  index: index,
                  clothes: _clothing[index],
                ),
              ).then((_) => setState(() {})),
              child: ClothesItem(
                clothes: _clothing[index],
              ),
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () => Navigator.pushNamed(
            context,
            ClothesAddScreen.routeName,
          ).then((value) => setState(() {})),
        ),
      );
}
