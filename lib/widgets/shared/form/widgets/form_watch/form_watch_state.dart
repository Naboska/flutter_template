part of 'form_watch_widget.dart';

class _FormWatchState extends State<FormWatch> with FormWatchStateMixin {
  late final bool isControlled;

  final FormSubscribeController _subscriptionController =
      FormSubscribeController();

  @override
  void initState() {
    super.initState();

    final FormContext _form = FormWidget.of(context);

    isControlled = widget.watch != null;

    _subscriptionController.subscribe(_form.formState, _formStateListener);

    if (!isControlled || widget.watch!.isNotEmpty) {
      _subscriptionController.subscribe(_form.errors, _formErrorsListener);
      _subscriptionController.subscribe(_form.fields, _fieldsListener);
    }
  }

  @override
  void dispose() {
    _subscriptionController.dispose();

    super.dispose();
  }

  void _fieldsListener(Map<String, TFormFieldSubject> fields) {
    for (MapEntry<String, TFormFieldSubject> e in fields.entries) {
      if (isControlled && !widget.watch!.contains(e.key)) continue;
      if (_subscriptionController.isSubscribe(e.value)) continue;
      _subscriptionController.subscribe(e.value, (v) => _updateField(e.key, v));
      if (!_values.containsKey(e.key)) _updateField(e.key, null);
    }
  }

  void _formStateListener(FormStateValues value) {
    setState(() => _formState = value);
  }

  void _formErrorsListener(TFormErrorValues errors) {
    final TFormErrorValues next = errors;

    if (isControlled) {
      next.removeWhere((key, value) {
        return !widget.watch!.contains(key) && _errors[key] == errors[key];
      });
    }

    if (!mapEquals(errors, _errors)) {
      setState(() => _errors
        ..clear()
        ..addAll(next));
    }
  }

  void _updateField(String name, dynamic value) {
    setState(() => _values[name] = value);
  }

  @override
  Widget build(BuildContext context) {
    final FormWatchState watchState = _getWatchState();
    final FormContext formContext = FormWidget.of(context);

    return widget.builder(watchState, formContext, context);
  }
}
