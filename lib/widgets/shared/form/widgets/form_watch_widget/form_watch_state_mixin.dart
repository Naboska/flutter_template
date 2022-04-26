part of 'form_watch_widget.dart';

class FormWatchState {
  final Map<String, dynamic> values;
  final TFormErrorValues errors;
  final TFormTouchedValues touchedFields;
  final FormStateValues formState;

  FormWatchState(
      {required this.values,
      required this.formState,
      required this.errors,
      required this.touchedFields});
}

mixin FormWatchStateMixin {
  late final FormContext _form;
  final Map<String, dynamic> _values = {};
  final TFormErrorValues _errors = {};
  final TFormTouchedValues _touchedFields = {};
  late FormStateValues _formState;

  FormWatchState _getWatchState() {
    return FormWatchState(
      values: _values,
      errors: _errors,
      touchedFields: _touchedFields,
      formState: _formState,
    );
  }
}
