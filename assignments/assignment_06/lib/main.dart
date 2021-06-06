import 'dart:io';

import 'package:assignment_06/logic/main_bloc_observer.dart';
import 'package:assignment_06/presentation/app.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final byteData = await rootBundle.load(
    'assets/security/imgsrc-hubblesite-org.pem',
  );

  final securityContext = SecurityContext.defaultContext;

  securityContext.setTrustedCertificatesBytes(byteData.buffer.asUint8List());

  Bloc.observer = MainBlocObserver();

  runApp(const SpaceTelescopeNewsApp());
}
