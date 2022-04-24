part of 'form_widget.dart';

class _FormWidgetState extends State<FormWidget> with FormMixin {
  @override
  void dispose() {
    _fields.forEach((_, subject) => subject.close());
    _formState.close();
    _errors.close();

    super.dispose();
  }

  void _handleSubmit() async {
    final Map<String, dynamic> values = _getValues();
    // validate
    const bool isValid = true;
    // if valid
    _formState.next(_formState.state.copyWith(isSubmitting: true));
    if (!isNil(widget.onSubmit) && isValid) await widget.onSubmit!(values);
    _formState.next(_formState.state.copyWith(isSubmitting: false, isSubmitted: true));
  }

  @override
  Widget build(BuildContext context) {
    final FormContext _formContext = FormContext(
      fields: _fields,
      errors: _errors,
      formState: _formState,
      register: _register,
      handleSubmit: _handleSubmit,
      getValues: _getValues,
      setValue: _setValue,
      setError: _setError,
    );

    return FormProvider(
      child: widget.builder(_formContext, context),
      context: _formContext,
    );
  }
}