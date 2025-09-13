import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'app_theme_state.dart';

class AppThemeCubit extends Cubit<AppThemeState> {
  AppThemeCubit() : super(AppThemeState(_lightTheme)); // default theme

  static final ThemeData _lightTheme = ThemeData.light().copyWith(
    primaryColor: Colors.blue,
    scaffoldBackgroundColor: Colors.white,
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.blue,
      foregroundColor: Colors.white,
    ),
  );

  static final ThemeData _darkTheme = ThemeData.dark().copyWith(
    primaryColor: Colors.deepPurple,
    scaffoldBackgroundColor: Colors.black,
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.black,
      foregroundColor: Colors.white,
    ),
  );

  bool get isDark => state.themeData.brightness == Brightness.dark;

  get containerColor => isDark ? Colors.red : Colors.grey;

  void toggleTheme() {
    emit(AppThemeState(isDark ? _lightTheme : _darkTheme));
  }
}
