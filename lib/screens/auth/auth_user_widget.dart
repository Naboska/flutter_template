import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_template/blocs/user/user_bloc.dart';
import 'package:flutter_template/widgets/shared/possible_widget/possible_widget.dart';

class A {
  final a = 1;
}

class AuthUserWidget extends StatelessWidget {
  const AuthUserWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserBloc, UserState>(builder: (context, state) {
      final status = state.status;

      return SizedBox(
        width: 400,
        height: 400,
        child: Column(children: <Widget>[
          // status.isLoading ? const CircularProgressIndicator() : Container()
          // or
          // if (status.isLoading) const CircularProgressIndicator(),
          PossibleWidget(
              isRender: status.isLoading,
              child: () => const CircularProgressIndicator()),
          PossibleWidget(
              isRender: status.isError,
              child: () => const Text('Oops... error:('))
        ]),
      );
    });
  }
}
