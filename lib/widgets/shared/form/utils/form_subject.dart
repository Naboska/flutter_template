part of '../form_widget.dart';

typedef Observer<T> = void Function(T value);

typedef Subscription = void Function();

class _FormSubject<T> {
  List<Observer<T>> _observers = [];
  late T _state;

  T get state => _state;

  _FormSubject(T state) {
    _state = state;
  }

  void next(dynamic nextState) {
    _state = nextState;

    for (Observer<T> observer in _observers) {
      observer(nextState);
    }
  }

  Subscription subscribe(Observer<T> observer) {
    _observers.add(observer);

    if (_state != null) observer(_state!);

    return () => _observers.remove(observer);
  }

  List<Observer<T>> close() => _observers = [];
}