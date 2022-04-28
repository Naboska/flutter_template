part of 'form_controller_widget.dart';

class FormControllerState<T extends FormControllerWidget> extends State<T>
    with FormControllerStateMixin {
  final _subscriptionController = FormSubscribeController();
  bool _isInitialized = false;

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

    _isInitialized = true;
  }

  @protected
  @override
  void dispose() {
    if (widget.onDispose != null) widget.onDispose!(getController());

    _subscriptionController.dispose();

    super.dispose();
  }

  @protected
  void didUpdateController(
      FormController controller, FormController oldController) {
    if (widget.onInit != null) widget.onUpdate!(controller, oldController);
  }

  void _formStateListener(FormStateValues values, _) {
    _updateController(() => formState = values);
  }

  void _fieldStateListener(FormFieldStateValues values, _) {
    _updateController(() => fieldState = values);
  }

  void _updateController(VoidCallback updateValues) {
    if (_isInitialized) {
      final FormController oldController = getController();
      updateValues();
      didUpdateController(getController(), oldController);
      setState(noop);
    } else {
      setState(updateValues);
    }
  }

  @override
  Widget build(BuildContext context) {
    return widget.builder!(getController(), context);
  }
}
