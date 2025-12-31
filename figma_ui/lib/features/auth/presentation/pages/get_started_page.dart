import 'dart:math';
import 'package:flutter/material.dart';
import '../../../../core/res/colors.dart';
import '../widgets/auth_logo.dart';

class GetStartedPage extends StatefulWidget {
  const GetStartedPage({super.key});

  @override
  State<GetStartedPage> createState() => _GetStartedPageState();
}

class _GetStartedPageState extends State<GetStartedPage> with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 10),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            width: double.infinity,
            height: double.infinity,
            decoration: const BoxDecoration(
              gradient: AppColors.backgroundGradient,
            ),
          ),
          MovingStarsBackground(controller: _controller),
          SafeArea(
            child: Column(
              children: [
                const SizedBox(height: 60),
                const AuthLogo(),
                const Spacer(),
                TweenAnimationBuilder<double>(
                  tween: Tween(begin: 0.0, end: 1.0),
                  duration: const Duration(milliseconds: 800),
                  builder: (context, value, child) {
                    return Opacity(
                      opacity: value,
                      child: Transform.translate(
                        offset: Offset(0, 20 * (1 - value)),
                        child: child,
                      ),
                    );
                  },
                  child: const Column(
                    children: [
                      Text(
                        'Hi! 👋',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: AppColors.white,
                          letterSpacing: 1.1,
                        ),
                      ),
                      SizedBox(height: 12),
                      Text(
                        "You're all set to begin your journey",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 15,
                          color: Colors.white70,
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 60),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 40.0),
                  child: TweenAnimationBuilder<double>(
                    tween: Tween(begin: 0.0, end: 1.0),
                    duration: const Duration(milliseconds: 1000),
                    curve: Curves.elasticOut,
                    builder: (context, value, child) {
                      return Transform.scale(
                        scale: value,
                        child: Container(
                          width: double.infinity,
                          height: 55,
                          decoration: BoxDecoration(
                            color: AppColors.white,
                            borderRadius: BorderRadius.circular(12),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.15),
                                blurRadius: 15,
                                offset: const Offset(0, 8),
                              ),
                            ],
                          ),
                          child: TextButton(
                            onPressed: () {
                              // Navigate to Home or Dashboard
                            },
                            child: ShaderMask(
                              shaderCallback: (bounds) => AppColors.buttonGradient.createShader(
                                Rect.fromLTWH(0, 0, bounds.width, bounds.height),
                              ),
                              child: const Text(
                                'Get Started',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white, // Color is overridden by ShaderMask
                                ),
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
                const Spacer(),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.lock_outline,
                      size: 14,
                      color: Color(0xFFC5B422),
                    ),
                    SizedBox(width: 8),
                    Text(
                      'Your security is our priority',
                      style: TextStyle(
                        color: AppColors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 40),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class MovingStarsBackground extends StatelessWidget {
  final AnimationController controller;
  const MovingStarsBackground({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: controller,
      builder: (context, child) {
        return CustomPaint(
          size: MediaQuery.of(context).size,
          painter: StarsPainter(progress: controller.value),
        );
      },
    );
  }
}

class StarsPainter extends CustomPainter {
  final double progress;
  final List<Star> stars;

  StarsPainter({required this.progress})
      : stars = List.generate(
          50,
          (index) => Star(
            x: Random(index).nextDouble(),
            y: Random(index + 100).nextDouble(),
            size: Random(index + 200).nextDouble() * 3 + 1,
            speed: Random(index + 300).nextDouble() * 0.05 + 0.02,
          ),
        );

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = Colors.white.withOpacity(0.6);

    for (var star in stars) {
      double currentY = (star.y + progress * star.speed) % 1.0;
      double centerX = star.x * size.width;
      double centerY = currentY * size.height;
      
      final starPath = Path();
      const int points = 5;
      final double innerRadius = star.size / 2.5;
      final double outerRadius = star.size;
      const double step = pi / points;

      starPath.moveTo(
        centerX + outerRadius * cos(-pi / 2),
        centerY + outerRadius * sin(-pi / 2),
      );

      for (int i = 0; i < 2 * points; i++) {
        final double radius = i % 2 == 0 ? outerRadius : innerRadius;
        final double angle = i * step - pi / 2;
        starPath.lineTo(
          centerX + radius * cos(angle),
          centerY + radius * sin(angle),
        );
      }
      starPath.close();
      canvas.drawPath(starPath, paint);
    }
  }

  @override
  bool shouldRepaint(covariant StarsPainter oldDelegate) => true;
}

class Star {
  final double x;
  final double y;
  final double size;
  final double speed;

  Star({required this.x, required this.y, required this.size, required this.speed});
}
