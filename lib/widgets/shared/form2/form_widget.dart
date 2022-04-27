import 'package:flutter/material.dart';

import 'widgets/form_context/form_context.dart';
import 'utils/form_fields_subject.dart';
import 'utils/form_field_subject.dart';
import 'utils/form_state_subject.dart';
import 'types.dart';

part 'utils/form_mixin.dart';
part 'form_widget_state.dart';

class FormWidget extends StatefulWidget {
  final FormWidgetBuilder builder;
  final FormSubmitHandler? onSubmit;
  final FormValidationHandler? validation;

  const FormWidget(
      {Key? key, required this.builder, this.onSubmit, this.validation})
      : super(key: key);

  static FormContext of(BuildContext context) {
    final ctx = context.getElementForInheritedWidgetOfExactType<FormProvider>();
    final provider = ctx?.widget as FormProvider;

    return provider.context;
  }

  @override
  State<FormWidget> createState() => _FormWidgetState();
}
