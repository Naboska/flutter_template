import 'package:flutter_dotenv/flutter_dotenv.dart';

class Env {
  static bool isProduction = const bool.fromEnvironment('dart.vm.product');
  static String get clientUrl => dotenv.get('API_URL');
}
