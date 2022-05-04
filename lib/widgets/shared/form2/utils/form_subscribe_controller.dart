import 'form_subject.dart';

class FormSubscribeController {
  final Map<int, Subscription> _listeners = {};

  Map<int, Subscription> get listeners => _listeners;

  bool isSubscribe<T>(FormSubject<T> subject) {
    return _listeners.containsKey(subject.hashCode);
  }

  void subscribe<T>(
      FormSubject<T> subject, Function(T value, T oldValue) listener) {
    if (isSubscribe(subject)) removeListeners(subject);

    _listeners[subject.hashCode] = subject.subscribe(listener);
  }

  void removeListeners<T>(FormSubject<T> subject) {
    final int key = subject.hashCode;
    final Subscription? unsubscribe = _listeners[subject.hashCode];

    if (unsubscribe != null) {
      unsubscribe();
      _listeners.remove(key);
    }
  }

  void dispose() {
    if (_listeners.keys.isNotEmpty) {
      for (Subscription unsubscribe in _listeners.values) {
        unsubscribe();
      }

      listeners.clear();
    }
  }
}
