import 'package:flutter/material.dart';
import 'package:flutter_template/widgets/shared/form/widgets/form_controller_widget/form_controller_widget.dart';

class FormInputWidget extends StatelessWidget {
  final String name;

  const FormInputWidget({Key? key, required this.name}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final TextEditingController _controller = TextEditingController();

    return FormController(
        name: name,
        onInit: (FormControllerState state) {
          _controller.text = state.value ?? '';
        },
        onUpdate: (FormControllerState state) {
          final String nextValue = state.value ?? '';
          final bool isEqual = _controller.text == nextValue;

          if (!isEqual) {
            _controller.text = nextValue;
            _controller.selection = TextSelection(baseOffset: nextValue.length, extentOffset: nextValue.length);
          }
        },
        onDispose: (FormControllerState state) {
          _controller.dispose();
        },
        builder: (FormControllerState state, BuildContext context) {
          return TextField(
              controller: _controller,
              decoration: InputDecoration(errorText: state.errorMessage),
              onChanged: state.setValue);
        });
  }
}
