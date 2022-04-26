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
      _subscriptionController.subscribe(_form.errors, _errorsListener);
      _subscriptionController.subscribe(_form.fields, _fieldsListener);
      _subscriptionController.subscribe(_form.touchedFields, _touchedListener);
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

  void _errorsListener(TFormErrorValues errors) {
    _updateMapListener({...errors}, _errors);
  }

  void _touchedListener(TFormTouchedValues touchedFields) {
    _updateMapListener({...touchedFields}, _touchedFields);
  }

  void _updateMapListener<T extends Map<String, dynamic>>(T check, T update) {
    if (isControlled) {
      check.removeWhere((key, value) {
        return !widget.watch!.contains(key) && update[key] == check[key];
      });
    }

    if (!mapEquals(check, update)) {
      setState(() => update
        ..clear()
        ..addAll(check));
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
