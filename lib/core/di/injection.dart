// lib/injection.dart
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';

// Import the generated config file (will be created by build_runner)
import 'injection.config.dart'; // Or injection.config.dart if you rename

final sl = GetIt.instance; // Service Locator instance

@InjectableInit( // Annotation to initialize the generation process
  initializerName: r'$initGetIt', // default initializer name
  preferRelativeImports: true, // recommended for better structure
  asExtension: false, // keep it as a function for clarity here
)
Future<void> configureDependencies() async => $initGetIt(sl); // Call the generated function

// You might need this if you have different environment setups (dev, prod, test)
// Example:
// @InjectableInit( ...)
// Future<void> configureDependencies({String environment = Environment.prod}) async =>
//    $initGetIt(sl, environment: environment);