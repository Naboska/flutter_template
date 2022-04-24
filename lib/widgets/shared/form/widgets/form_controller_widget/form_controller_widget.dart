import 'package:flutter/material.dart';
import 'package:flutter_template/utils/is.dart';

import '../../form_widget.dart';

part 'form_controller_state.dart';

part 'form_controller_state_mixin.dart';

typedef TLifeCycleFn = Function(FormControllerState state);
typedef TBuilderFn = Function(FormControllerState state, BuildContext context);

class FormController extends StatefulWidget {
  final String name;
  final TLifeCycleFn? onInit;
  final TLifeCycleFn? onUpdate;
  final TLifeCycleFn? onDispose;
  final TBuilderFn builder;

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
