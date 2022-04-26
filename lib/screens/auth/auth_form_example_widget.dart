import 'package:flutter/material.dart';

import 'package:flutter_template/widgets/shared/fields/form_input/form_input_widget.dart';
import 'package:flutter_template/widgets/shared/form/form.dart';

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
            const FormInputWidget(name: 'test3', label: 'test3dsfdsf'),
            const FormInputWidget(name: 'test3', label: 'test3'),
            FormWatch(
                watch: const [],
                builder: (state, formContext, context) {
                  final bool isLoading = state.formState.isSubmitting;
                  final bool isDirty = state.formState.isDirty;
                  final bool isValid = state.formState.isValid;
                  final bool disabled = isLoading || (isDirty && !isValid);

                  return Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                          onPressed: () {
                            formContext.setValue(name: 'test1', value: 'test');
                            formContext.setValue(
                                name: 'test3', value: 'test next');
                          },
                          style: ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.all(Colors.green)),
                          child: const Text('set valid')),
                      const SizedBox(width: 10),
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
                              : const Text('Submit')),
                    ],
                  );
                }),
            FormWatch(builder: (state, formContext, context) {
              final values = state.values.entries.toList();
              final errors = state.errors.entries.toList();
              final touched = state.touchedFields.entries.toList();
              final formState = {
                'isDirty': state.formState.isDirty,
                'isSubmitted': state.formState.isSubmitted,
                'isSubmitting': state.formState.isSubmitting,
                'isValid': state.formState.isValid,
              }.entries.toList();

              return Column(children: [
                _FormItems(values: formState, label: 'FormState'),
                _FormItems(values: values, label: 'Values'),
                _FormItems(values: touched, label: 'Touched fields'),
                _FormItems(values: errors, label: 'Errors')
              ]);
            }),
          ]);
        });
  }
}

class _FormItems extends StatelessWidget {
  final List<MapEntry<String, dynamic>> values;
  final String label;

  const _FormItems({Key? key, required this.values, required this.label})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: Align(
                alignment: Alignment.topLeft,
                child: Text(
                  label,
                  style: const TextStyle(fontSize: 30),
                )),
          ),
          ListView.separated(
            shrinkWrap: true,
            itemCount: values.length,
            itemBuilder: (BuildContext context, int index) {
              final item = values[index];
              return Row(children: [
                Text(item.key),
                const SizedBox(width: 10),
                Text(item.value.toString())
              ]);
            },
            separatorBuilder: (BuildContext context, int index) {
              return const Divider(
                color: Colors.black,
              );
            },
          ),
        ],
      ),
    );
  }
}
