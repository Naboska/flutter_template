part of '../form_widget.dart';

mixin FormMixin {
  TFormValidation? _validation;
  final TFormFields _fields = _FormSubject({});
  final FormErrorValuesSubjectType _errors = _FormSubject({});
  final FormStateValuesSubjectType _formState =
      _FormSubject(const FormStateValues());

  _FormSubject _register({required String name}) {
    TFormFieldSubject? field = _fields.state[name];

    if (isNil(field)) {
      field = _fields.state[name] = _FormSubject(null);

      if (!isNil(_validation)) {
        field.subscribe((_) => _triggerFieldValidate(name: name));
      }
    }

    return field!;
  }

  void _triggerFieldValidate({required String name}) {
    if (!isNil(_validation)) {
      final values = _getValues();
      final Map<String, String> errors = _validation!(values);
      final String? errorMessage = errors[name];

      if (errorMessage != _errors.state[name]) {
        if (isNil(errorMessage)) {
          _clearError(name: name);
        } else {
          _setError(name: name, message: errorMessage!);
        }
      }
    }
  }

  void _setValue(
      {required String name,
      required dynamic value,
      bool shouldValidate = false}) {
    final field = _register(name: name);

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

  Map<String, dynamic> _getValues() {
    return _fields.state.map((key, value) => MapEntry(key, value.state));
  }

  void _setError({required String name, required String message}) {
    _errors.state[name] = message;
    _errors.next(_errors.state);
  }

  void _clearError({required String name}) {
    _errors.state.remove(name);
    _errors.next(_errors.state);
  }
}
