enum ThemeEnum {
  dark,
  light,
}

extension ThemeEnumExtension on ThemeEnum {
  bool get isDark => this == ThemeEnum.dark;
  bool get isLight => this == ThemeEnum.light;
}
