import 'package:flutter/material.dart';

import 'form_widget.dart';

typedef ControllerFunction<T> = T Function(FormControllerState state);

class FormControllerState {
  final FormStateValuesType formState;
  final void Function(dynamic value) setValue;
  final Map<String, dynamic> values;
  final dynamic value;
  final String? errorMessage;

  FormControllerState(
      {required this.setValue,
      required this.formState,
      required this.values,
      required this.value,
      required this.errorMessage});
}

class FormController extends StatefulWidget {
  final String name;
  final List<String>? watch;
  final ControllerFunction<Widget> builder;
  final ControllerFunction<void>? onInit;
  final ControllerFunction<void>? onUpdate;
  final ControllerFunction<void>? onDispose;

  const FormController(
      {Key? key,
      required this.name,
      required this.builder,
      this.watch,
      this.onInit,
      this.onUpdate,
      this.onDispose})
      : super(key: key);

  @override
  State<FormController> createState() => _FormFieldState();
}

class _FormFieldState extends State<FormController> {
  late final FormProvider _form;
  late final FormFieldSubjectType _field;
  final List<Subscription> _subscriptions = [];
  final Map<String, dynamic> _watchFields = {};
  late FormStateValuesType _formState;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();

    _form = FormWidget.of(context);
    _field = _form.register(name: widget.name);

    final formStateObserver = _form.formState
        .subscribe((value) => setState(() => _formState = value));

    final errorObserver = _form.errors.subscribe((value) {
      final errorMessage = value[widget.name];

      if (errorMessage != _errorMessage) {
        setState(() => (_errorMessage = errorMessage));
      }
    });

    final fieldStateObserver = _field.subscribe(
        (value) => setState(() => _watchFields[widget.name] = value));

    if (widget.watch != null) {
      final watch = widget.watch!.where((name) => name != widget.name);

      for (String fieldName in watch) {
        final formField =
            _form.fields[fieldName] ?? _form.register(name: fieldName);

        final observer = formField.subscribe(
            (value) => setState(() => _watchFields[fieldName] = value));

        _subscriptions.add(observer);
      }
    }

    _subscriptions
        .addAll([formStateObserver, errorObserver, fieldStateObserver]);

    if (widget.onInit != null) widget.onInit!(_getControllerState());
  }

  @override
  void dispose() {
    if (widget.onDispose != null) widget.onDispose!(_getControllerState());

    for (Subscription unsubscribe in _subscriptions) {
      unsubscribe();
    }

    super.dispose();
  }

  @override
  void setState(VoidCallback cb) {
    cb();

    if (widget.onUpdate != null) widget.onUpdate!(_getControllerState());

    super.setState(() {});
  }

  _setValue(dynamic value) => _field.next(value);

  FormControllerState _getControllerState() {
    final currentValue = _watchFields[widget.name];

    return FormControllerState(
      formState: _formState,
      setValue: _setValue,
      values: _watchFields,
      errorMessage: _errorMessage,
      value: currentValue,
    );
  }

  @override
  Widget build(BuildContext context) {
    final nextState = _getControllerState();

    return widget.builder(nextState);
  }
}
