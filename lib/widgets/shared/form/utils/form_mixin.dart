part of '../form_widget.dart';

mixin FormMixin {
  final TFormFields _fields = {};
  final FormErrorValuesSubjectType _errors = _FormSubject({});
  final FormStateValuesSubjectType _formState = _FormSubject(const FormStateValues());

  _FormSubject _register({required String name}) {
    return _fields[name] ??= _FormSubject(null);
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
    return _fields.map((key, value) => MapEntry(key, value.state));
  }

  void _setError({required String name, required String message}) {
    _errors.state[name] = message;
    _errors.next(_errors.state);
  }
}