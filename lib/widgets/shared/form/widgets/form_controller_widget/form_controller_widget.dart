import 'package:flutter/material.dart';

import '../../form_widget.dart';

part 'form_controller_state.dart';
part 'form_controller_state_mixin.dart';

typedef TFormControllerLifeCycleFn = Function(FormControllerWidgetState state);
typedef TFormControllerBuilderFn = Function(
    FormControllerWidgetState state, BuildContext context);

class FormControllerWidget extends StatefulWidget {
  final String name;
  final TFormControllerLifeCycleFn? onInit;
  final TFormControllerLifeCycleFn? onUpdate;
  final TFormControllerLifeCycleFn? onDispose;
  final TFormControllerBuilderFn? builder;

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
  State<FormControllerWidget> createState() => FormController();
}
