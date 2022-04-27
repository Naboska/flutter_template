part of 'form_controller_widget.dart';

class FormControllerState<T extends FormControllerWidget> extends State<T>
    with FormControllerStateMixin {
  final _subscriptionController = FormSubscribeController();

  @protected
  @override
  void initState() {
    super.initState();

    _form = FormWidget.of(context);

    field = _form.register(name: widget.name);
    fieldName = widget.name;

    _subscriptionController.subscribe(_form.formState, _formStateListener);
    _subscriptionController.subscribe(field, _fieldStateListener);

    if (widget.onInit != null) widget.onInit!(getController());
  }

  @protected
  @override
  void dispose() {
    if (widget.onDispose != null) widget.onDispose!(getController());

    _subscriptionController.dispose();

    super.dispose();
  }

  @protected
  @override
  void didUpdateWidget(covariant T oldWidget) {
    if (widget.onInit != null) widget.onUpdate!(getController());
    super.didUpdateWidget(oldWidget);
  }

  void _formStateListener(FormStateValues values, _) {
    setState(() => formState = values);
  }

  void _fieldStateListener(FormFieldStateValues values, _) {
    setState(() => fieldState = values);
  }

  @override
  Widget build(BuildContext context) {
    return widget.builder!(getController(), context);
  }
}
