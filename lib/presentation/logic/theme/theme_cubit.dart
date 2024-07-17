import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

part 'theme_state.dart';

class ThemeModeCubit extends Cubit<ThemeModeState> {
  ThemeModeCubit() : super(const ThemeModeInitial());

  void updateTheme(ThemeMode mode) => emit(ThemeModeUpdated(mode));
}
