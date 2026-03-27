import 'package:flutter/material.dart';

class AppColorScheme {
  static const lightColorScheme = ColorScheme(
    brightness: Brightness.light,
    primary: Color(0xFF216C2E),
    onPrimary: Color(0xFFFFFFFF),
    primaryContainer: Color(0xFFA7F5A7),
    onPrimaryContainer: Color(0xFF002106),
    secondary: Color(0xFF526350),
    onSecondary: Color(0xFFFFFFFF),
    secondaryContainer: Color(0xFFD5E8D0),
    onSecondaryContainer: Color(0xFF101F10),
    tertiary: Color(0xFF39656B),
    onTertiary: Color(0xFFFFFFFF),
    tertiaryContainer: Color(0xFFBCEBF2),
    onTertiaryContainer: Color(0xFF001F23),
    error: Color(0xFFBA1A1A),
    errorContainer: Color(0xFFFFDAD6),
    onError: Color(0xFFFFFFFF),
    onErrorContainer: Color(0xFF410002),
    background: Color.fromARGB(255, 237, 238, 231),
    onBackground: Color(0xFF1A1C19),
    surface: Color(0xFFFCFDF7),
    onSurface: Color(0xFF1A1C19),
    surfaceVariant: Color(0xFFDEE5D9),
    onSurfaceVariant: Color(0xFF424940),
    outline: Color(0xFF72796F),
    onInverseSurface: Color(0xFFF0F1EB),
    inverseSurface: Color(0xFF2F312D),
    inversePrimary: Color(0xFF8CD88D),
    shadow: Color(0xFF000000),
    surfaceTint: Color(0xFF216C2E),
    outlineVariant: Color(0xFFC2C9BD),
    scrim: Color(0xFF000000),
  );
  static const darkColorScheme = ColorScheme(
    brightness: Brightness.dark,

    secondary: Color(0xFFB9CCB4),
    onSecondary: Color(0xFF0F1F10),

    // PRIMARY (Button color)
    primary: Color(0xFFA3E635),
    onPrimary: Color(0xFF09090B),

    // BACKGROUND
    background: Color(0xFF09090B),
    onBackground: Color(0xFFFFFFFF),

    // SURFACE (cards, sheets)
    surface: Color(0xFF111827),
    onSurface: Color(0xFFFFFFFF),

    // VARIANTS
    surfaceVariant: Color(0xFF111827),
    onSurfaceVariant: Color(0xFF9CA3AF),

    outline: Color(0xFF374151),
    outlineVariant: Color(0xFF1F2937),

    // ERROR
    error: Color(0xFFEF4444),
    onError: Colors.white,
  );
}
