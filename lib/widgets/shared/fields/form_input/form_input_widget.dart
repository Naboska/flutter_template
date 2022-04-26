import 'package:flutter/material.dart';

import 'package:flutter_template/widgets/shared/form/form.dart';

class FormInputWidget extends FormControllerWidget {
  final String? label;

  const FormInputWidget({Key? key, this.label, required String name})
      : super(key: key, name: name);

  @override
  FormController<FormInputWidget> createState() => _FormInputController();
}

class _FormInputController extends FormController<FormInputWidget> {
  final TextEditingController _controller = TextEditingController();
  final FocusNode _node = FocusNode();

  @override
  controllerDidInit(FormControllerWidgetState field) {
    _controller.text = field.value ?? '';

    _node.addListener(() {
      if (!_node.hasFocus) field.handleBlur();
    });
  }

  @override
  controllerDidUpdate(FormControllerWidgetState field) {
    final String value = field.value ?? '';

    if (_controller.text != value) {
      _controller.text = value;
      _controller.selection =
          TextSelection(baseOffset: value.length, extentOffset: value.length);
    }
  }

  @override
  controllerWillDispose(FormControllerWidgetState field) {
    _controller.clear();
  }

  @override
  Widget build(BuildContext context) {
    final FormControllerWidgetState field = getField();

    final bool isError = field.formState.isSubmitted || field.isTouched;

    return TextFormField(
        focusNode: _node,
        controller: _controller,
        decoration: InputDecoration(
            label: widget.label != null ? Text(widget.label!) : null,
            errorText: isError ? field.errorMessage : null),
        onChanged: field.setValue);
  }
}
