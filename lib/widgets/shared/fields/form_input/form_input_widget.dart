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
  void controllerDidInit() {
    _controller.text = value ?? '';
    _node.addListener(_focusListener);
  }

  @override
  void controllerDidUpdate() {
    _textListener();
  }

  @override
  void controllerWillDispose() {
    _controller.clear();
    _node.dispose();
  }

  void _focusListener() {
    if (!_node.hasFocus) handleBlur();
  }

  void _textListener() {
    final String _value = value ?? '';
    final length = _value.length;

    if (_controller.text != _value) {
      final _ts = TextSelection(baseOffset: length, extentOffset: length);
      _controller.text = _value;
      _controller.selection = _ts;
    }
  }

  @override
  Widget build(BuildContext context) {
    final bool isError = formState.isSubmitted || isTouched;

    return TextFormField(
        focusNode: _node,
        controller: _controller,
        decoration: InputDecoration(
            label: widget.label != null ? Text(widget.label!) : null,
            errorText: isError ? errorMessage : null),
        onChanged: setValue);
  }
}
