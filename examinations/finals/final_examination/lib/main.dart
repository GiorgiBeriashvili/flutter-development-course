import 'package:firebase_core/firebase_core.dart';
import 'package:final_examination/logic/app_bloc_observer.dart';
import 'package:final_examination/presentation/app.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();

  Bloc.observer = AppBlocObserver();

  runApp(const TodoListApp());
}
