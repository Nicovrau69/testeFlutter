import 'package:equatable/equatable.dart';
import 'package:testeflutter/common/activity_state.dart';
import 'package:testeflutter/common/optional.dart';

abstract class AbstractState<T extends ActivityState> extends Equatable {
  final T state;

  const AbstractState({required this.state});

  copyWith({ActivityState? state});

  bool isLoading() => state.isLoading();
  bool isIdle() => state.isIdle();
  bool isError() => state.isError();
  bool isInfo() => state.isInfo();
  bool isWarning() => state.isWarning();
  bool isSuccess() => state.isSuccess();
  bool isSubmit() => state.isSubmit();
  bool isRefresh() => state.isRefresh();

  copyOptional(Optional? optional, Object? current) {
    if (optional == null) {
      return current;
    }
    return optional.value;
  }
}
