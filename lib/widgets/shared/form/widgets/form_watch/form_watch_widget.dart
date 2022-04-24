import 'package:flutter/material.dart';
import 'package:flutter_template/utils/is.dart';
import '../../form_widget.dart';

part 'form_watch_state.dart';

part 'form_watch_state_mixin.dart';

typedef TFormWatchBuilderFn = Function(
    FormWatchState state, FormContext formContext, BuildContext context);

class FormWatch extends StatefulWidget {
  final List<String>? watch;
  final TFormWatchBuilderFn builder;

  const FormWatch({Key? key, this.watch, required this.builder})
      : super(key: key);

  @override
  State<FormWatch> createState() => _FormWatchState();
}
