import 'package:flutter/material.dart';

import 'package:flutter_template/widgets/shared/form2/form.dart';

class FormInputWidget extends FormControllerWidget {
  final String? label;

  const FormInputWidget({Key? key, this.label, required String name})
      : super(key: key, name: name);

  @override
  FormControllerState<FormInputWidget> createState() => _FormInputController();
}

class _FormInputController extends FormControllerState<FormInputWidget> {
  final TextEditingController _controller = TextEditingController();
  final FocusNode _node = FocusNode();

  @override
  void initState() {
    super.initState();

    _controller.text = fieldState.value ?? '';
    _node.addListener(_focusListener);
  }

  @override
  void didUpdateWidget(covariant FormInputWidget oldWidget) {
    final String _value = fieldState.value ?? '';
    final length = _value.length;

    if (_controller.text != _value) {
      final ts = TextSelection(baseOffset: length, extentOffset: length);
      _controller.text = _value;
      _controller.selection = ts;
    }

    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
    _controller.clear();
    _node.dispose();

    super.dispose();
  }

  void _focusListener() {
    if (!_node.hasFocus) field.handleTouched();
  }

  @override
  Widget build(BuildContext context) {
    final bool isError = formState.isSubmitted || fieldState.isTouched;

    return TextFormField(
        focusNode: _node,
        controller: _controller,
        decoration: InputDecoration(
            label: widget.label != null ? Text(widget.label!) : null,
            errorText: isError ? fieldState.errorMessage : null),
        onChanged: field.setValue);
  }
}
