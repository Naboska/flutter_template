part of 'form_widget.dart';

typedef FormFields = Map<String, _FormSubject>;

typedef FormErrorValues = _FormSubject<Map<String, String>>;

typedef FormStateValues = _FormSubject<_FormStateValues>;

typedef FormSetValueHandler = void Function(
    {required String name, required dynamic value, bool shouldValidate});

typedef FormSetErrorHandler = void Function(
    {required String name, required String message});
