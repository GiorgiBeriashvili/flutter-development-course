import 'dart:io';

import 'package:assignment_06/logic/main_bloc_observer.dart';
import 'package:assignment_06/presentation/app.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final data = await rootBundle.load(
    'assets/security/imgsrc-hubblesite-org.pem',
  );

  final context = SecurityContext.defaultContext;

  context.setTrustedCertificatesBytes(data.buffer.asUint8List());

  Bloc.observer = MainBlocObserver();

  runApp(const SpaceTelescopeNewsApp());
}
