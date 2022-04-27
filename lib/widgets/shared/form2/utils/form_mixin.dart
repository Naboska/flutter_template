part of '../form_widget.dart';

mixin FormMixin {
  final FormFieldsSubject _fields = FormFieldsSubject();
  final FormStateSubject _formState = FormStateSubject();

  FormValidationHandler? _validation;

  FormFieldSubject _register({required String name}) {
    FormFieldSubject? field = _fields.getField(name);

    if (field == null) {
      field = _fields.createField(name: name);

      field.subscribe((fieldState, oldFieldState) {
        if (field!.isDirty) _afterFieldUpdate(fieldState, oldFieldState);
      });

      Future.microtask(_fields.notifyForm);
    }

    return field;
  }

  void _afterFieldUpdate(FormFieldStateValues state, FormFieldStateValues old) {
    _formState.handleDirty();

    if ((state.value != old.value) || (state.isTouched != old.isTouched)) {
      _triggerValidate();
    }
  }

  Future<bool> _triggerValidate() async {
    if (_validation == null) return true;

    final FormValues values = _getValues();
    final FormErrorValues errors = await _validation!(values);
    final bool isValid = errors.isEmpty;

    _formState.setValid(isValid);

    for (String fieldName in _fields.state.keys) {
      final String? error = errors[fieldName];
      _setError(name: fieldName, message: error);
    }

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
}
