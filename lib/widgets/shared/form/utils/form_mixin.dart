part of '../form_widget.dart';

mixin FormMixin {
  final TFormFieldsSubject _fields = _FormSubject({});
  final TFormErrorSubject _errors = _FormSubject({});
  final FormStateValuesSubjectType _formState =
      _FormSubject(const FormStateValues());
  TFormValidation? _validation;

  _FormSubject _register({required String name}) {
    TFormFieldSubject? field = _fields.state[name];

    if (field == null) {
      field = _fields.state[name] = _FormSubject(null);

      field.subscribe((_) {
        if (!_formState.state.isDirty) {
          _formState.next(_formState.state.copyWith(isDirty: true));
        }

        if (_validation != null) _triggerFieldValidate(name: name);
      });

      Future.microtask(() => _fields.next(_fields.state));
    }

    return field;
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

  void _setValue({required String name, required dynamic value}) {
    final field = _register(name: name);
    field.next(value);
  }

  Map<String, dynamic> _getValues() {
    return _fields.state.map((key, value) => MapEntry(key, value.state));
  }

  void _setError({required String name, required String message}) {
    _errors.state[name] = message;

    if (_formState.state.isValid) {
      _formState.next(_formState.state.copyWith(isValid: false));
    }

    _errors.next(_errors.state);
  }

  void _clearError({required String name}) {
    _errors.state.remove(name);

    if (_errors.state.isEmpty && !_formState.state.isValid) {
      _formState.next(_formState.state.copyWith(isValid: true));
    }

    _errors.next(_errors.state);
  }
}
