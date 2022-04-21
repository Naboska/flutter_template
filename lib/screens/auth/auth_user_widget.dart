import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_template/blocs/user/user_bloc.dart';
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
                  FormWidget(child: const ExampleField()),
                  if (status.isLoading) const CircularProgressIndicator(),
                  if (status.isError) const Text('Oops... error:(')
                ]),
              ));
    });
  }
}

class ExampleField extends StatefulWidget {
  const ExampleField({Key? key}) : super(key: key);

  @override
  State<ExampleField> createState() => _ExampleFieldState();
}

class _ExampleFieldState extends State<ExampleField> {
  late final FormProvider _form;
  Subscription? _unsubscribe;

  dynamic state = 2;

  @override
  void initState() {
    super.initState();
    _form = FormWidget.of(context);
    _form.setValue(name: 'kek', value: 1);
    _unsubscribe = _form.fields['kek']?.subscribe((value) {
      setState(() {
        state = value;
      });
    });
  }

  @override
  void dispose() {
    if (_unsubscribe != null) _unsubscribe!();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(children: [
      Text(state.toString()),
      ElevatedButton(
          onPressed: () {
            _form.setValue(name: 'kek', value: state + 1);
          },
          child: Text('up'))
    ]));
  }
}
