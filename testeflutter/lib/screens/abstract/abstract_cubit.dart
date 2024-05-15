import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:testeflutter/common/activity_state.dart';
import 'package:testeflutter/screens/abstract/abstract_state.dart';

abstract class AbstractCubit<T extends AbstractState> extends Cubit<T> {
  AbstractCubit(T initialState) : super(initialState);

  void setState(ActivityState value) {
    emit(state.copyWith(state: value));
  }

  void setStateLoading() {
    emit(state.copyWith(state: const ActivityLoading()));
  }

  void setStateSuccess([String? message]) {
    emit(state.copyWith(state: ActivitySuccess(message)));
  }

  void setStateIdle() {
    emit(state.copyWith(state: const ActivityIdle()));
  }

  void setStateSubmit() {
    emit(state.copyWith(state: const ActivitySubmit()));
  }

  void setStateError([String? message]) {
    emit(state.copyWith(state: ActivityError(message)));
  }

  void setStateWarn([String? message]) {
    emit(state.copyWith(state: ActivityWarn(message)));
  }

  void setStateInfo([String? message]) {
    emit(state.copyWith(state: ActivityInfo(message)));
  }

  ActivityState get activityState => state.state;

  ///Checa se o cubit ainda pode emitir states
  bool get fechado => isClosed;
}
