import 'package:flutter/material.dart';

import 'package:equatable/equatable.dart';

import 'package:flutter_template/utils/is.dart';

part 'utils/form_subject.dart';

part 'utils/form_mixin.dart';

part 'widgets/form_context/form_provider.dart';

part 'widgets/form_context/form_context.dart';

part 'form_widget_state.dart';

part 'form_state.dart';

part 'types.dart';

class FormWidget extends StatefulWidget {
  final TFormWidgetBuilder builder;
  final TFormSubmitHandler? onSubmit;
  final TFormValidation? validation;

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
