import 'package:flutter/material.dart';

class AppColors {
  static const Color bgBottom = Color(0xFF00357A);
  static const Color bgMid = Color(0xFFEB008B);
  static const Color bgTop = Color(0xFF05A8EB);

  static const Color primaryButtonStart = Color(0xFF1F92F3);
  static const Color primaryButtonEnd = Color(0xFFB131E1);

  static const Color magentaText = Color(0xFFD32A7D);
  static const Color logoBlue = Color(0xFF0000FF);
  static const Color white = Color(0xFFFFFFFF);
  static const Color greyText = Color(0xFF7B7B7B);
  static const Color blackText = Color(0xFF333333);
  static const Color inputBorder = Color(0xFFE0E0E0);
  
  static const LinearGradient backgroundGradient = LinearGradient(
    begin: Alignment.bottomCenter,
    end: Alignment.topCenter,
    colors: [bgBottom, bgMid, bgTop],
    stops: [0.0, 0.4935, 0.9894],
  );

  static const LinearGradient buttonGradient = LinearGradient(
    begin: Alignment.centerRight,
    end: Alignment.centerLeft,
    colors: [
      Color(0xFF9B43E2),
      Color(0xFFEB008B),
      Color(0xFF05A8EB),
    ],
    stops: [0.0177, 0.5246, 0.9993],
  );
}
