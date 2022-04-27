part of 'form_context.dart';

class FormProvider extends InheritedWidget {
  final FormContext context;

  const FormProvider({Key? key, required Widget child, required this.context})
      : super(key: key, child: child);

  @override
  bool updateShouldNotify(FormProvider oldWidget) => false;
}
