part of 'form_widget.dart';

class FormStateValues extends Equatable {
  const FormStateValues(
      {this.isDirty = false,
      this.isSubmitting = false,
      this.isSubmitted = false});

  final bool isDirty;
  final bool isSubmitting;
  final bool isSubmitted;

  @override
  List<Object?> get props => [isDirty, isSubmitting];

  FormStateValues copyWith(
      {bool? isDirty, bool? isSubmitting, bool? isSubmitted}) {
    return FormStateValues(
        isDirty: isDirty ?? this.isDirty,
        isSubmitting: isSubmitting ?? this.isSubmitting,
        isSubmitted: isSubmitted ?? this.isSubmitted);
  }
}
