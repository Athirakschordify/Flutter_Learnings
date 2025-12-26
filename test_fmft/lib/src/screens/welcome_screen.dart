import 'dart:math';
import 'package:flutter/material.dart';
import '../core/constants/app_colors.dart';

class WelcomeScreen extends StatefulWidget {
  final VoidCallback onGetStarted;

  const WelcomeScreen({
    super.key,
    required this.onGetStarted,
  });

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen>
    with TickerProviderStateMixin {
  late AnimationController _fadeController;
  late AnimationController _scaleController;
  late AnimationController _slideController;
  late Animation<double> _fadeAnimation;
  late Animation<double> _scaleAnimation;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();

    // Fade animation
    _fadeController = AnimationController(
      duration: const Duration(milliseconds: 1200),
      vsync: this,
    );
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _fadeController, curve: Curves.easeIn),
    );

    // Scale animation
    _scaleController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );
    _scaleAnimation = Tween<double>(begin: 0.5, end: 1.0).animate(
      CurvedAnimation(parent: _scaleController, curve: Curves.elasticOut),
    );

    // Slide animation
    _slideController = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );
    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.5),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _slideController, curve: Curves.easeOut));

    // Start animations
    _fadeController.forward();
    Future.delayed(const Duration(milliseconds: 200), () {
      _scaleController.forward();
    });
    Future.delayed(const Duration(milliseconds: 400), () {
      _slideController.forward();
    });
  }

  @override
  void dispose() {
    _fadeController.dispose();
    _scaleController.dispose();
    _slideController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: AppColors.backgroundGradient,
          ),
        ),
        child: Stack(
          children: [
            // Floating sparkles background
            ...List.generate(20, (index) => FloatingSparkle(index: index)),
            
            // Main content
            SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(height: 60),
                    // Logo with sparkles
                    ScaleTransition(
                      scale: _scaleAnimation,
                      child: FadeTransition(
                        opacity: _fadeAnimation,
                        child: SizedBox(
                          width: 250,
                          height: 250,
                          child: Stack(
                            children: [
                              // Sparkles around logo
                              ...List.generate(8, (index) => FloatingSparkleInside(index: index)),
                              // Logo Image
                              Center(
                                child: TweenAnimationBuilder<double>(
                                  tween: Tween(begin: 0.0, end: 1.0),
                                  duration: const Duration(milliseconds: 1500),
                                  curve: Curves.elasticOut,
                                  builder: (context, value, child) {
                                    return Transform.scale(
                                      scale: 0.8 + (value * 0.2),
                                      child: Image.asset(
                                        'assets/images/ticket_pouch_logo.jpg',
                                        width: 240,
                                        height: 240,
                                        fit: BoxFit.contain,
                                        // Adding a subtle blend to help remove solid backgrounds if any
                                        colorBlendMode: BlendMode.darken,
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 80),
                    // Welcome Text with slide animation
                    SlideTransition(
                      position: _slideAnimation,
                      child: FadeTransition(
                        opacity: _fadeAnimation,
                        child: Column(
                          children: [
                            Text(
                              'Hi ! 👋',
                              style: TextStyle(
                                fontSize: 36,
                                fontWeight: FontWeight.w800,
                                color: Colors.white,
                                letterSpacing: -0.5,
                              ),
                            ),
                            const SizedBox(height: 16),
                            Text(
                              'You\'re all set to begin your journey',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w500,
                                color: Colors.white.withOpacity(0.9),
                                height: 1.4,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const Spacer(),
                    // Get Started Button with fade animation
                    FadeTransition(
                      opacity: _fadeAnimation,
                      child: TweenAnimationBuilder<double>(
                        tween: Tween(begin: 0.0, end: 1.0),
                        duration: const Duration(milliseconds: 1200),
                        curve: Curves.easeOut,
                        builder: (context, value, child) {
                          return Transform.translate(
                            offset: Offset(0, 50 * (1 - value)),
                            child: Opacity(
                              opacity: value,
                              child: child,
                            ),
                          );
                        },
                        child: Container(
                          width: double.infinity,
                          height: 56,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(16),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.1),
                                blurRadius: 16,
                                offset: const Offset(0, 6),
                              ),
                            ],
                          ),
                          child: Material(
                            color: Colors.transparent,
                            child: InkWell(
                              onTap: widget.onGetStarted,
                              borderRadius: BorderRadius.circular(16),
                              child: Center(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      'Get Started',
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w700,
                                        color: AppColors.primary,
                                      ),
                                    ),
                                    const SizedBox(width: 8),
                                    Text(
                                      '🚀',
                                      style: TextStyle(fontSize: 20),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),
                    // Footer Text with fade animation
                    FadeTransition(
                      opacity: _fadeAnimation,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            '✨ ',
                            style: TextStyle(fontSize: 16),
                          ),
                          Text(
                            'Let\'s make something amazing together!',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: Colors.white.withOpacity(0.8),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 32),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Floating Sparkle Widget (Background)
class FloatingSparkle extends StatefulWidget {
  final int index;

  const FloatingSparkle({super.key, required this.index});

  @override
  State<FloatingSparkle> createState() => _FloatingSparkleState();
}

class _FloatingSparkleState extends State<FloatingSparkle>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  late double _startX;
  late double _startY;
  late double _endY;
  late double _size;
  late double _duration;

  @override
  void initState() {
    super.initState();

    final random = Random(widget.index);
    _startX = random.nextDouble();
    _startY = random.nextDouble();
    _endY = _startY - 0.3 - (random.nextDouble() * 0.4);
    _size = 8 + random.nextDouble() * 8;
    _duration = 3 + random.nextDouble() * 4;

    _controller = AnimationController(
      duration: Duration(milliseconds: (_duration * 1000).toInt()),
      vsync: this,
    );

    _animation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );

    // Delay start based on index
    Future.delayed(Duration(milliseconds: widget.index * 100), () {
      if (mounted) {
        _controller.repeat();
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        final screenHeight = MediaQuery.of(context).size.height;
        final screenWidth = MediaQuery.of(context).size.width;

        final progress = _animation.value;
        final currentY = _startY + (_endY - _startY) * progress;
        final opacity = (1 - progress).clamp(0.0, 1.0);

        return Positioned(
          left: _startX * screenWidth,
          top: currentY * screenHeight,
          child: Opacity(
            opacity: opacity,
            child: Text(
              '✨',
              style: TextStyle(fontSize: _size),
            ),
          ),
        );
      },
    );
  }
}

// Floating Sparkle Inside Logo Widget
class FloatingSparkleInside extends StatefulWidget {
  final int index;

  const FloatingSparkleInside({super.key, required this.index});

  @override
  State<FloatingSparkleInside> createState() => _FloatingSparkleInsideState();
}

class _FloatingSparkleInsideState extends State<FloatingSparkleInside>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  late double _startX;
  late double _startY;
  late double _endY;
  late double _size;
  late double _duration;

  @override
  void initState() {
    super.initState();

    final random = Random(widget.index + 100);
    _startX = random.nextDouble();
    _startY = random.nextDouble();
    _endY = _startY - 0.5 - (random.nextDouble() * 0.3);
    _size = 10 + random.nextDouble() * 10;
    _duration = 2 + random.nextDouble() * 3;

    _controller = AnimationController(
      duration: Duration(milliseconds: (_duration * 1000).toInt()),
      vsync: this,
    );

    _animation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );

    // Delay start based on index
    Future.delayed(Duration(milliseconds: widget.index * 150), () {
      if (mounted) {
        _controller.repeat();
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        final progress = _animation.value;
        final currentY = _startY + (_endY - _startY) * progress;
        final opacity = (1 - progress).clamp(0.0, 1.0);

        return Positioned(
          left: _startX * 250,
          top: currentY * 250,
          child: Opacity(
            opacity: opacity * 0.6,
            child: Text(
              '✨',
              style: TextStyle(fontSize: _size),
            ),
          ),
        );
      },
    );
  }
}
