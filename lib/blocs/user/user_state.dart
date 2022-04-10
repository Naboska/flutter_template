part of 'user_bloc.dart';

enum UserStatus { initial, success, error, loading }

extension UserStatusX on UserStatus {
  bool get isInitial => this == UserStatus.initial;

  bool get isSuccess => this == UserStatus.success;

  bool get isError => this == UserStatus.error;

  bool get isLoading => this == UserStatus.loading;
}

class UserState extends Equatable {
  const UserState({this.status = UserStatus.initial, this.user});

  final UserModel? user;
  final UserStatus status;

  @override
  List<Object?> get props => [status, user];

  UserState copyWith({UserModel? user, UserStatus? status}) {
    return UserState(user: user ?? this.user, status: status ?? this.status);
  }
}
