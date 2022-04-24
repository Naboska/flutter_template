part of 'form_controller_widget.dart';

class _FormFieldState extends State<FormController> with FormControllerStateMixin {
  final List<Subscription> _subscriptions = [];

  @override
  void initState() {
    super.initState();

    _form = FormWidget.of(context);
    _field = _form.register(name: widget.name);

    _subscriptions.add(_form.formState.subscribe(_formStateObserver));
    _subscriptions.add(_form.errors.subscribe(_fieldErrorObserver));
    _subscriptions.add(_field.subscribe(_fieldValueObserver));

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

  _lifeCycleRun(TLifeCycleFn? lifeCycle) {
    if (!isNil(lifeCycle)) lifeCycle!(_getControllerState());
  }

  _formStateObserver(FormStateValues value) {
    setState(() => _formState = value);
  }

  _fieldErrorObserver(Map<String, String> errors) {
    final errorMessage = errors[widget.name];

    if (errorMessage != _errorMessage) {
      setState(() => (_errorMessage = errorMessage));
    }
  }

  _fieldValueObserver(dynamic value) {
    setState(() => _fieldValue = value);
  }

  @override
  Widget build(BuildContext context) {
    return widget.builder(_getControllerState(), context);
  }
}
