import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'app_theme_modes.dart';

abstract class AppTheme {
  static Object themeOf(BuildContext context) {
    return Theme.of(context).brightness == Brightness.light
        ? LightModeTheme()
        : DarkModeTheme();
  }

  Color get containerColor => const Color(0xFF121212);

  Color get primaryColor;
  Color get onPrimary;
  Color get secondary;
  Color get onSecondary;
  Color get error;
  Color get onError;
  Color get surface;
  Color get onSurface;
  ColorScheme get colorScheme;

  TextStyle get header =>
      const TextStyle(fontSize: 18, fontWeight: FontWeight.bold);

  TextStyle get body =>
      const TextStyle(fontSize: 16, fontWeight: FontWeight.w400);
}
