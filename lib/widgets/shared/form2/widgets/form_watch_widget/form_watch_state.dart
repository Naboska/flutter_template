part of 'form_watch_widget.dart';

class _FormWatchState extends State<FormWatch> with FormWatchStateMixin {
  final _subscriptionController = FormSubscribeController();
  late final bool isControlled;

  @override
  void initState() {
    super.initState();

    _form = widget.formContext ?? FormWidget.of(context);
    isControlled = widget.watch != null;

    _subscriptionController.subscribe(_form.formState, _formStateListener);

    if (!isControlled || widget.watch!.isNotEmpty) {
      _subscriptionController.subscribe(_form.fields, _fieldsListener);
    }
  }

  @override
  void dispose() {
    _subscriptionController.dispose();

    super.dispose();
  }

  void _fieldsListener(Map<String, FormFieldSubject> fields, _) {
    for (MapEntry<String, FormFieldSubject> field in fields.entries) {
      if (isControlled && !widget.watch!.contains(field.key)) continue;
      if (_subscriptionController.isSubscribe(field.value)) continue;
      void listener(FormFieldStateValues v, _) => _updateField(field.key, v);
      _subscriptionController.subscribe(field.value, listener);
    }
  }

  void _formStateListener(FormStateValues formStateValues, _) {
    setState(() => _formState = formStateValues);
  }

  void _updateField(String name, FormFieldStateValues fieldState) {
    setState(() => _fields[name] = fieldState);
  }

  @override
  Widget build(BuildContext context) {
    final FormWatchState watchState = _getWatchState();

    return widget.builder(watchState, _form, context);
  }
}
