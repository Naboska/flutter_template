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

    fieldName = widget.name;
    isTouched = false;

    _subscriptionController.subscribe(_form.formState, _formStateListener);
    _subscriptionController.subscribe(_form.errors, _errorListener);
    _subscriptionController.subscribe(_form.touchedFields, _touchedListener);
    _subscriptionController.subscribe(_field, _fieldValueListener);

    controllerDidInit();
  }

  @protected
  @override
  void setState(VoidCallback fn) {
    super.setState(fn);

    controllerDidUpdate();
  }

  @protected
  @override
  void dispose() {
    controllerWillDispose();

    _subscriptionController.dispose();

    super.dispose();
  }

  void _formStateListener(FormStateValues formStateValues) {
    setState(() => formState = formStateValues);
  }

  void _errorListener(TFormErrorValues errors) {
    final message = errors[fieldName];

    if (errorMessage != message) {
      setState(() => (errorMessage = message));
    }
  }

  void _touchedListener(TFormTouchedValues touched) {
    final isCurrentTouched = touched[fieldName] ?? false;

    if (isTouched != isCurrentTouched) {
      setState(() => (isTouched = isCurrentTouched));
    }
  }

  void _fieldValueListener(dynamic fieldValue) {
    setState(() => value = fieldValue);
  }

  @protected
  void controllerDidInit() {
    if (widget.onInit != null) widget.onInit!(getField());
  }

  @protected
  void controllerDidUpdate() {
    if (widget.onUpdate != null) widget.onUpdate!(getField());
  }

  @protected
  void controllerWillDispose() {
    if (widget.onDispose != null) widget.onDispose!(getField());
  }

  @override
  Widget build(BuildContext context) {
    return widget.builder!(getField(), context);
  }
}
