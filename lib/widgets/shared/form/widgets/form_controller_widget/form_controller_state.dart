part of 'form_controller_widget.dart';

class _FormFieldState extends State<FormController> with FormControllerStateMixin {
  final List<Subscription> _subscriptions = [];

  @override
  void initState() {
    super.initState();

    final FormContext _form = FormWidget.of(context);

    _field = _form.register(name: widget.name);

    _subscriptions.add(_form.formState.subscribe(_formStateListener));
    _subscriptions.add(_form.errors.subscribe(_fieldErrorListener));
    _subscriptions.add(_field.subscribe(_fieldValueListener));

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

    for (Subscription unsubscribe in _subscriptions) {
      unsubscribe();
    }

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
