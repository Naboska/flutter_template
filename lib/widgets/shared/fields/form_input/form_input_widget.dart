import 'package:flutter/material.dart';

import 'package:flutter_template/widgets/shared/form/form.dart';

class FormInputWidget extends StatelessWidget {
  final String name;
  final String? label;

  const FormInputWidget({Key? key, required this.name, this.label})
      : super(key: key);

  void _updateText(TextEditingController controller, String? value) {
    final String nextValue = value ?? '';

    if (controller.text != nextValue) {
      controller.text = nextValue;
      controller.selection = TextSelection(
          baseOffset: nextValue.length, extentOffset: nextValue.length);
    }
  }

  @override
  Widget build(BuildContext context) {
    final TextEditingController _controller = TextEditingController();

    return FormController(
        name: name,
        onInit: (FormControllerState state) {
          _controller.text = state.value ?? '';
        },
        onUpdate: (FormControllerState state) {
          _updateText(_controller, state.value);
        },
        onDispose: (FormControllerState state) {
          _controller.clear();
        },
        builder: (FormControllerState state, BuildContext context) {
          return TextFormField(
              controller: _controller,
              decoration: InputDecoration(
                  label: label != null ? Text(label!) : null,
                  errorText: state.errorMessage),
              onChanged: state.setValue);
        });
  }
}
