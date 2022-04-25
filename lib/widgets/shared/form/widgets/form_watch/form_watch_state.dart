part of 'form_watch_widget.dart';

class _FormWatchState extends State<FormWatch> with FormWatchStateMixin {
  final FormSubscribeController _subscriptionController =
      FormSubscribeController();

  @override
  void initState() {
    super.initState();

    final FormContext _form = FormWidget.of(context);

    _subscriptionController.subscribe(_form.formState, _formStateListener);
    _subscriptionController.subscribe(_form.errors, _formErrorsListener);
    _subscriptionController.subscribe(_form.fields, _fieldsListener);
  }

  @override
  void dispose() {
    _subscriptionController.dispose();

    super.dispose();
  }

  void _fieldsListener(Map<String, TFormFieldSubject> fields) {
    final isControlled = widget.watch != null;

    if (isControlled && widget.watch!.isEmpty) return;

    for (String key in fields.keys) {
      if (isControlled && !widget.watch!.contains(key)) continue;

      final TFormFieldSubject subject = fields[key]!;

      if (_subscriptionController.listeners.containsKey(subject.hashCode)) {
        continue;
      }

      _subscriptionController.subscribe(
          subject, (value) => _updateField(key, value));

      if (!_values.containsKey(key)) _updateField(key, null);
    }
  }

  void _updateField(String name, dynamic value) {
    setState(() => _values[name] = value);
  }

  void _formStateListener(FormStateValues value) {
    setState(() => _formState = value);
  }

  void _formErrorsListener(Map<String, String> errors) {
    setState(() => _errors
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