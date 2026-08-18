import 'package:flutter/material.dart';
import 'package:crazy_block_online/theme/app_theme.dart';
import 'package:nowa_runtime/nowa_runtime.dart';

@NowaGenerated()
final ThemeData darkTheme = ThemeData(
  brightness: Brightness.dark,
  scaffoldBackgroundColor: AppTheme.bgDark,
  canvasColor: AppTheme.bgDark,
  splashColor: Colors.transparent,
  highlightColor: Colors.transparent,
  colorScheme: const ColorScheme.dark(
    primary: AppTheme.primaryBlue,
    secondary: AppTheme.accentGreen,
    surface: AppTheme.bgCardDark,
  ),
);

@NowaGenerated()
final ThemeData lightTheme = ThemeData(
  brightness: Brightness.light,
  scaffoldBackgroundColor: AppTheme.bgMid,
  canvasColor: AppTheme.bgDark,
  splashColor: Colors.transparent,
  highlightColor: Colors.transparent,
  colorScheme: const ColorScheme.light(
    primary: AppTheme.primaryBlue,
    secondary: AppTheme.accentGreen,
    surface: AppTheme.bgCardDark,
  ),
);
