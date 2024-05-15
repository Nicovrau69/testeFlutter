class StringUtils {
  static bool isBlank(String? text) {
    return text == null || text.trim().isEmpty;
  }
}
