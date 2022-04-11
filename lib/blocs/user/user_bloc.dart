import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_template/models/auth/user.dart';
import 'package:flutter_template/repositories/auth/user_auth_repository.dart';

part 'user_event.dart';

part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  static UserBloc? _instance;
  final _userRepository = UserAuthRepository();

  factory UserBloc() => _instance ??= UserBloc._initialize();

  UserBloc._initialize() : super(const UserState(status: UserStatus.loading)) {
    on<UserEvent>(_mapUserEventToState, transformer: sequential());

    add(UserInitializeEvent());
  }

  void _mapUserEventToState(UserEvent event, Emitter<UserState> emit) async {
    if (event is UserInitializeEvent) {
      await _handleInitializeEvent(emit);
    } else if (event is UserRemoveEvent) {
      _handleRemoveEvent(emit);
    }
  }

  Future<void> _handleInitializeEvent(Emitter<UserState> emit) async {
    if (!state.status.isLoading) {
      emit(state.copyWith(status: UserStatus.loading));
    }

    try {
      final userResponse = await _userRepository.handleLogin();
      emit(state.copyWith(status: UserStatus.success, user: userResponse));
    } catch (error, stacktrace) {
      emit(state.copyWith(status: UserStatus.error));
    }
  }

  void _handleRemoveEvent(Emitter<UserState> emit) {
    emit(const UserState());
  }
}
