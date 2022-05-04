import 'package:flutter/material.dart';

typedef Observer<T> = void Function(T value, T oldValue);

typedef Subscription = void Function();

class FormSubject<T> {
  List<Observer<T>> _observers = [];
  late T _state;
  bool _isDirty = false;

  T get state => _state;
  bool get isDirty => _isDirty;

  FormSubject(T state) {
    _state = state;
  }

  @protected
  void next(dynamic nextState) {
    _isDirty = true;
    T oldState = state;
    _state = nextState;
    _notify(nextState, oldState);
  }

  @protected
  void reset(dynamic resetValue) {
    _isDirty = false;
    _state = resetValue;
    _notify(_state, _state);
  }

  Subscription subscribe(Observer<T> observer) {
    _observers.add(observer);

    if (_state != null) observer(_state!, _state!);

    return () => _observers.remove(observer);
  }

  List<Observer<T>> close() => _observers = [];

  _notify(dynamic nextState, dynamic oldState) {
    for (Observer<T> observer in _observers) {
      observer(nextState, oldState);
    }
  }
}
