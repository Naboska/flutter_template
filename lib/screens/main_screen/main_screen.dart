import 'package:flutter/material.dart';

import 'package:flutter_template/screens/auth_screen/auth_screen.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const AuthScreen(title: 'Flutter Demo Home Page'),
    );
  }
}
