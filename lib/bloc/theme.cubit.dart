import 'package:app_notes/models/theme.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

class ThemeCubit extends Cubit<ThemeData> {
  int _currentIndex = 0;

  ThemeCubit() : super(_buildThemeData(CustomTheme.themes[0]));

  void switchTheme() {
    _currentIndex = (_currentIndex + 1) % CustomTheme.themes.length;
    emit(_buildThemeData(CustomTheme.themes[_currentIndex]));
  }

  static ThemeData _buildThemeData(CustomTheme theme) {
    return ThemeData(
      primaryColor: theme.primaryColor,
      hintColor: theme.secondaryColor,
      canvasColor: theme.accentColor,
      scaffoldBackgroundColor: theme.primaryColor,
      textTheme: TextTheme(
        headlineSmall: TextStyle(
          color: theme.primaryColor,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
