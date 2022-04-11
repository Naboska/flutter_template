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

  UserBloc._initialize() : super(const UserState()) {
    on<UserInitializeEvent>(_mapInitializeEventToState);
    on<UserRemoveEvent>(_mapRemoveEventToState);

    add(UserInitializeEvent());
  }

  Future<void> _mapInitializeEventToState(
      UserInitializeEvent event, Emitter<UserState> emit) async {
    emit(state.copyWith(status: UserStatus.loading));
    try {
      final userResponse = await _userRepository.handleLogin();
      emit(state.copyWith(status: UserStatus.success, user: userResponse));
    } catch (error, stacktrace) {
      emit(state.copyWith(status: UserStatus.error));
    }
  }

  void _mapRemoveEventToState(UserRemoveEvent event, Emitter<UserState> emit) async {
    await Future.microtask(() => emit(const UserState()));
  }
}
