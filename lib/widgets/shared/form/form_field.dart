import 'package:flutter/material.dart';

import 'form_widget.dart';

typedef FormFieldValues = Map<String, dynamic>;
typedef FormFieldSetHandler = void Function(dynamic value);

typedef FormBuilder = Widget Function(FormFieldValues values,
    FormFieldSetHandler setValue, FormStateValues formState);

class FormFieldWidget extends StatefulWidget {
  final String name;
  final List<String>? watch;
  final FormBuilder builder;

  const FormFieldWidget(
      {Key? key, required this.name, this.watch, required this.builder})
      : super(key: key);

  @override
  State<FormFieldWidget> createState() => _FormFieldState();
}

class _FormFieldState extends State<FormFieldWidget> {
  late final FormProvider _form;
  late final FormFieldSubject _field;
  final List<Subscription> _subscriptions = [];
  final Map<String, dynamic> _watchFields = {};
  late FormStateValues _formState;

  @override
  void initState() {
    super.initState();

    _form = FormWidget.of(context);
    _field = _form.register(name: widget.name);

    final formStateObserver = _form.formState
        .subscribe((value) => setState(() => _formState = value));
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

    _subscriptions.addAll([formStateObserver, fieldStateObserver]);
  }

  @override
  void dispose() {
    for (Subscription unsubscribe in _subscriptions) {
      unsubscribe();
    }

    super.dispose();
  }

  _setValue(dynamic value) => _field.next(value);

  @override
  Widget build(BuildContext context) {
    return widget.builder(_watchFields, _setValue, _formState);
  }
}
