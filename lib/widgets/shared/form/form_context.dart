part of 'form_widget.dart';

class FormProvider extends InheritedWidget {
  final FormFieldsType fields;
  final FormErrorValuesSubjectType errors;
  final FormStateValuesSubjectType formState;
  final FormSetValueHandlerType setValue;
  final FormSetErrorHandlerType setError;
  final FormFieldRegisterHandlerType register;

  const FormProvider(
      {Key? key,
      required Widget child,
      required this.fields,
      required this.errors,
      required this.formState,
      required this.register,
      required this.setError,
      required this.setValue})
      : super(key: key, child: child);

  @override
  bool updateShouldNotify(FormProvider oldWidget) => false;
}

