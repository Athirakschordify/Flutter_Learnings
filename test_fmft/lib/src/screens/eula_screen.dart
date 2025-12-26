import 'package:flutter/material.dart';
import '../widgets/auth_layout.dart';
import '../core/constants/app_colors.dart';
import '../widgets/gradient_button.dart';

class EulaScreen extends StatefulWidget {
  final VoidCallback onBack;
  final VoidCallback onAgree;

  const EulaScreen({
    super.key,
    required this.onBack,
    required this.onAgree,
  });

  @override
  State<EulaScreen> createState() => _EulaScreenState();
}

class _EulaScreenState extends State<EulaScreen> {
  bool isAgreed = false;

  @override
  Widget build(BuildContext context) {
    return AuthLayout(
      showBackButton: true,
      onBack: widget.onBack,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.description_rounded, color: AppColors.primary, size: 28),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  'End User License Agreement',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w800,
                    color: AppColors.textHeading,
                    letterSpacing: -0.5,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            'Last updated: December 17, 2024',
            style: TextStyle(color: AppColors.textPlaceholder, fontSize: 13, fontWeight: FontWeight.w500),
          ),
          const SizedBox(height: 24),
          Container(
            height: 300,
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: AppColors.inputBackground,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: AppColors.border),
            ),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'By using FMFT app, you agree to the terms below.',
                    style: TextStyle(color: AppColors.textBody, fontSize: 14, height: 1.6, fontWeight: FontWeight.w500),
                  ),
                  const SizedBox(height: 24),
                  _buildSection(
                    '1. App Use',
                    'You are granted a limited, non-exclusive license to use the app for personal purposes in accordance with these terms.',
                  ),
                  _buildSection(
                    '2. Email Access & Ticket Data',
                    'If you enable email access, the app may scan your email only to identify ticket confirmation information such as event name, date, venue, and attachments.',
                  ),
                  const SizedBox(height: 8),
                  _buildBulletPoint('Personal or unrelated emails are not read'),
                  _buildBulletPoint('Only ticket-related data is processed'),
                  _buildBulletPoint('Email access can be revoked anytime from Settings'),
                  const SizedBox(height: 16),
                  _buildSection(
                    '3. User Consent',
                    'By continuing, you consent to the collection and processing of ticket-related data solely to provide app functionality. You may withdraw consent at any time.',
                  ),
                  _buildSection(
                    '4. Data & Privacy',
                    'Your data is handled securely and in accordance with our Privacy Policy.',
                  ),
                  const SizedBox(height: 8),
                  GestureDetector(
                    onTap: () {
                      // Open privacy policy
                    },
                    child: Text(
                      'View Privacy Policy',
                      style: TextStyle(
                        color: AppColors.primary,
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  _buildSection(
                    '5. Third-Party Services',
                    'The app may connect with third-party services (email, calendar). Their terms and policies apply.',
                  ),
                  _buildSection(
                    '6. Updates',
                    'We may update these terms. Continued use means acceptance of changes.',
                  ),
                  _buildSection(
                    '7. Contact',
                    'Questions? Contact us at support@fmfticket.com',
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 24),
          Row(
            children: [
              SizedBox(
                height: 24,
                width: 24,
                child: Checkbox(
                  value: isAgreed,
                  onChanged: (val) => setState(() => isAgreed = val ?? false),
                  activeColor: AppColors.primary,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  'I agree to the EULA and Privacy Policy and consent to email scanning for ticket detection.',
                  style: TextStyle(color: AppColors.textBody, fontSize: 13, fontWeight: FontWeight.w500, height: 1.4),
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          GradientButton(
            text: 'Accept & Continue',
            onPressed: isAgreed ? widget.onAgree : () {},
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.lock_outline, size: 14, color: AppColors.textPlaceholder),
              const SizedBox(width: 6),
              Text(
                'Your privacy and security are our priority',
                style: TextStyle(
                  color: AppColors.textPlaceholder,
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSection(String title, String content) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w700,
              color: AppColors.textHeading,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            content,
            style: TextStyle(
              color: AppColors.textBody,
              fontSize: 13,
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBulletPoint(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6.0, left: 16.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('• ', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: AppColors.textBody)),
          Expanded(
            child: Text(
              text,
              style: TextStyle(color: AppColors.textBody, fontSize: 13, height: 1.5),
            ),
          ),
        ],
      ),
    );
  }
}
