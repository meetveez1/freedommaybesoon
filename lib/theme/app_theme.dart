import 'package:flutter/material.dart';

import '../models/app_enums.dart';
import 'app_gradients.dart';

class AppTheme {
  static ThemeData light(ThemeVariant variant) {
    final colors = AppGradients.fromVariant(variant);
    return ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(seedColor: colors.first, brightness: Brightness.light),
      scaffoldBackgroundColor: const Color(0xFFF4F8FB),
      cardTheme: CardThemeData(
        elevation: 3,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(16), borderSide: BorderSide.none),
      ),
    );
  }

  static ThemeData dark(ThemeVariant variant) {
    final colors = AppGradients.fromVariant(variant);
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      colorScheme: ColorScheme.fromSeed(seedColor: colors.last, brightness: Brightness.dark),
      cardTheme: CardThemeData(
        color: const Color(0xFF1A1F2E),
        elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: const Color(0xFF232A3A),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(16), borderSide: BorderSide.none),
      ),
    );
  }
}
