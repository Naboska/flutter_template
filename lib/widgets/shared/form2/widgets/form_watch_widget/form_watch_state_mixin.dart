part of 'form_watch_widget.dart';

class FormWatchState {
  final Map<String, FormFieldStateValues> fields;
  final FormStateValues formState;

  FormWatchState({required this.fields, required this.formState});
}

mixin FormWatchStateMixin {
  late final FormContext _form;
  final Map<String, FormFieldStateValues> _fields = {};
  late FormStateValues _formState;

  FormWatchState _getWatchState() {
    return FormWatchState(formState: _formState, fields: _fields);
  }
}
