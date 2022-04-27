import 'package:flutter/material.dart';

import 'widgets/form_context/form_context.dart';
import 'utils/form_field_subject.dart';

typedef FormErrorValues = Map<String, String>;
typedef FormValues = Map<String, dynamic>;

typedef FormWidgetBuilder = Widget Function(
    FormContext formContext, BuildContext buildContext);

typedef FormValidationHandler = Future<FormErrorValues> Function(
    FormValues values);

typedef FormRegisterHandler = FormFieldSubject Function({required String name});

typedef FormSubmitHandler = Future<void> Function(FormValues values);

typedef FormGetValuesHandler = FormValues Function();

typedef FormSetValueHandler = void Function(
    {required String name, required dynamic value});

typedef FormSetErrorHandler = void Function(
    {required String name, String? message});
