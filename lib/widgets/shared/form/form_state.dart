part of 'form_widget.dart';

class _FormState extends State<FormWidget> {
  @override
  void dispose() {
    widget._fields.forEach((_, subject) => subject.close());
    widget._formState.close();
    widget._errors.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FormProvider(
      child: Column(children: widget.children),
      fields: widget._fields,
      errors: widget._errors,
      formState: widget._formState,
      register: widget._register,
      setValue: widget._setValue,
      setError: widget._setError,
    );
  }
}

class _FormStateValues extends Equatable {
  const _FormStateValues({this.isDirty = false, this.isSubmitting = false});

  final bool isDirty;
  final bool isSubmitting;

  @override
  List<Object?> get props => [isDirty, isSubmitting];

  _FormStateValues copyWith({bool? isDirty, bool? isSubmitting}) {
    return _FormStateValues(
        isDirty: isDirty ?? this.isDirty,
        isSubmitting: isSubmitting ?? this.isSubmitting);
  }
}
