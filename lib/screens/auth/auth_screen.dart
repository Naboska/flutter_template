import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_template/blocs/user/user_bloc.dart';
import 'package:flutter_template/screens/auth/auth_user_interceptor_widget.dart';
import 'package:flutter_template/screens/auth/auth_user_widget.dart';

class AuthScreen extends StatelessWidget {
  const AuthScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Title'),
      ),
      body: Center(
        child: BlocProvider<UserBloc>(
          create: (_) => UserBloc(),
          child: AuthUserInterceptorWidget(child: const AuthUserWidget()),
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
