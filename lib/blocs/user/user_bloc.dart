import 'dart:async';
import 'package:equatable/equatable.dart';

import 'package:flutter_template/repositories/auth/user_auth_repository.dart';
import 'package:flutter_template/models/auth/user.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc {
  static UserBloc? _instance;

  final _userRepository = UserAuthRepository();
  UserState _state = const UserState();

  final _eventController = StreamController<UserEvent>.broadcast();
  late final Stream<UserState> _stateStream;

  UserState get state => _state;
  Stream<UserState> get stream => _stateStream;

  factory UserBloc() => _instance ??= UserBloc._initialize();

  UserBloc._initialize() {
    _stateStream = _eventController.stream
        .asyncExpand<UserState>(_mapEventToState)
        .asyncExpand<UserState>(_updateState)
        .asBroadcastStream();

    _stateStream.listen((event) {});
    dispatch(UserInitializeEvent());
  }

  void dispatch(UserEvent event) {
    _eventController.add(event);
  }

  Stream<UserState> _updateState(UserState state) async* {
    print(['old', _state]);
    print(['new', state]);
    if (_state != state) yield (_state = state);
  }

  Stream<UserState> _mapEventToState(UserEvent event) async* {
    if (event is UserInitializeEvent) {
      yield* _initializeUser();
    } else if (event is UserRemoveEvent) {
      yield const UserState();
    }
  }

  Stream<UserState> _initializeUser() async* {
    try {
      yield _state.copyWith(status: UserStatus.loading);
      final user = await _userRepository.handleLogin();
      yield _state.copyWith(user: user, status: UserStatus.success);
    } catch (e) {
      yield _state.copyWith(status: UserStatus.error);
    }
  }
}
