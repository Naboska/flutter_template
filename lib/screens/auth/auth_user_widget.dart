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
          isRender: status != UserStatus.initial,
          child: () =>
              SizedBox(
                width: 400,
                height: 400,
                child: Column(children: <Widget>[
                  FormWidget(children: [
                    FormInputWidget(name: 'test'),
                    FormInputWidget(name: 'test2'),
                    Example(),
                  ]),
                  if (status.isLoading) const CircularProgressIndicator(),
                  if (status.isError) const Text('Oops... error:(')
                ]),
              ));
    });
  }
}

class Example extends StatefulWidget {
  const Example({Key? key}) : super(key: key);

  @override
  State<Example> createState() => _ExampleState();
}

class _ExampleState extends State<Example> {
  late FormProvider ctx;

  @override
  void initState() {
    super.initState();

    ctx = FormWidget.of(context);
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: () {
          ctx.setValue(
              name: 'test2', value: '1312');
        },
        child: Text('error'));
  }
}