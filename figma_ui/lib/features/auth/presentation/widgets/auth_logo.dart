import 'package:flutter/material.dart';
import '../../../../core/res/colors.dart';

class AuthLogo extends StatelessWidget {
  const AuthLogo({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          width: 200,
          height: 120,
          child: Stack(
            alignment: Alignment.center,
            clipBehavior: Clip.none,
            children: [
              // Background Ticket (tilted)
              Positioned(
                top: 0,
                child: Transform.rotate(
                  angle: -0.15, // Slight tilt like the image
                  child: CustomPaint(
                    size: const Size(160, 75),
                    painter: TicketPainter(color: Colors.white, showDivider: false),
                  ),
                ),
              ),
              // Foreground Ticket (horizontal)
              Positioned(
                top: 25,
                child: CustomPaint(
                  size: const Size(160, 75),
                  painter: TicketPainter(color: Colors.white, showDivider: true),
                  child: Container(
                    width: 160,
                    height: 75,
                    padding: const EdgeInsets.only(left: 45), // Space for the left part of the ticket
                    alignment: Alignment.center,
                    child: const Text(
                      'TICKET',
                      style: TextStyle(
                        color: Color(0xFF001AFF), // Deeper blue like the image
                        fontSize: 26,
                        fontWeight: FontWeight.w900,
                        letterSpacing: 2.0,
                        fontFamily: 'Roboto',
                      ),
                    ),
                  ),
                ),
              ),
              // "pouch" text with drop shadow
              Positioned(
                top: 75,
                child: Text(
                  'pouch',
                  style: TextStyle(
                    fontSize: 72,
                    fontWeight: FontWeight.w900,
                    color: const Color(0xFF001AFF), // Matching the ticket blue
                    fontFamily: 'Roboto',
                    height: 0.8,
                    shadows: [
                      Shadow(
                        color: Colors.black.withOpacity(0.35),
                        offset: const Offset(0, 10),
                        blurRadius: 15,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class TicketPainter extends CustomPainter {
  final Color color;
  final bool showDivider;

  TicketPainter({required this.color, required this.showDivider});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    final borderPaint = Paint()
      ..color = const Color(0xFF001AFF)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3.5;

    final path = Path();
    const double zigSize = 5.0;
    
    // Start at top-left
    path.moveTo(0, 0);
    
    // Top zig-zag
    for (double i = 0; i < size.width; i += zigSize * 2) {
      path.lineTo(i + zigSize, zigSize);
      path.lineTo(i + zigSize * 2, 0);
    }
    
    // Right side
    path.lineTo(size.width, size.height);
    
    // Bottom zig-zag
    for (double i = size.width; i > 0; i -= zigSize * 2) {
      path.lineTo(i - zigSize, size.height - zigSize);
      path.lineTo(i - zigSize * 2, size.height);
    }
    
    // Left side
    path.lineTo(0, 0);
    path.close();

    // Draw shadow for the ticket
    canvas.drawPath(
      path.shift(const Offset(0, 4)),
      Paint()
        ..color = Colors.black.withOpacity(0.15)
        ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 8),
    );

    canvas.drawPath(path, paint);
    canvas.drawPath(path, borderPaint);

    if (showDivider) {
      // Vertical divider on the left
      final dividerPaint = Paint()
        ..color = const Color(0xFF001AFF)
        ..style = PaintingStyle.stroke
        ..strokeWidth = 2.5;
      
      canvas.drawLine(
        Offset(size.width * 0.28, zigSize + 5),
        Offset(size.width * 0.28, size.height - zigSize - 5),
        dividerPaint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
