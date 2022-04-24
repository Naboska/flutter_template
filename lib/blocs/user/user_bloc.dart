import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_template/api/helpers/unauthorized_interceptor.dart';
import 'package:flutter_template/models/auth/user.dart';
import 'package:flutter_template/repositories/auth/user_auth_repository.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final UserAuthRepository _userRepository = UserAuthRepository();
  late final UnauthorizedInterceptor _unauthorizedInterceptor;

  UserBloc() : super(const UserState(status: UserStatus.loading)) {
    _unauthorizedInterceptor = UnauthorizedInterceptor(() => add(UserRemoveEvent()));

    on<UserInitializeEvent>(_handleInitializeEvent);
    on<UserRemoveEvent>(_handleRemoveEvent);

    add(UserInitializeEvent());
  }

  @override
  Future<void> close() {
    _unauthorizedInterceptor.remove();
    return super.close();
  }

  Future<void> _handleInitializeEvent(UserInitializeEvent event, Emitter<UserState> emit) async {
    if (!state.status.isLoading) {
      emit(state.copyWith(status: UserStatus.loading));
    }

    try {
      final userResponse = await _userRepository.handleLogin();
      emit(state.copyWith(status: UserStatus.success, user: userResponse));
    } on DioError catch(error) {
      if (error.response?.statusCode != 401) emit(state.copyWith(status: UserStatus.error));
    } catch (error) {
      emit(state.copyWith(status: UserStatus.error));
    }
  }

  void _handleRemoveEvent(UserRemoveEvent event, Emitter<UserState> emit) {
    emit(const UserState());
  }
}
