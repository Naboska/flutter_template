import 'package:flutter/material.dart';

import '../../form_widget.dart';
import '../../utils/form_field_subject.dart';
import '../../utils/form_state_subject.dart';
import '../../utils/form_subscribe_controller.dart';
import '../form_context/form_context.dart';

part 'form_controller_state.dart';
part 'form_controller_state_mixin.dart';

typedef FormControllerLifeCycle = void Function(FormController controller);
typedef FormControllerBuilder = Widget Function(
    FormController controller, BuildContext context);

class FormControllerWidget extends StatefulWidget {
  final String name;
  final FormControllerLifeCycle? onInit;
  final FormControllerLifeCycle? onUpdate;
  final FormControllerLifeCycle? onDispose;
  final FormControllerBuilder? builder;

  const FormControllerWidget(
      {Key? key,
      required this.name,
      this.onInit,
      this.onUpdate,
      this.onDispose,
      this.builder})
      : super(key: key);

  @protected
  @override
  State<FormControllerWidget> createState() => FormControllerState();
}
