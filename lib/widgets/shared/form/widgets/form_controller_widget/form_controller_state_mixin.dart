part of 'form_controller_widget.dart';

class FormControllerState {
  final FormStateValues formState;
  final void Function(dynamic value) setValue;
  final dynamic value;
  final String? errorMessage;

  FormControllerState(
      {required this.setValue,
        required this.formState,
        required this.value,
        required this.errorMessage});
}

mixin FormControllerStateMixin {
  late final FormContext _form;
  late final TFormFieldSubject _field;

  late FormStateValues _formState;
  dynamic _fieldValue;
  String? _errorMessage;

  _setValue(dynamic value) => _field.next(value);

  FormControllerState _getControllerState() {
    return FormControllerState(
      formState: _formState,
      setValue: _setValue,
      errorMessage: _errorMessage,
      value: _fieldValue,
    );
  }
}