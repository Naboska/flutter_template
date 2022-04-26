part of 'form_controller_widget.dart';

class FormControllerWidgetState {
  final FormStateValues formState;
  final void Function(dynamic value) setValue;
  final void Function() handleBlur;
  final dynamic value;
  final String? errorMessage;
  final bool isTouched;

  FormControllerWidgetState(
      {required this.setValue,
      required this.handleBlur,
      required this.formState,
      required this.value,
      required this.isTouched,
      required this.errorMessage});
}

mixin FormControllerStateMixin {
  late final FormContext _form;
  late final TFormFieldSubject _field;
  late final String _fieldName;

  late FormStateValues _formState;
  late bool _isTouched;
  dynamic _value;
  String? _errorMessage;

  _setValue(dynamic value) => _field.next(value);

  _handleBlur() {
    final bool isTouched = _form.touchedFields.state[_fieldName] == true;

    if (!isTouched) {
      _form.touchedFields.state[_fieldName] = true;
      _form.touchedFields.next(_form.touchedFields.state);
    }
  }

  FormControllerWidgetState getField() {
    return FormControllerWidgetState(
      formState: _formState,
      handleBlur: _handleBlur,
      setValue: _setValue,
      errorMessage: _errorMessage,
      isTouched: _isTouched,
      value: _value,
    );
  }
}
