part of 'form_widget.dart';

class FormProvider extends InheritedWidget {
  final FormFields fields;
  final FormErrorValues errors;
  final FormStateValues formState;
  final FormSetValueHandler setValue;
  final FormSetErrorHandler setError;

  const FormProvider(
      {Key? key,
      required Widget child,
      required this.fields,
      required this.errors,
      required this.formState,
      required this.setError,
      required this.setValue})
      : super(key: key, child: child);

  @override
  bool updateShouldNotify(FormProvider oldWidget) => false;
}
