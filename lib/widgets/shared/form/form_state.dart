part of 'form_widget.dart';

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
  List<Object?> get props => [isDirty, isSubmitting];

  FormStateValues copyWith(
      {bool? isDirty, bool? isSubmitting, bool? isSubmitted, bool? isValid}) {
    return FormStateValues(
        isDirty: isDirty ?? this.isDirty,
        isSubmitting: isSubmitting ?? this.isSubmitting,
        isSubmitted: isSubmitted ?? this.isSubmitted,
        isValid: isValid ?? this.isValid);
  }
}
