part of 'form_widget.dart';

typedef TFormFieldsValues = Map<String, dynamic>;
typedef TFormFieldSubject<T> = _FormSubject<T>;
typedef TFormFieldsSubject<T> = _FormSubject<Map<String, TFormFieldSubject<T>>>;

typedef TFormErrorValues = Map<String, String>;
typedef TFormErrorSubject = _FormSubject<TFormErrorValues>;
typedef TFormValidation = TFormErrorValues Function(TFormFieldsValues values);

typedef TFormTouchedValues = Map<String, bool>;
typedef TFormTouchedSubject = _FormSubject<TFormTouchedValues>;

typedef FormStateValuesSubjectType = _FormSubject<FormStateValues>;

typedef FormFieldRegisterHandlerType = _FormSubject Function(
    {required String name});

typedef FormSetValueHandlerType = void Function(
    {required String name, required dynamic value});

typedef FormSetErrorHandlerType = void Function(
    {required String name, required String message});

typedef TFormGetValuesHandler = Map<String, dynamic> Function();

typedef TSubmitHandler = void Function();

typedef TFormWidgetBuilder = Widget Function(
    FormContext formContext, BuildContext buildContext);

typedef TFormSubmitHandler = Future<dynamic> Function(
    Map<String, dynamic> values);
