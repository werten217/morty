import 'package:flutter/material.dart';

class AppColors {
  static const Color primary = Color(0xFF00B5CC);
  static const Color background = Color(0xFFF5F5F5);
  static const Color textPrimary = Colors.black87;
  static const Color textSecondary = Colors.grey;
}

class AppTextStyles {
  static const TextStyle title = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w700,
    color: AppColors.textPrimary,
  );

  static const TextStyle subtitle = TextStyle(
    fontSize: 13,
    color: AppColors.textSecondary,
  );
}
