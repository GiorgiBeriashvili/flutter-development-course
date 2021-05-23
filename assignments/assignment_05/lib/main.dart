import 'package:assignment_05/logic/main_bloc_observer.dart';
import 'package:assignment_05/presentation/app.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  Bloc.observer = MainBlocObserver();

  runApp(BlogApp());
}
