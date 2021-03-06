import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_template/blocs/user/user_bloc.dart';
import 'auth_form_example_widget.dart';

class AuthUserWidget extends StatelessWidget {
  const AuthUserWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const AuthFormExample(),
        BlocBuilder<UserBloc, UserState>(builder: (context, state) {
          final status = state.status;

          return Column(children: <Widget>[
            if (status.isLoading) const CircularProgressIndicator(),
            if (status.isError) const Text('Oops... error:(')
          ]);
        }),
      ],
    );
  }
}
