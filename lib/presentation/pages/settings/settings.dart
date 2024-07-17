import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../logic/theme/theme_cubit.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: Row(
        children: [
          const SizedBox(
            height: 150,
          ),
          IconButton(
              onPressed: () {
                context.read<ThemeModeCubit>().updateTheme(
                    isDarkMode(context) ? ThemeMode.light : ThemeMode.dark);
              },
              icon: Icon(
                  isDarkMode(context) ? Icons.light_mode : Icons.dark_mode)),
        ],
      ),
    ));
  }

  bool isDarkMode(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark;
  }
}
