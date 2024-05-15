import 'package:equatable/equatable.dart';
import 'package:testeflutter/common/enum/activity_enum.dart';
import 'package:testeflutter/common/utils/string_utils.dart';

abstract class ActivityState extends Equatable {
  final ActivityEnum status;
  final String? message;
  const ActivityState({required this.status, this.message});

  bool isLoading() => status.isLoading;
  bool isIdle() => status.isIdle;
  bool isError() => status.isError;
  bool isInfo() => status.isInfo;
  bool isWarning() => status.isWarning;
  bool isSuccess() => status.isSuccess;
  bool isSubmit() => status.isSubmit;
  bool isRefresh() => status.isRefresh;
  bool hasMessage() => !StringUtils.isBlank(message);

  @override
  List<Object?> get props => [status, message];
}

class ActivityLoading extends ActivityState {
  const ActivityLoading() : super(status: ActivityEnum.loading);
}

class ActivityError extends ActivityState {
  const ActivityError([String? message])
      : super(status: ActivityEnum.error, message: message);
}

class ActivityWarn extends ActivityState {
  const ActivityWarn([String? message])
      : super(status: ActivityEnum.warning, message: message);
}

class ActivityInfo extends ActivityState {
  const ActivityInfo([String? message])
      : super(status: ActivityEnum.info, message: message);
}

class ActivitySuccess extends ActivityState {
  const ActivitySuccess([String? message])
      : super(status: ActivityEnum.success, message: message);
}

class ActivityIdle extends ActivityState {
  const ActivityIdle() : super(status: ActivityEnum.idle);
}

class ActivitySubmit extends ActivityState {
  const ActivitySubmit() : super(status: ActivityEnum.submit);
}

class ActivityRefresh extends ActivityState {
  const ActivityRefresh() : super(status: ActivityEnum.refresh);
}
