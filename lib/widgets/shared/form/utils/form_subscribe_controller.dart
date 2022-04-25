part of '../form_widget.dart';

class FormSubscribeController {
  final Map<int, Subscription> _listeners = {};

  Map<int, Subscription> get listeners => _listeners;

  void subscribe<T>(_FormSubject<T> subject, Function(T value) listener) {
    final subjectHash = subject.hashCode;

    if (_listeners.containsKey(subjectHash)) removeListeners(subjectHash);

    _listeners[subject.hashCode] = subject.subscribe(listener);
  }

  void removeListeners(int subjectHash) {
    final unsubscribe = _listeners[subjectHash];

    if (unsubscribe != null) {
      unsubscribe();
      _listeners.remove(subjectHash);
    }
  }

void dispose() {
  if (_listeners.keys.isNotEmpty) {
    for (Subscription unsubscribe in _listeners.values) {
      unsubscribe();
    }

    listeners.clear();
  }
}}