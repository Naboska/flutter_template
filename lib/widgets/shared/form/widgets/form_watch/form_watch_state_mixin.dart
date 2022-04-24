part of 'form_watch_widget.dart';

class FormWatchState {
  final Map<String, dynamic> values;
  final Map<String, dynamic> errors;
  final FormStateValues formState;

  FormWatchState({required this.values, required this.formState, required this.errors});
}

mixin FormWatchStateMixin {
  final Map<String, dynamic> _values = {};
  final Map<String, dynamic> _errors = {};
  late FormStateValues _formState;

  FormWatchState _getWatchState() {
    return FormWatchState(
      values: _values,
      errors: _errors,
      formState: _formState,
    );
  }
}