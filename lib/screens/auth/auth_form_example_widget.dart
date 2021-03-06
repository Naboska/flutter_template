import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:flutter_template/widgets/shared/fields/form_input_2/form_input_widget.dart';
import 'package:flutter_template/widgets/shared/form2/form.dart';

class AuthFormExample extends StatelessWidget {
  const AuthFormExample({Key? key}) : super(key: key);

  Future<FormErrorValues> _validation(Map<String, dynamic> values) async {
    final next = <String, String>{};

    if (values['test2'] != values['test4']) {
      next['test4'] = 'test2 and test4 not equals';
    }

    if ([null, ''].contains(values['test1'])) next['test1'] = 'required1';
    if ([null, ''].contains(values['test2'])) next['test2'] = 'required2';
    if ([null, ''].contains(values['test3'])) next['test3'] = 'required3';
    if ([null, ''].contains(values['test4'])) next['test4'] = 'required4';

    return next;
  }

  Future<void> _onFormSubmit(FormValues values) async {
    await Future.delayed(const Duration(seconds: 4));
    print(values);
  }

  @override
  Widget build(BuildContext context) {
    return FormWidget(
        initialValues: const {'test1': '123123', 'test6': Test()},
        validation: _validation,
        onSubmit: _onFormSubmit,
        builder: (formContext, buildContext) {
          return Column(children: [
            const FormDevtoolsWidget(),
            const FormInputWidget(name: 'test1', label: 'test1'),
            const FormInputWidget(name: 'test2', label: 'test2'),
            const FormInputWidget(name: 'test3', label: 'test3'),
            const FormInputWidget(name: 'test4', label: 'test4'),
            FormControllerWidget(
                name: 'test6',
                builder: (controller, context) {
                  final Test? value = controller.fieldState.value;

                  return TextFormField(
                      decoration: const InputDecoration(label: Text('test6')),
                      initialValue: value?.count.toString() ?? '',
                      keyboardType: TextInputType.number,
                      inputFormatters: <TextInputFormatter>[
                        FilteringTextInputFormatter.digitsOnly
                      ],
                      onChanged: (value) {
                        controller.field
                            .setValue(Test(count: int.parse(value)));
                        controller.field.handleTouched();
                      });
                }),
            const SizedBox(height: 12),
            FormWatch(
                watch: const [],
                builder: (state, formContext, context) {
                  final bool isLoading = state.formState.isSubmitting;
                  final bool isSubmitted = state.formState.isSubmitted;
                  final bool isDirty = state.formState.isDirty;
                  final bool isValid = state.formState.isValid;
                  final bool disabled = isLoading || (isSubmitted && !isValid);

                  return Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ElevatedButton(
                            onPressed: isDirty ? formContext.reset : null,
                            child: const Text('Reset')),
                        const SizedBox(width: 6),
                        ElevatedButton(
                            onPressed:
                                !disabled ? formContext.handleSubmit : null,
                            child: isLoading
                                ? const SizedBox(
                                    width: 12,
                                    height: 12,
                                    child: CircularProgressIndicator(
                                      strokeWidth: 2,
                                    ))
                                : const Text('Submit'))
                      ]);
                }),
          ]);
        });
  }
}

class Test extends Equatable {
  final int count;

  const Test({this.count = 1});

  @override
  List<Object?> get props => [count];
}
