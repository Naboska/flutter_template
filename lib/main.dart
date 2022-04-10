import 'package:flutter/material.dart';

import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'package:flutter_template/screens/main_screen/main_screen.dart';

void main() async {
  await dotenv.load();

  runApp(const MainScreen());
}

