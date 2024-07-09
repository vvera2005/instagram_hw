import 'package:flutter/material.dart';

import 'app_theme_modes.dart';

class AppThemeData {
  AppThemeData({required this.context});

  final BuildContext context;

  ThemeData get lighTheme => ThemeData(
        colorScheme: LightModeTheme().colorScheme,
        appBarTheme:
            const AppBarTheme(backgroundColor: Color.fromARGB(255, 0, 0, 0)),
        useMaterial3: true,
      );

  ThemeData get darkTheme => ThemeData(
        colorScheme: DarkModeTheme().colorScheme,
        
        appBarTheme:
            const AppBarTheme(backgroundColor: Color.fromARGB(255, 0, 0, 0)),
        useMaterial3: true,
      );
}
