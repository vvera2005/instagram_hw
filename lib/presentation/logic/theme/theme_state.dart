part of 'theme_cubit.dart';

sealed class ThemeModeState extends Equatable {
  const ThemeModeState(this.themeMode);

  final ThemeMode themeMode;

  @override
  List<Object> get props => [themeMode];
}

final class ThemeModeInitial extends ThemeModeState {
  const ThemeModeInitial() : super(ThemeMode.system);
}

final class ThemeModeUpdated extends ThemeModeState {
  const ThemeModeUpdated(super.themeMode);
}
