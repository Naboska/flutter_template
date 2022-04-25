part of 'form_controller_widget.dart';

class _FormFieldState extends State<FormController> with FormControllerStateMixin {
  final FormSubscribeController _subscriptionController = FormSubscribeController();

  @override
  void initState() {
    super.initState();

    final FormContext _form = FormWidget.of(context);

    _field = _form.register(name: widget.name);

    _subscriptionController.subscribe(_form.formState, _formStateListener);
    _subscriptionController.subscribe(_form.errors, _fieldErrorListener);
    _subscriptionController.subscribe(_field, _fieldValueListener);

    _lifeCycleRun(widget.onInit);
  }

  @override
  void setState(VoidCallback cb) {
    super.setState(cb);

    _lifeCycleRun(widget.onUpdate);
  }

  @override
  void dispose() {
    _lifeCycleRun(widget.onDispose);
    _subscriptionController.dispose();

    super.dispose();
  }

  void _lifeCycleRun(TFormControllerLifeCycleFn? lifeCycle) {
    if (!isNil(lifeCycle)) lifeCycle!(_getControllerState());
  }

  void _formStateListener(FormStateValues value) {
    setState(() => _formState = value);
  }

  void _fieldErrorListener(Map<String, String> errors) {
    final errorMessage = errors[widget.name];

    if (errorMessage != _errorMessage) {
      setState(() => (_errorMessage = errorMessage));
    }
  }

  void _fieldValueListener(dynamic value) {
    setState(() => _fieldValue = value);
  }

  @override
  Widget build(BuildContext context) {
    return widget.builder(_getControllerState(), context);
  }
}
