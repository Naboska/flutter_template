import 'package:flutter/material.dart';
import 'package:flutter_template/blocs/user/user_bloc.dart';

class AuthScreen extends StatelessWidget {
  final UserBloc userBloc = UserBloc();

  AuthScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Title'),
      ),
      body: Center(
        child: StreamBuilder<UserState>(
          initialData: userBloc.state,
          stream: userBloc.stream,
          builder: (context, snapshot) {
            return const Text('in stream');
          },
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
