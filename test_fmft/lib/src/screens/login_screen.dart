import 'package:flutter/material.dart';
import '../widgets/auth_layout.dart';
import '../core/constants/app_colors.dart';
import '../widgets/custom_text_field.dart';
import '../widgets/gradient_button.dart';

class LoginScreen extends StatelessWidget {
  final VoidCallback onSendOtp;

  const LoginScreen({super.key, required this.onSendOtp});

  @override
  Widget build(BuildContext context) {
    return AuthLayout(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            'Sign In',
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.w800,
              color: AppColors.textHeading,
              letterSpacing: -0.5,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            'Enter your details to get started',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w400,
              color: AppColors.textBody,
            ),
          ),
          const SizedBox(height: 40),
          const CustomTextField(
            label: 'Email Address',
            hint: 'your@email.com',
            icon: Icons.alternate_email_rounded,
          ),
          const CustomTextField(
            label: 'Phone Number',
            hint: '+1 (555) 000-0000',
            icon: Icons.phone_iphone_rounded,
          ),
          const SizedBox(height: 12),
          GradientButton(
            text: 'Send Verification Code',
            onPressed: onSendOtp,
          ),
          const SizedBox(height: 40),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.shield_outlined, size: 18, color: AppColors.textPlaceholder),
              const SizedBox(width: 8),
              Flexible(
                child: Text(
                  "Secure verification via OTP",
                  style: TextStyle(
                    color: AppColors.textPlaceholder,
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
