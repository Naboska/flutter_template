import 'package:equatable/equatable.dart';

import 'form_subject.dart';

class FormFieldStateValues<T> extends Equatable {
  final T? value;
  final String? errorMessage;
  final bool isDirty;
  final bool isTouched;

  const FormFieldStateValues(
      {this.value,
      this.errorMessage,
      this.isDirty = false,
      this.isTouched = false});

  @override
  List<Object?> get props => [value, errorMessage, isTouched];

  FormFieldStateValues copyWith(
      {T? value, String? errorMessage, bool? isDirty, bool? isTouched}) {
    return FormFieldStateValues(
      value: value,
      errorMessage: errorMessage,
      isDirty: isDirty ?? this.isDirty,
      isTouched: isTouched ?? this.isTouched,
    );
  }
}

class FormFieldSubject<T> extends FormSubject<FormFieldStateValues<T>> {
  final T? initialValue;

  FormFieldSubject({this.initialValue})
      : super(FormFieldStateValues<T>(value: initialValue));

  void setValue(T? value) {
    if (state.value == value) return;

    next(state.copyWith(
        value: value, errorMessage: state.errorMessage, isDirty: true));
  }

  void handleTouched() {
    if (state.isTouched) return;

    next(state.copyWith(
        isTouched: true, value: state.value, errorMessage: state.errorMessage));
  }

  void setError(String? message) {
    if (state.errorMessage == message) return;

    next(state.copyWith(errorMessage: message, value: state.value));
  }

  void resetField() => reset(FormFieldStateValues<T>(value: initialValue));
}
