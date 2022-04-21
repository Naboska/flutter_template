import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

part 'utils/form_subject.dart';
part 'form_state.dart';
part 'form_context.dart';
part 'types.dart';

class FormWidget extends StatefulWidget {
  final Widget child;
  final FormFields _fields = {};
  final FormErrorValues _errors = _FormSubject({});
  final FormStateValues _formState = _FormSubject(const _FormStateValues());

  FormWidget({Key? key, required this.child}) : super(key: key);

  void _setValue(
      {required String name,
      required dynamic value,
      bool shouldValidate = false}) {
    final _FormSubject field = _fields[name] ??= _FormSubject(null);

    if (_formState.state.isDirty) {
      _formState.next(_formState.state.copyWith(isDirty: true));
    }

    if (shouldValidate) {
      if (_errors.state.containsKey(name)) {
        _errors.state.remove(name);
        _errors.next(_errors.state);
      }
    }

    field.next(value);
  }

  void _setError({required String name, required String message}) {
    _errors.state[name] = message;
    _errors.next(_errors.state);
  }

  static FormProvider of(BuildContext context) {
    final ctx = context.getElementForInheritedWidgetOfExactType<FormProvider>();
    return ctx?.widget as FormProvider;
  }

  @override
  State<FormWidget> createState() => _FormState();
}
