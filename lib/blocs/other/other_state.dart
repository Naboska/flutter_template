part of 'other_bloc.dart';

enum OtherStatus { initial, success, error, loading }

extension OtherStatusX on OtherStatus {
  bool get isInitial => this == OtherStatus.initial;
  bool get isSuccess => this == OtherStatus.success;
  bool get isError => this == OtherStatus.error;
  bool get isLoading => this == OtherStatus.loading;
}

class OtherState extends Equatable {
  const OtherState({this.status = OtherStatus.initial, this.count});

  final int? count;
  final OtherStatus status;

  @override
  List<Object?> get props => [status, count];

  OtherState copyWith({int? count, OtherStatus? status}) {
    return OtherState(count: count ?? this.count, status: status ?? this.status);
  }
}
