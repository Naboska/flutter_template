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
  late final String fieldName;

  late FormStateValues formState;
  late bool isTouched;
  dynamic value;
  String? errorMessage;

  void setValue(dynamic value) => _field.next(value);

  void handleBlur() {
    final bool isTouched = _form.touchedFields.state[fieldName] == true;

    if (!isTouched) {
      _form.touchedFields.state[fieldName] = true;
      _form.touchedFields.next(_form.touchedFields.state);
    }
  }

  FormControllerWidgetState getField() {
    return FormControllerWidgetState(
      formState: formState,
      handleBlur: handleBlur,
      setValue: setValue,
      errorMessage: errorMessage,
      isTouched: isTouched,
      value: value,
    );
  }
}
