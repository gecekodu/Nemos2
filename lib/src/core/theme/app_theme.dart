import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData dark() {
    const surface = Color(0xFF101828);
    const card = Color(0xFF162033);
    const accent = Color(0xFF8B5CF6);
    const secondary = Color(0xFF22D3EE);
    const background = Color(0xFF09111F);

    final scheme = ColorScheme.fromSeed(
      seedColor: accent,
      brightness: Brightness.dark,
    ).copyWith(
      primary: accent,
      secondary: secondary,
      surface: surface,
    );

    return ThemeData(
      useMaterial3: true,
      colorScheme: scheme,
      scaffoldBackgroundColor: background,
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.white,
        elevation: 0,
        centerTitle: false,
      ),
      cardTheme: CardThemeData(
        color: card,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
        ),
      ),
      textTheme: const TextTheme(
        headlineMedium: TextStyle(
          fontSize: 28,
          fontWeight: FontWeight.w800,
          color: Colors.white,
        ),
        titleLarge: TextStyle(
          fontSize: 22,
          fontWeight: FontWeight.w700,
          color: Colors.white,
        ),
        titleMedium: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w700,
          color: Colors.white,
        ),
        bodyLarge: TextStyle(
          fontSize: 15,
          height: 1.5,
          color: Color(0xFFD0D8E8),
        ),
        bodyMedium: TextStyle(
          fontSize: 13,
          height: 1.4,
          color: Color(0xFF98A2B3),
        ),
      ),
      chipTheme: ChipThemeData(
        backgroundColor: const Color(0xFF1C2740),
        selectedColor: accent,
        disabledColor: const Color(0xFF1C2740),
        side: BorderSide.none,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(40),
        ),
        labelStyle: const TextStyle(color: Colors.white),
      ),
    );
  }
}
