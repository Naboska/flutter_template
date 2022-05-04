part of '../../form_widget.dart';

class FormContext {
  final TFormFieldsSubject fields;
  final TFormErrorSubject errors;
  final TFormTouchedSubject touchedFields;
  final FormStateValuesSubjectType formState;
  final FormFieldRegisterHandlerType register;
  final TSubmitHandler handleSubmit;
  final TFormGetValuesHandler getValues;
  final FormSetValueHandlerType setValue;
  final FormSetErrorHandlerType setError;

  const FormContext(
      {required this.fields,
      required this.errors,
      required this.touchedFields,
      required this.formState,
      required this.register,
      required this.handleSubmit,
      required this.getValues,
      required this.setError,
      required this.setValue});
}
