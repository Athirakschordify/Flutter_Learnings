import 'package:flutter/material.dart';
import '../core/constants/app_colors.dart';

class CustomTextField extends StatelessWidget {
  final String label;
  final String hint;
  final IconData icon;
  final Color? iconColor;

  const CustomTextField({
    super.key,
    required this.label,
    required this.hint,
    required this.icon,
    this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: AppColors.textHeading,
            letterSpacing: 0.2,
          ),
        ),
        const SizedBox(height: 10),
        TextField(
          style: const TextStyle(color: AppColors.textHeading, fontSize: 16),
          decoration: InputDecoration(
            hintText: hint,
            prefixIcon: Icon(icon, color: iconColor ?? AppColors.textBody, size: 22),
          ),
        ),
        const SizedBox(height: 24),
      ],
    );
  }
}
