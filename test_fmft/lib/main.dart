import 'package:flutter/material.dart';
import 'src/core/constants/app_theme.dart';
import 'src/screens/login_screen.dart';
import 'src/screens/verify_otp_screen.dart';
import 'src/screens/create_account_screen.dart';
import 'src/screens/eula_screen.dart';
import 'src/screens/welcome_screen.dart';
import 'src/screens/home_screen.dart';
import 'src/screens/main_screen.dart';

void main() {
  runApp(const FMFTApp());
}

class FMFTApp extends StatelessWidget {
  const FMFTApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FMFT App',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      home: const MainNavigation(),
    );
  }
}

class MainNavigation extends StatefulWidget {
  const MainNavigation({super.key});

  @override
  State<MainNavigation> createState() => _MainNavigationState();
}

class _MainNavigationState extends State<MainNavigation> {
  int _currentIndex = 5;

  void _next() {
    setState(() {
      if (_currentIndex < 5) _currentIndex++;
    });
  }

  void _back() {
    setState(() {
      if (_currentIndex > 0) _currentIndex--;
    });
  }

  void _logout() {
    setState(() {
      _currentIndex = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    switch (_currentIndex) {
      case 0:
        return LoginScreen(onSendOtp: _next);
      case 1:
        return VerifyOtpScreen(onBack: _back, onContinue: _next);
      case 2:
        return CreateAccountScreen(onBack: _back, onCreate: _next);
      case 3:
        return EulaScreen(onBack: _back, onAgree: _next);
      case 4:
        return WelcomeScreen(onGetStarted: _next);
      case 5:
        return MainScreen(onLogout: _logout);
      default:
        return LoginScreen(onSendOtp: _next);
    }
  }
}
