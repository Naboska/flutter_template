import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../form_widget.dart';

part 'form_watch_state.dart';

part 'form_watch_state_mixin.dart';

typedef TFormWatchBuilderFn = Function(
    FormWatchState state, FormContext formContext, BuildContext context);

class FormWatch extends StatefulWidget {
  final List<String>? watch;
  final TFormWatchBuilderFn builder;
  final FormContext? formContext;

  const FormWatch(
      {Key? key, this.watch, required this.builder, this.formContext})
      : super(key: key);

  @override
  State<FormWatch> createState() => _FormWatchState();
}
