import 'package:flutter/material.dart';

import '../../utils/form_fields_subject.dart';
import '../../utils/form_state_subject.dart';
import '../../types.dart';

part 'form_provider.dart';

class FormContext {
  final FormFieldsSubject fields;
  final FormStateSubject formState;
  final FormRegisterHandler register;
  final VoidCallback handleSubmit;
  final FormGetValuesHandler getValues;
  final FormSetValueHandler setValue;
  final FormSetErrorHandler setError;

  const FormContext(
      {required this.fields,
      required this.formState,
      required this.register,
      required this.handleSubmit,
      required this.getValues,
      required this.setError,
      required this.setValue});
}
