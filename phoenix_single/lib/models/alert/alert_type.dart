enum AlertType {
  info,
  warning,
  error,
  success,
}

extension AlertTypeExtension on AlertType {
  static int get count => AlertType.values.length;
}
