import 'package:flutter/material.dart';
import '../../../../core/res/colors.dart';
import '../../../../core/res/styles.dart';
import '../widgets/custom_button.dart';
import '../widgets/auth_logo.dart';
import 'otp_verification_page.dart';

class PhoneLoginPage extends StatelessWidget {
  const PhoneLoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: AppColors.backgroundGradient,
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Column(
                children: [
                  const SizedBox(height: 50),
                  const AuthLogo(),
                  const SizedBox(height: 50),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
                    decoration: BoxDecoration(
                      color: AppColors.white,
                      borderRadius: BorderRadius.circular(24),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.08),
                          blurRadius: 20,
                          offset: const Offset(0, 10),
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        const Text(
                          'Enter your details to get started',
                          style: TextStyle(
                            fontSize: 14,
                            color: AppColors.greyText,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        const SizedBox(height: 32),
                        const Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'Phone Number',
                            style: TextStyle(
                              fontSize: 14,
                              color: AppColors.greyText,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        const SizedBox(height: 8),
                        TextField(
                          keyboardType: TextInputType.phone,
                          style: const TextStyle(fontSize: 16, color: Colors.black87),
                          decoration: AppStyles.inputDecoration.copyWith(
                            hintText: '+1 (555) 000-0000',
                            prefixIcon: const Icon(
                              Icons.phone_outlined,
                              color: Color(0xFF00C6FF),
                              size: 20,
                            ),
                          ),
                        ),
                        const SizedBox(height: 32),
                        CustomButton(
                          text: 'Send Verification Code',
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const OtpVerificationPage(),
                              ),
                            );
                          },
                        ),
                        const SizedBox(height: 24),
                        const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.lock_outline,
                              size: 14,
                              color: Color(0xFFC5B422),
                            ),
                            SizedBox(width: 6),
                            Text(
                              "We'll send you a secure verification code",
                              style: TextStyle(
                                fontSize: 12,
                                color: AppColors.greyText,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 50),
                  const Text(
                    'Secure and fast authentication',
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 14,
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
