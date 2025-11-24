import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  static ColorScheme get _lightColors => const ColorScheme(
        brightness: Brightness.light,
        primary: Color(0xFFFF7043),
        onPrimary: Colors.white,
        secondary: Color(0xFF4CAF50),
        onSecondary: Colors.white,
        error: Color(0xFFE53935),
        onError: Colors.white,
        background: Color(0xFFFDF8F4),
        onBackground: Color(0xFF1C1C1C),
        surface: Colors.white,
        onSurface: Color(0xFF222222),
      );

  static ColorScheme get _darkColors => const ColorScheme(
        brightness: Brightness.dark,
        primary: Color(0xFFFF8A65),
        onPrimary: Colors.black,
        secondary: Color(0xFF81C784),
        onSecondary: Colors.black,
        error: Color(0xFFFF867C),
        onError: Colors.black,
        background: Color(0xFF121212),
        onBackground: Colors.white,
        surface: Color(0xFF1F1F1F),
        onSurface: Colors.white,
      );

  static ThemeData get light => ThemeData(
        colorScheme: _lightColors,
        useMaterial3: true,
        textTheme: GoogleFonts.interTextTheme().copyWith(
          titleLarge: GoogleFonts.inter(fontWeight: FontWeight.w600),
        ),
        appBarTheme: const AppBarTheme(
          elevation: 0,
          backgroundColor: Colors.transparent,
          foregroundColor: Color(0xFF1C1C1C),
        ),
        scaffoldBackgroundColor: _lightColors.background,
        chipTheme: ChipThemeData(
          backgroundColor: _lightColors.secondary.withOpacity(.1),
          labelStyle: TextStyle(color: _lightColors.onBackground),
        ),
      );

  static ThemeData get dark => ThemeData(
        colorScheme: _darkColors,
        useMaterial3: true,
        textTheme: GoogleFonts.interTextTheme(ThemeData.dark().textTheme),
        appBarTheme: const AppBarTheme(
          elevation: 0,
          backgroundColor: Colors.transparent,
          foregroundColor: Colors.white,
        ),
        scaffoldBackgroundColor: _darkColors.background,
        chipTheme: ChipThemeData(
          backgroundColor: _darkColors.secondary.withOpacity(.2),
          labelStyle: TextStyle(color: _darkColors.onBackground),
        ),
      );
}

