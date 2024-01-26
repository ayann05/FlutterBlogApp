import 'package:flutter/material.dart';

abstract class myCustomTheme {
  static const lightColorScheme = ColorScheme(
    brightness: Brightness.light,
    primary: Color(0xFF9F4208),
    onPrimary: Color(0xFFFFFFFF),
    primaryContainer: Color(0xFFFFDBCC),
    onPrimaryContainer: Color(0xFF351000),
    secondary: Color(0xFF765749),
    onSecondary: Color(0xFFFFFFFF),
    secondaryContainer: Color(0xFFFFDBCC),
    onSecondaryContainer: Color(0xFF2C160B),
    tertiary: Color(0xFF665F31),
    onTertiary: Color(0xFFFFFFFF),
    tertiaryContainer: Color(0xFFEDE4A9),
    onTertiaryContainer: Color(0xFF201C00),
    error: Color(0xFFBA1A1A),
    errorContainer: Color(0xFFFFDAD6),
    onError: Color(0xFFFFFFFF),
    onErrorContainer: Color(0xFF410002),
    background: Color(0xFFFFFBFF),
    onBackground: Color(0xFF201A18),
    surface: Color(0xFFFFFBFF),
    onSurface: Color(0xFF201A18),
    surfaceVariant: Color(0xFFF4DED5),
    onSurfaceVariant: Color(0xFF52443D),
    outline: Color(0xFF85736C),
    onInverseSurface: Color(0xFFFBEEE9),
    inverseSurface: Color(0xFF362F2C),
    inversePrimary: Color(0xFFFFB694),
    shadow: Color(0xFF000000),
    surfaceTint: Color(0xFF9F4208),
    outlineVariant: Color(0xFFD7C2BA),
    scrim: Color(0xFF000000),
  );

  static const darkColorScheme = ColorScheme(
    brightness: Brightness.dark,
    primary: Color(0xFFFFB694),
    onPrimary: Color(0xFF571F00),
    primaryContainer: Color(0xFF7B2F00),
    onPrimaryContainer: Color(0xFFFFDBCC),
    secondary: Color(0xFFE6BEAD),
    onSecondary: Color(0xFF442A1E),
    secondaryContainer: Color(0xFF5C4033),
    onSecondaryContainer: Color(0xFFFFDBCC),
    tertiary: Color(0xFFD1C88F),
    onTertiary: Color(0xFF363107),
    tertiaryContainer: Color(0xFF4D471C),
    onTertiaryContainer: Color(0xFFEDE4A9),
    error: Color(0xFFFFB4AB),
    errorContainer: Color(0xFF93000A),
    onError: Color(0xFF690005),
    onErrorContainer: Color(0xFFFFDAD6),
    background: Color(0xFF201A18),
    onBackground: Color(0xFFEDE0DB),
    surface: Color(0xFF201A18),
    onSurface: Color(0xFFEDE0DB),
    surfaceVariant: Color(0xFF52443D),
    onSurfaceVariant: Color(0xFFD7C2BA),
    outline: Color(0xFFA08D85),
    onInverseSurface: Color(0xFF201A18),
    inverseSurface: Color(0xFFEDE0DB),
    inversePrimary: Color(0xFF9F4208),
    shadow: Color(0xFF000000),
    surfaceTint: Color(0xFFFFB694),
    outlineVariant: Color(0xFF52443D),
    scrim: Color(0xFF000000),
  );
}
