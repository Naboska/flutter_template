import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'other_event.dart';

part 'other_state.dart';

class OtherBloc extends Bloc<OtherEvent, OtherState> {
  OtherBloc() : super(const OtherState()) {
    on<OtherEvent>(_mapOtherEventToState);
  }

  void _mapOtherEventToState(OtherEvent event, Emitter<OtherState> emit) async {
    emit(state.copyWith(status: OtherStatus.loading));
    try {
      final response = await Future.delayed(Duration.zero);
      emit(
        state.copyWith(status: OtherStatus.success, count: 1),
      );
    } catch (error, stacktrace) {
      emit(state.copyWith(status: OtherStatus.error));
    }
  }
}
