import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_template/blocs/user/user_bloc.dart';
import 'package:flutter_template/widgets/shared/fields/form_input/form_input_widget.dart';
import 'package:flutter_template/widgets/shared/form/form_widget.dart';
import 'package:flutter_template/widgets/shared/possible_widget/possible_widget.dart';

class AuthUserWidget extends StatelessWidget {
  const AuthUserWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserBloc, UserState>(builder: (context, state) {
      final status = state.status;

      return PossibleWidget(
          isRender: true,
          child: () => SizedBox(
                width: 400,
                height: 400,
                child: Column(children: <Widget>[
                  const FormExample(),
                  if (status.isLoading) const CircularProgressIndicator(),
                  if (status.isError) const Text('Oops... error:(')
                ]),
              ));
    });
  }
}

class FormExample extends StatelessWidget {
  const FormExample({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FormWidget(
        onSubmit: (values) async {
          print(values);
        },
        builder: (formContext, buildContext) {
          return Column(children: [
            const FormInputWidget(name: 'test1'),
            const FormInputWidget(name: 'test2'),
            const FormInputWidget(name: 'test3'),
            ElevatedButton(
                onPressed: formContext.handleSubmit,
                child: const Text('Submit')),
          ]);
        });
  }
}
