import 'package:flutter/material.dart';
import 'core/di/injection.dart' as di;
import 'features/app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized(); // Needed for async init before runApp
  await di.configureDependencies(); // Initialize GetIt dependencies
  runApp(MyApp());
}
