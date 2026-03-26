import 'package:flutter/material.dart';

import '../models/app_enums.dart';

class AppGradients {
  static const _ocean = [Color(0xFF00BFA5), Color(0xFF1976D2)];
  static const _emerald = [Color(0xFF2ECC71), Color(0xFF1ABC9C)];
  static const _tealNight = [Color(0xFF00A896), Color(0xFF05668D)];

  static List<Color> fromVariant(ThemeVariant variant) {
    switch (variant) {
      case ThemeVariant.ocean:
        return _ocean;
      case ThemeVariant.emerald:
        return _emerald;
      case ThemeVariant.tealNight:
        return _tealNight;
    }
  }

  static LinearGradient build(ThemeVariant variant) => LinearGradient(
        colors: fromVariant(variant),
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      );
}
