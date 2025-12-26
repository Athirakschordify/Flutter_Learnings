import 'package:flutter/material.dart';
import '../widgets/auth_layout.dart';
import '../core/constants/app_colors.dart';
import '../widgets/custom_text_field.dart';
import '../widgets/gradient_button.dart';

class CreateAccountScreen extends StatelessWidget {
  final VoidCallback onBack;
  final VoidCallback onCreate;

  const CreateAccountScreen({
    super.key,
    required this.onBack,
    required this.onCreate,
  });

  @override
  Widget build(BuildContext context) {
    return AuthLayout(
      showBackButton: true,
      onBack: onBack,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            'Create Account',
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.w800,
              color: AppColors.textHeading,
              letterSpacing: -0.5,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            'Tell us a bit about yourself to get started',
            textAlign: TextAlign.center,
            style: TextStyle(color: AppColors.textBody, fontSize: 15),
          ),
          const SizedBox(height: 32),
          const CustomTextField(
            label: 'First Name',
            hint: 'John',
            icon: Icons.person_outline_rounded,
          ),
          const CustomTextField(
            label: 'Last Name',
            hint: 'Doe',
            icon: Icons.person_outline_rounded,
          ),
          const CustomTextField(
            label: 'Location',
            hint: 'New York, USA',
            icon: Icons.location_on_outlined,
          ),
          const SizedBox(height: 12),
          GradientButton(
            text: 'Finish Registration',
            onPressed: onCreate,
          ),
          const SizedBox(height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.stars_rounded, color: Colors.amber[600], size: 18),
              const SizedBox(width: 8),
              Flexible(
                child: Text(
                  'Join thousands of happy ticket holders',
                  style: TextStyle(color: AppColors.textPlaceholder, fontSize: 13, fontWeight: FontWeight.w500),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
