import 'package:flutter/cupertino.dart';
import 'package:grocery_go/app.dart';
import 'package:grocery_go/di/env_module.dart';
import 'package:grocery_go/di/injector.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await configureDependencies(env: prod.name);
  runApp(const MyApp());
}
