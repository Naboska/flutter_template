import 'package:flutter/material.dart';
import 'package:flutter_template/widgets/shared/form/form.dart';

class FormDevtoolsWidget extends StatefulWidget {
  const FormDevtoolsWidget({Key? key}) : super(key: key);

  @override
  State<FormDevtoolsWidget> createState() => _FormDevtoolsWidgetState();
}

class _FormDevtoolsWidgetState extends State<FormDevtoolsWidget> {
  void _getFormInfo() {
    showModalBottomSheet(
        context: context,
        builder: (_) {
          return SingleChildScrollView(
            child: FormWatch(
                formContext: FormWidget.of(context),
                builder: (state, formContext, context) {
                  final keys = state.values.keys.toList();

                  return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8),
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('dirty: ${state.formState.isDirty}'),
                                Text(
                                    'submitted: ${state.formState.isSubmitted}'),
                                Text(
                                    'submitting: ${state.formState.isSubmitting}'),
                                Text('valid: ${state.formState.isValid}'),
                              ]),
                        ),
                        ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemBuilder: (BuildContext context, int index) {
                              final name = keys[index];

                              return Accordion(
                                name: name,
                                value: state.values[name],
                                errorMessage: state.errors[name],
                                isTouched: state.touchedFields[name] == true,
                              );
                            },
                            itemCount: keys.length)
                      ]);
                }),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Align(
        alignment: Alignment.centerLeft,
        child: InkWell(
            onTap: _getFormInfo,
            child: const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text('formDevtools'),
            )));
  }
}

class Accordion extends StatefulWidget {
  final String name;
  final dynamic value;
  final bool isTouched;
  final String? errorMessage;

  const Accordion({
    Key? key,
    required this.name,
    this.value,
    required this.isTouched,
    this.errorMessage,
  }) : super(key: key);
  @override
  _AccordionState createState() => _AccordionState();
}

class _AccordionState extends State<Accordion> {
  bool _showContent = false;
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(10),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        ListTile(
          title: Text(widget.name),
          trailing: IconButton(
            icon: Icon(
                _showContent ? Icons.arrow_drop_up : Icons.arrow_drop_down),
            onPressed: () {
              setState(() {
                _showContent = !_showContent;
              });
            },
          ),
        ),
        _showContent
            ? Padding(
                padding: const EdgeInsets.only(left: 10, right: 10, bottom: 10),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Type: ${widget.value.runtimeType}'),
                      const SizedBox(height: 8),
                      Text('Value: ${widget.value}'),
                      const SizedBox(height: 8),
                      Text('Touched: ${widget.isTouched}'),
                      const SizedBox(height: 8),
                      Text('Error: ${widget.errorMessage}'),
                    ]),
              )
            : Container()
      ]),
    );
  }
}
