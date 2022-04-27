import 'form_field_subject.dart';
import 'form_subject.dart';

class FormFieldsSubject extends FormSubject<Map<String, FormFieldSubject>> {
  FormFieldsSubject() : super({});

  FormFieldSubject createField({required String name, dynamic initialValue}) {
    final field = getField(name);

    if (field != null) return field;

    return (state[name] = FormFieldSubject(initialValue: initialValue));
  }

  FormFieldSubject? getField(String name) => state[name];

  void notifyForm() => next(state);
}
