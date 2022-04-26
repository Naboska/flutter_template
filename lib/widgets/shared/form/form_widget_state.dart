part of 'form_widget.dart';

class _FormWidgetState extends State<FormWidget> with FormMixin {
  @override
  void initState() {
    super.initState();
    _validation = widget.validation;
  }

  @override
  void dispose() {
    _fields.state.forEach((_, subject) => subject.close());
    _formState.close();
    _errors.close();

    super.dispose();
  }

  void _handleSubmit() async {
    final Map<String, dynamic> values = _getValues();
    final Map<String, String> validate =
        !isNil(widget.validation) ? widget.validation!(values) : {};
    final bool isValid = validate.isEmpty;

    if (isValid) {
      _formState.next(_formState.state
          .copyWith(isDirty: true, isValid: true, isSubmitting: true));

      if (!isNil(widget.onSubmit) && isValid) await widget.onSubmit!(values);

      _formState.next(
          _formState.state.copyWith(isSubmitting: false, isSubmitted: true));
    } else {
      _errors.next(validate);
      _formState.next(_formState.state
          .copyWith(isDirty: true, isSubmitted: true, isValid: false));
    }
  }

  @override
  Widget build(BuildContext context) {
    final FormContext _formContext = FormContext(
      fields: _fields,
      errors: _errors,
      touchedFields: _touchedFields,
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
