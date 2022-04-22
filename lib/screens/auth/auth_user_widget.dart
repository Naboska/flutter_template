import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_template/blocs/user/user_bloc.dart';
import 'package:flutter_template/widgets/shared/form/form_field.dart';
import 'package:flutter_template/widgets/shared/form/form_widget.dart';
import 'package:flutter_template/widgets/shared/possible_widget/possible_widget.dart';

class AuthUserWidget extends StatelessWidget {
  const AuthUserWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserBloc, UserState>(builder: (context, state) {
      final status = state.status;

      return PossibleWidget(
          isRender: status != UserStatus.initial,
          child: () => SizedBox(
                width: 400,
                height: 400,
                child: Column(children: <Widget>[
                  FormWidget(
                      child: FormFieldWidget(
                          name: 'kek',
                          watch: const ['kek2', 'kek'],
                          builder: (FormFieldValues values,
                              FormFieldSetHandler setValue,
                              FormStateValues formState) {
                            return TextField(
                              onChanged: setValue,
                              decoration: InputDecoration(
                                  counter: Text(values['kek'].toString())),
                            );
                          })),
                  if (status.isLoading) const CircularProgressIndicator(),
                  if (status.isError) const Text('Oops... error:(')
                ]),
              ));
    });
  }
}
