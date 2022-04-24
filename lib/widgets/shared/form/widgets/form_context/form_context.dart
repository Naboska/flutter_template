part of '../../form_widget.dart';

class FormContext {
  final TFormFields fields;
  final FormErrorValuesSubjectType errors;
  final FormStateValuesSubjectType formState;
  final FormFieldRegisterHandlerType register;
  final TSubmitHandler handleSubmit;
  final TFormGetValuesHandler getValues;
  final FormSetValueHandlerType setValue;
  final FormSetErrorHandlerType setError;

  const FormContext(
      {required this.fields,
      required this.errors,
      required this.formState,
      required this.register,
      required this.handleSubmit,
      required this.getValues,
      required this.setError,
      required this.setValue});
}
