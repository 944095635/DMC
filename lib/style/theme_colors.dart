import 'package:flutter/material.dart';

class ThemeColors extends ThemeExtension<ThemeColors> {
  const ThemeColors({
    required this.textColor,
  });

  final Color textColor;

  static const TextStyle whiteStyle = TextStyle(
    color: Colors.white,
    shadows: [
      BoxShadow(
        blurRadius: 1,
        offset: Offset(1, 1),
        color: Colors.black,
      )
    ],
  );

  //白色主题
  static const light = ThemeColors(
    textColor: Color(0xFF000000), //文字 黑色
  );

  // 黑色主题
  static const dark = ThemeColors(
    textColor: Color(0xff00bc8c), //文字 白色
  );

  @override
  ThemeExtension<ThemeColors> copyWith() {
    return this;
  }

  @override
  ThemeExtension<ThemeColors> lerp(
      covariant ThemeExtension<ThemeColors>? other, double t) {
    return this;
  }
}

class ThemeColor {
  /* 毛玻璃的颜色 */
  static const Color glassColor = Color.fromARGB(200, 255, 255, 255);
}
