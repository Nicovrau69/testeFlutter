enum ActivityEnum {
  loading,
  error,
  warning,
  info,
  success,
  idle,
  submit,
  refresh,
}

extension ActivityEnumExt on ActivityEnum {
  bool get isLoading => this == ActivityEnum.loading;
  bool get isSuccess => this == ActivityEnum.success;
  bool get isError => this == ActivityEnum.error;
  bool get isWarning => this == ActivityEnum.warning;
  bool get isInfo => this == ActivityEnum.info;
  bool get isIdle => this == ActivityEnum.idle;
  bool get isRefresh => this == ActivityEnum.refresh;
  bool get isSubmit => this == ActivityEnum.submit;
}
