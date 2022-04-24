part of 'form_widget.dart';

typedef FormFieldSubjectType = _FormSubject;
typedef FormFieldsType = Map<String, FormFieldSubjectType>;

typedef FormErrorValuesType = Map<String, String>;
typedef FormErrorValuesSubjectType = _FormSubject<FormErrorValuesType>;

typedef FormStateValuesType = _FormStateValues;
typedef FormStateValuesSubjectType = _FormSubject<FormStateValuesType>;

typedef FormFieldRegisterHandlerType = _FormSubject Function({required String name});

typedef FormSetValueHandlerType = void Function(
    {required String name, required dynamic value, bool shouldValidate});

typedef FormSetErrorHandlerType = void Function(
    {required String name, required String message});
