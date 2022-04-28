part of '../form_widget.dart';

mixin FormMixin {
  final FormFieldsSubject _fields = FormFieldsSubject();
  final FormStateSubject _formState = FormStateSubject();

  FormValidationHandler? _validation;
  FormValues? _initialValues;

  FormFieldSubject _register({required String name}) {
    FormFieldSubject? field = _fields.getField(name);

    if (field == null) {
      final initialValue = _initialValues?[name];
      field = _fields.createField(name: name, initialValue: initialValue);

      field.subscribe((newField, oldField) {
        if (field!.isDirty) {
          final bool isValueChanged = newField.value != oldField.value;
          final bool isTouched = newField.isTouched != oldField.isTouched;

          _formState.handleDirty();
          if (isValueChanged || isTouched) _triggerValidate(name: name);
        }
      });

      Future.microtask(_fields.notify);
    }

    return field;
  }

  Future<bool> _triggerValidate({String? name}) async {
    if (_validation == null) return true;

    final FormValues values = _getValues();
    final FormErrorValues errors = await _validation!(values);
    final bool isValid = name == null ? errors.isEmpty : errors[name] == null;

    if (name == null) {
      for (String fieldName in _fields.state.keys) {
        _setError(name: fieldName, message: errors[fieldName]);
      }
    } else {
      _setError(name: name, message: errors[name]);
    }

    _formState.setValid(isValid);

    return isValid;
  }

  FormValues _getValues() {
    final fields = _fields.state;

    return fields.map((name, field) => MapEntry(name, field.state.value));
  }

  void _setValue({required String name, required dynamic value}) {
    final field = _register(name: name);

    field.setValue(value);
  }

  void _setError({required String name, String? message}) {
    final field = _register(name: name);

    field.setError(message);
  }

  void _reset() {
    _fields.getFields().forEach((_, field) => field.resetField());
    _formState.resetForm();
  }
}
