import 'dart:ui';

class AppColors {
  static const Color mainColor = Color(0xff212121);
  static const Color darkText = Color(0xffd8d8d8);
  static const Color lightText = Color(0xff9e9e9e);

  static getTextColor(bool isDark) => isDark ? darkText : lightText;
}
