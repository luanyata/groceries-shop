import 'package:flutter/material.dart';

class ColorUtils {
  // Método estático para converter string em Color
  static Color getColorFromString(String colorString) {
    switch (colorString.toLowerCase()) {
      case 'green':
        return Colors.green;
      case 'yellow':
        return Colors.yellow;
      case 'red':
        return Colors.red;
      case 'purple':
        return Colors.purple;
      case 'blue':
        return Colors.blue;
      case 'orange':
        return Colors.orange;
      default:
        return Colors.grey;
    }
  }

  // Você pode adicionar outras funções relacionadas a cores aqui
  static Color lighten(Color color, [double amount = 0.1]) {
    assert(amount >= 0 && amount <= 1);
    final hsl = HSLColor.fromColor(color);
    final lightness = (hsl.lightness + amount).clamp(0.0, 1.0);
    return hsl.withLightness(lightness).toColor();
  }

  static Color darken(Color color, [double amount = 0.1]) {
    assert(amount >= 0 && amount <= 1);
    final hsl = HSLColor.fromColor(color);
    final lightness = (hsl.lightness - amount).clamp(0.0, 1.0);
    return hsl.withLightness(lightness).toColor();
  }
}
