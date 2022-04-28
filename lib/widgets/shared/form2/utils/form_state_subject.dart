import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'form_subject.dart';

class FormStateValues extends Equatable {
  const FormStateValues(
      {this.isDirty = false,
      this.isSubmitting = false,
      this.isSubmitted = false,
      this.isValid = true});

  final bool isDirty;
  final bool isSubmitting;
  final bool isSubmitted;
  final bool isValid;

  @override
  List<Object?> get props => [isDirty, isSubmitting, isSubmitted, isValid];

  FormStateValues copyWith(
      {bool? isDirty, bool? isSubmitting, bool? isSubmitted, bool? isValid}) {
    return FormStateValues(
        isDirty: isDirty ?? this.isDirty,
        isSubmitting: isSubmitting ?? this.isSubmitting,
        isSubmitted: isSubmitted ?? this.isSubmitted,
        isValid: isValid ?? this.isValid);
  }
}

class FormStateSubject extends FormSubject<FormStateValues> {
  FormStateSubject() : super(const FormStateValues());

  void handleDirty() {
    if (state.isDirty) return;

    next(state.copyWith(isDirty: true));
  }

  VoidCallback handleSubmitting() {
    next(state.copyWith(isDirty: true, isSubmitting: true));

    return () => next(state.copyWith(isSubmitted: true, isSubmitting: false));
  }

  void setValid(bool isValid) {
    if (state.isValid == isValid) return;

    next(state.copyWith(isValid: isValid));
  }

  void resetForm() {
    reset(const FormStateValues());
  }
}
