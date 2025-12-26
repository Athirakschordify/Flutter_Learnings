import 'package:flutter/material.dart';
import '../widgets/auth_layout.dart';
import '../core/constants/app_colors.dart';
import '../widgets/gradient_button.dart';

class VerifyOtpScreen extends StatefulWidget {
  final VoidCallback onBack;
  final VoidCallback onContinue;

  const VerifyOtpScreen({
    super.key,
    required this.onBack,
    required this.onContinue,
  });

  @override
  State<VerifyOtpScreen> createState() => _VerifyOtpScreenState();
}

class _VerifyOtpScreenState extends State<VerifyOtpScreen> {
  bool isEmailSelected = true;

  @override
  Widget build(BuildContext context) {
    return AuthLayout(
      showBackButton: true,
      onBack: widget.onBack,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            'Verification Code',
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.w800,
              color: AppColors.textHeading,
              letterSpacing: -0.5,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            "We've sent a code to your chosen method",
            textAlign: TextAlign.center,
            style: TextStyle(color: AppColors.textBody, fontSize: 15),
          ),
          const SizedBox(height: 40),
          Row(
            children: [
              Expanded(
                child: _buildMethodButton(
                  icon: Icons.mail_rounded,
                  label: 'Email',
                  isSelected: isEmailSelected,
                  onTap: () => setState(() => isEmailSelected = true),
                  color: AppColors.primary,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _buildMethodButton(
                  icon: Icons.smartphone_rounded,
                  label: 'Mobile',
                  isSelected: !isEmailSelected,
                  onTap: () => setState(() => isEmailSelected = false),
                  color: AppColors.primary,
                ),
              ),
            ],
          ),
          const SizedBox(height: 40),
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              'Enter 6-digit code',
              style: TextStyle(color: AppColors.textHeading, fontSize: 14, fontWeight: FontWeight.w600),
            ),
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: List.generate(6, (index) => _buildOtpBox()),
          ),
          const SizedBox(height: 40),
          GradientButton(
            text: 'Verify & Continue',
            onPressed: widget.onContinue,
          ),
          const SizedBox(height: 32),
          Text(
            "Didn't receive the code?",
            style: TextStyle(color: AppColors.textBody, fontSize: 14),
          ),
          TextButton(
            onPressed: () {},
            child: const Text(
              'Resend New Code',
              style: TextStyle(
                color: AppColors.primary,
                fontWeight: FontWeight.w700,
                fontSize: 14,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMethodButton({
    required IconData icon,
    required String label,
    required bool isSelected,
    required VoidCallback onTap,
    required Color color,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          border: Border.all(
            color: isSelected ? color : Colors.grey[300]!,
            width: 2,
          ),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: color, size: 20),
            const SizedBox(width: 8),
            Text(
              isSelected ? '$label ✓' : label,
              style: TextStyle(
                color: isSelected ? color : Colors.grey[600],
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildOtpBox() {
    return Container(
      width: 45,
      height: 60,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey[300]!),
        borderRadius: BorderRadius.circular(12),
      ),
      child: const Center(
        child: TextField(
          textAlign: TextAlign.center,
          keyboardType: TextInputType.number,
          maxLength: 1,
          decoration: InputDecoration(
            counterText: "",
            border: InputBorder.none,
            enabledBorder: InputBorder.none,
            focusedBorder: InputBorder.none,
          ),
        ),
      ),
    );
  }
}
