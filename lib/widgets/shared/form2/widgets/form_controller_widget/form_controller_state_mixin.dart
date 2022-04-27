part of 'form_controller_widget.dart';

class FormController {
  final FormFieldStateValues fieldState;
  final FormStateValues formState;
  final FormFieldSubject field;

  FormController(
      {required this.fieldState, required this.formState, required this.field});
}

mixin FormControllerStateMixin {
  late final FormContext _form;
  late final FormFieldSubject field;
  late final String fieldName;
  late FormFieldStateValues fieldState;
  late FormStateValues formState;

  FormController getController() {
    return FormController(
        fieldState: fieldState, formState: formState, field: field);
  }
}
