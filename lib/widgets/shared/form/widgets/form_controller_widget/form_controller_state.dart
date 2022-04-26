part of 'form_controller_widget.dart';

class FormController<T extends FormControllerWidget> extends State<T>
    with FormControllerStateMixin {
  final FormSubscribeController _subscriptionController =
      FormSubscribeController();

  @protected
  @override
  void initState() {
    super.initState();

    _form = FormWidget.of(context);
    _field = _form.register(name: widget.name);

    _fieldName = widget.name;
    _isTouched = false;

    _subscriptionController.subscribe(_form.formState, _formStateListener);
    _subscriptionController.subscribe(_form.errors, _errorListener);
    _subscriptionController.subscribe(_form.touchedFields, _touchedListener);
    _subscriptionController.subscribe(_field, _fieldValueListener);

    controllerDidInit(getField());
  }

  @protected
  @override
  void setState(VoidCallback fn) {
    super.setState(fn);

    controllerDidUpdate(getField());
  }

  @protected
  @override
  void dispose() {
    controllerWillDispose(getField());
    _subscriptionController.dispose();

    super.dispose();
  }

  void _formStateListener(FormStateValues value) {
    setState(() => _formState = value);
  }

  void _errorListener(TFormErrorValues errors) {
    final errorMessage = errors[_fieldName];

    if (errorMessage != _errorMessage) {
      setState(() => (_errorMessage = errorMessage));
    }
  }

  void _touchedListener(TFormTouchedValues touched) {
    final isTouched = touched[_fieldName] ?? false;

    if (isTouched != _isTouched) {
      setState(() => (_isTouched = isTouched));
    }
  }

  void _fieldValueListener(dynamic value) {
    setState(() => _value = value);
  }

  @protected
  controllerDidInit(FormControllerWidgetState field) {
    if (widget.onInit != null) widget.onInit!(field);
  }

  @protected
  controllerDidUpdate(FormControllerWidgetState field) {
    if (widget.onUpdate != null) widget.onUpdate!(field);
  }

  @protected
  controllerWillDispose(FormControllerWidgetState field) {
    if (widget.onDispose != null) widget.onDispose!(field);
  }

  @override
  Widget build(BuildContext context) {
    return widget.builder!(getField(), context);
  }
}
