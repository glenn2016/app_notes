import 'package:app_notes/widgets/utils.colors.dart';
import 'package:flutter/material.dart';

class CustomTheme {
  final String name;
  final Color primaryColor;
  final Color secondaryColor;
  final Color accentColor;

  CustomTheme({
    required this.name,
    required this.primaryColor,
    required this.secondaryColor,
    required this.accentColor,
  });

  static final List<CustomTheme> themes = [
    CustomTheme(
      name: 'Theme 1',
      primaryColor: hexStringToColor("FFFFF"),
      secondaryColor: hexStringToColor("FFFFF"),
      accentColor: hexStringToColor("FFFFF"),
    ),
    CustomTheme(
      name: 'Theme 2',
      primaryColor: hexStringToColor("00000"),
      secondaryColor: hexStringToColor("00000"),
      accentColor: hexStringToColor("00000"),
    ),
   
  ];
}
