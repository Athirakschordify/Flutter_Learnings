import 'package:flutter/material.dart';

class AppColors {
  // Primary Palette (Vibrant Theme)
  static const Color primary = Color(0xFF0000FF);            // Vibrant Blue
  static const Color accent = Color(0xFFFF0090);             // Vibrant Magenta
  static const Color secondary = Color(0xFF000080);          // Deep Blue
  
  // Neutral Colors
  static const Color background = Color(0xFF00B4FF);         // Cyan (Top)
  static const Color surface = Colors.white;
  static const Color textHeading = Color(0xFF000080);        // Deep Blue
  static const Color textBody = Color(0xFF475569);           // Slate 600
  static const Color textPlaceholder = Color(0xFF94A3B8);    // Slate 400
  
  // UI Elements
  static const Color border = Color(0xFFE2E8F0);             // Slate 200
  static const Color inputBackground = Color(0xFFF1F5F9);    // Slate 100
  
  // Functional Colors
  static const Color success = Color(0xFF10B981);            // Emerald 500
  static const Color error = Color(0xFFEF4444);              // Red 500
  
  // Gradients (Vibrant / Screenshot Match)
  static const List<Color> mainGradient = [
    Color(0xFF0000FF), // Blue
    Color(0xFFFF0090), // Magenta
  ];

  static const List<Color> backgroundGradient = [
    Color(0xFF00B4FF), // Cyan Top
    Color(0xFFFF0090), // Magenta Middle
    Color(0xFF000080), // Deep Blue Bottom
  ];

  // Backward compatibility
  static const Color primaryGradientStart = primary;
  static const Color primaryGradientEnd = secondary;
  static const Color textAccent = primary;
}
