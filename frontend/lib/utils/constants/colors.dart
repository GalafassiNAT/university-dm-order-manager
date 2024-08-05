import 'package:flutter/material.dart';

class MyColors {
  MyColors._();

  static const Color primary = Color(0xFF4B68FF);
  static const Color secundary = Color(0xFFFFE24B);
  static const Color accent = Color(0xFFB0C7FF);

  static const Gradient linearGradient = LinearGradient(
    begin: Alignment(0, 0),
    end: Alignment(0.707, -0.707),
    colors: [
      Color(0xffff9a9e),
      Color(0xfffad0c4),
      Color(0xfffad0c4),
    ]
  );

  static const Color textPrimary = Color(0xFF333333);
  static const Color textSecundary = Color(0xFF6c757d);
  static const Color textWhite = Colors.white;

  static const Color light = Color(0xFFF6F6F6);
  static const Color dark = Color(0xFF272727);
  static const Color primaryBackground = Color(0xFFF3F5FF);

  static const Color lightContainer = Color(0xFFF6F6F6);
  static Color darkContainer = MyColors.white.withOpacity(0.1);

  static const Color buttonPrimary = Color(0xFF4B68FF);
  static const Color buttonSecundary = Color(0xFF6c757d);
  static const Color buttonDisabled = Color(0xFFc4c4c4);

  static const Color borderPrimary = Color(0xFFd9d9d9);
  static const Color borderSecundary = Color(0xFFe6e6e6);

  static const Color error = Color(0xFFd32f2f);
  static const Color success = Color(0xFF388e3c);
  static const Color warning = Color(0xFFf57c00);
  static const Color info = Color(0xFF1976d2);

  static const Color black = Color(0xFF232323);
  static const Color darkerGrey = Color(0xFF4f4f4f);
  static const Color darkGrey = Color(0xFF939393);
  static const Color grey = Color(0xFFe0e0e0);
  static const Color softGrey = Color(0xFFf4f4f4);
  static const Color lightGrey = Color(0xFFf9f9f9);
  static const Color white = Color(0xFFffffff);
}