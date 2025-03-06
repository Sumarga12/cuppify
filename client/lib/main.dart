import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'app/app.dart';
import 'app/di/di.dart';
import 'core/network/hive_service.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  // Initialize Hive Database
  await HiveService.init();

  // Delete all the hive data and boxes
  // await HiveService().clearAll();
  // Initialize Dependencies
  await initDependencies();

  runApp(const App());
}
