import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_template/widgets/shared/form2/utils/form_field_subject.dart';

import '../../form_widget.dart';
import '../../utils/form_fields_subject.dart';
import '../../utils/form_subject.dart';
import '../../utils/form_subscribe_controller.dart';
import '../../utils/form_state_subject.dart';
import '../form_context/form_context.dart';

part 'form_watch_state.dart';
part 'form_watch_state_mixin.dart';

typedef FormWatchBuilder = Function(
    FormWatchState state, FormContext formContext, BuildContext context);

class FormWatch extends StatefulWidget {
  final List<String>? watch;
  final FormWatchBuilder builder;
  final FormContext? formContext;

  const FormWatch(
      {Key? key, this.watch, required this.builder, this.formContext})
      : super(key: key);

  @override
  State<FormWatch> createState() => _FormWatchState();
}
