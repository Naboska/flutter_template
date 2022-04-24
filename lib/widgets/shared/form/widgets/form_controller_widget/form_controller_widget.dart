import 'package:flutter/material.dart';

import 'package:flutter_template/utils/is.dart';
import '../../form_widget.dart';

part 'form_controller_state.dart';

part 'form_controller_state_mixin.dart';

typedef TFormControllerLifeCycleFn = Function(FormControllerState state);
typedef TFormControllerBuilderFn = Function(FormControllerState state, BuildContext context);

class FormController extends StatefulWidget {
  final String name;
  final TFormControllerLifeCycleFn? onInit;
  final TFormControllerLifeCycleFn? onUpdate;
  final TFormControllerLifeCycleFn? onDispose;
  final TFormControllerBuilderFn builder;

  const FormController(
      {Key? key,
      required this.name,
      this.onInit,
      this.onUpdate,
      this.onDispose,
      required this.builder})
      : super(key: key);

  @override
  State<FormController> createState() => _FormFieldState();
}
