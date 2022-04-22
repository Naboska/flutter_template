part of 'form_widget.dart';

typedef FormFieldSubject = _FormSubject;
typedef FormFields = Map<String, FormFieldSubject>;

typedef FormErrorValues = _FormSubject<Map<String, String>>;

typedef FormStateValues = _FormStateValues;
typedef FormStateValuesSubject = _FormSubject<FormStateValues>;

typedef FormFieldRegisterHandler = _FormSubject Function({required String name});

typedef FormSetValueHandler = void Function(
    {required String name, required dynamic value, bool shouldValidate});

typedef FormSetErrorHandler = void Function(
    {required String name, required String message});
