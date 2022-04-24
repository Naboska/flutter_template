import 'package:flutter/material.dart';
import 'package:flutter_template/widgets/shared/form/form.dart';
import 'package:flutter_template/widgets/shared/fields/form_input/form_input_widget.dart';

class AuthFormExample extends StatelessWidget {
  const AuthFormExample({Key? key}) : super(key: key);

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
            const FormInputWidget(name: 'test1', label: 'test1'),
            const FormInputWidget(name: 'test2', label: 'test2'),
            FormWatch(
                watch: const ['test1', 'test2'],
                builder: (state, formContext, context) {
                  return Row(
                      children: state.values.entries
                          .map<Text>((el) => Text('${el.key}: ${el.value} | '))
                          .toList());
                }),
            FormWatch(builder: (state, formContext, context) {
              final bool isLoading = state.formState.isSubmitting;
              final bool isDirty = state.formState.isDirty;
              final bool isValid = state.formState.isValid;
              final bool disabled = isLoading || (!isDirty && !isValid);

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
