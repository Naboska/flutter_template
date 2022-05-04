part of 'form_widget.dart';

class _FormWidgetState extends State<FormWidget> with FormMixin {
  late final FormContext _formContext;

  @override
  void initState() {
    super.initState();
    _validation = widget.validation;
    _initialValues = widget.initialValues;

    _formContext = FormContext(
      fields: _fields,
      formState: _formState,
      register: _register,
      reset: _reset,
      handleSubmit: _handleSubmit,
      getValues: _getValues,
      setValue: _setValue,
      setError: _setError,
    );
  }

  @override
  void dispose() {
    _fields.state.forEach((_, subject) => subject.close());
    _fields.close();
    _formState.close();

    super.dispose();
  }

  Future<void> _handleSubmit() async {
    final Map<String, dynamic> values = _getValues();
    final VoidCallback handleStopSubmitting = _formState.handleSubmitting();
    final bool isValid = await _triggerValidate();

    if (isValid && widget.onSubmit != null) await widget.onSubmit!(values);

    handleStopSubmitting();
  }

  @override
  Widget build(BuildContext context) {
    return FormProvider(
      child: widget.builder(_formContext, context),
      context: _formContext,
    );
  }
}
