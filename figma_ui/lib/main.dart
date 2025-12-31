import 'package:flutter/material.dart';
import 'features/auth/presentation/pages/phone_login_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Figma UI Layout',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFFBD22E0)),
        useMaterial3: true,
        fontFamily: 'Roboto',
      ),
      home: const PhoneLoginPage(),
    );
  }
}
