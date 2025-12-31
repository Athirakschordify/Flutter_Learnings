import 'package:flutter/material.dart';
import '../../../../core/res/colors.dart';
import '../../../../core/res/styles.dart';
import '../widgets/custom_button.dart';
import '../widgets/auth_logo.dart';
import '../widgets/custom_back_button.dart';
import 'connect_email_page.dart';

class CreateAccountPage extends StatelessWidget {
  const CreateAccountPage({super.key});

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
          child: Stack(
            children: [
              // Back Button
              const Positioned(
                top: 10,
                left: 20,
                child: CustomBackButton(),
              ),
              SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24.0),
                  child: Column(
                    children: [
                      const SizedBox(height: 40),
                      const AuthLogo(),
                      const SizedBox(height: 40),
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
                        decoration: BoxDecoration(
                          color: AppColors.white,
                          borderRadius: BorderRadius.circular(30),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.1),
                              blurRadius: 20,
                              offset: const Offset(0, 10),
                            ),
                          ],
                        ),
                        child: Column(
                          children: [
                            const Text(
                              'Create Account',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: AppColors.magentaText,
                              ),
                            ),
                            const SizedBox(height: 8),
                            const Text(
                              'Tell us a bit about yourself',
                              style: TextStyle(
                                fontSize: 14,
                                color: AppColors.greyText,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            const SizedBox(height: 32),
                            const _LabelText(label: 'First Name'),
                            const SizedBox(height: 8),
                            TextField(
                              style: const TextStyle(fontSize: 16, color: Colors.black87),
                              decoration: AppStyles.inputDecoration.copyWith(
                                hintText: 'John',
                                prefixIcon: const Icon(Icons.person_outline, color: Color(0xFF00C6FF), size: 20),
                              ),
                            ),
                            const SizedBox(height: 20),
                            const _LabelText(label: 'Last Name'),
                            const SizedBox(height: 8),
                            TextField(
                              style: const TextStyle(fontSize: 16, color: Colors.black87),
                              decoration: AppStyles.inputDecoration.copyWith(
                                hintText: 'Doe',
                                prefixIcon: const Icon(Icons.person_outline, color: AppColors.magentaText, size: 20),
                              ),
                            ),
                            const SizedBox(height: 20),
                            const _LabelText(label: 'E-Mail'),
                            const SizedBox(height: 8),
                            TextField(
                              style: const TextStyle(fontSize: 16, color: Colors.black87),
                              decoration: AppStyles.inputDecoration.copyWith(
                                hintText: 'abc@gmail.com',
                                prefixIcon: const Icon(Icons.email_outlined, color: AppColors.magentaText, size: 20),
                              ),
                            ),
                            const SizedBox(height: 32),
                            CustomButton(
                              text: 'Create Account',
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const ConnectEmailPage(),
                                  ),
                                );
                              },
                            ),
                            const SizedBox(height: 24),
                            const Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  '✨ Join the ticketpouch community today',
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
                      const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.send_rounded,
                            size: 14,
                            color: Color(0xFFE99D43),
                          ),
                          SizedBox(width: 8),
                          Text(
                            "You're almost there!",
                            style: TextStyle(
                              color: AppColors.white,
                              fontSize: 14,
                              fontWeight: FontWeight.w300,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _LabelText extends StatelessWidget {
  final String label;
  const _LabelText({required this.label});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Text(
        label,
        style: const TextStyle(
          fontSize: 14,
          color: AppColors.greyText,
        ),
      ),
    );
  }
}
