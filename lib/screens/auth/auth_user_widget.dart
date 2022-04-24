import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_template/blocs/user/user_bloc.dart';
import 'package:flutter_template/widgets/shared/fields/form_input/form_input_widget.dart';
import 'package:flutter_template/widgets/shared/form/form.dart';
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

  Map<String, String> _validation(Map<String, dynamic> values) {
    final next = <String, String>{};

    if (values['test1'] != 'test') next['test1'] = 'invalid value';
    return next;
  }

  Future<void> _onFormSubmit(Map<String, dynamic> values) async {
    await Future.delayed(const Duration(seconds: 4));
    print(values);
  }

  @override
  Widget build(BuildContext context) {
    return FormWidget(
        validation: _validation,
        onSubmit: _onFormSubmit,
        builder: (formContext, buildContext) {
          return Column(children: [
            const FormInputWidget(name: 'test1'),
            const FormInputWidget(name: 'test2'),
            const FormInputWidget(name: 'test3'),
            FormWatch(
                watch: const ['test1', 'test2', 'test3'],
                builder: (state, formContext, context) {
                  final bool isLoading = state.formState.isSubmitting;
                  final bool isDirty = state.formState.isDirty;
                  final bool isError = state.errors.isNotEmpty;
                  final bool disabled = isLoading || (!isDirty && isError);

                  return ElevatedButton(
                      onPressed: !disabled ? formContext.handleSubmit : null,
                      child: isLoading
                          ? const SizedBox(
                              width: 12,
                              height: 12,
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                              ))
                          : const Text('Submit'));
                })
          ]);
        });
  }
}
