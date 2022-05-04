import 'package:flutter/material.dart';

import 'package:flutter_template/widgets/shared/fields/form_input/form_input_widget.dart';
import 'package:flutter_template/widgets/shared/form/form.dart';

class AuthFormExample extends StatelessWidget {
  const AuthFormExample({Key? key}) : super(key: key);

  Future<TFormErrorValues> _validation(Map<String, dynamic> values) async {
    final next = <String, String>{};

    if (values['test2'] != values['test4']) {
      next['test4'] = 'test2 and test4 not equals';
    }

    if ([null, ''].contains(values['test1'])) next['test1'] = 'required';
    if ([null, ''].contains(values['test2'])) next['test2'] = 'required';
    if ([null, ''].contains(values['test3'])) next['test3'] = 'required';
    if ([null, ''].contains(values['test4'])) next['test4'] = 'required';

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
            const FormDevtoolsWidget(),
            const FormInputWidget(name: 'test1', label: 'test1'),
            const FormInputWidget(name: 'test2', label: 'test2'),
            const FormInputWidget(name: 'test3', label: 'test3'),
            const FormInputWidget(name: 'test4', label: 'test4'),
            FormWatch(
                watch: const [],
                builder: (state, formContext, context) {
                  final bool isLoading = state.formState.isSubmitting;
                  final bool isDirty = state.formState.isDirty;
                  final bool isValid = state.formState.isValid;
                  final bool disabled = isLoading || (isDirty && !isValid);

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
                }),
          ]);
        });
  }
}
