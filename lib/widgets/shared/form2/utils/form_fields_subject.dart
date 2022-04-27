import 'form_field_subject.dart';
import 'form_subject.dart';

class FormFieldsSubject extends FormSubject<Map<String, FormFieldSubject>> {
  FormFieldsSubject() : super({});

  FormFieldSubject createField({required String name}) {
    return getField(name) ?? (state[name] = FormFieldSubject());
  }

  FormFieldSubject? getField(String name) => state[name];

  void notifyForm() => next(state);
}
