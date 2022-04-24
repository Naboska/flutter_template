part of 'form_watch_widget.dart';

class _FormWatchState extends State<FormWatch> with FormWatchStateMixin {
  final List<Subscription> _subscriptions = [];

  @override
  void initState() {
    super.initState();

    final FormContext _form = FormWidget.of(context);

    _subscriptions.add(_form.formState.subscribe(_formStateListener));
    _subscriptions.add(_form.errors.subscribe(_formErrorsListener));

    if (!isNil(widget.watch) && widget.watch!.isNotEmpty) {
      for (String fieldName in widget.watch!) {
        final formField = _form.register(name: fieldName);
        void listener(value) => _fieldListener(fieldName, value);

        _subscriptions.add(formField.subscribe(listener));

        if (!_values.keys.contains(fieldName)) {
          setState(() { _values[fieldName] = null; });
        }
      }
    }
  }

  @override
  void dispose() {
    for (Subscription unsubscribe in _subscriptions) {
      unsubscribe();
    }

    super.dispose();
  }

  void _fieldListener(String fieldName, dynamic value) {
    setState(() => _values[fieldName] = value);
  }

  void _formStateListener(FormStateValues value) {
    setState(() => _formState = value);
  }

  void _formErrorsListener(Map<String, String> errors) {
    setState(() =>
    _errors
      ..clear()
      ..addAll(errors));
  }

  @override
  Widget build(BuildContext context) {
    final FormWatchState watchState = _getWatchState();
    final FormContext formContext = FormWidget.of(context);

    return widget.builder(watchState, formContext, context);
  }
}
