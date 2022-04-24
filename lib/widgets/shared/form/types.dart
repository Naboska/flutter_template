part of 'form_widget.dart';

typedef TFormFieldSubject = _FormSubject<dynamic>;
typedef TFormFields = Map<String, TFormFieldSubject>;

typedef FormErrorValuesType = Map<String, String>;
typedef FormErrorValuesSubjectType = _FormSubject<FormErrorValuesType>;

typedef FormStateValuesSubjectType = _FormSubject<FormStateValues>;

typedef FormFieldRegisterHandlerType = _FormSubject Function({required String name});

typedef FormSetValueHandlerType = void Function(
    {required String name, required dynamic value, bool shouldValidate});

typedef FormSetErrorHandlerType = void Function(
    {required String name, required String message});

typedef TFormGetValuesHandler = Map<String, dynamic> Function();

typedef TSubmitHandler = void Function();