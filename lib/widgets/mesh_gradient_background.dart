import 'dart:math';
import 'package:flutter/material.dart';
import '../core/constants/app_colors.dart';

class MeshGradientBackground extends StatefulWidget {
  final Widget child;
  const MeshGradientBackground({super.key, required this.child});

  @override
  State<MeshGradientBackground> createState() => _MeshGradientBackgroundState();
}

class _MeshGradientBackgroundState extends State<MeshGradientBackground>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 10),
      vsync: this,
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Stack(
          children: [
            Container(color: AppColors.darkBackground),
            Positioned.fill(
              child: CustomPaint(
                painter: MeshPainter(_controller.value),
              ),
            ),
            widget.child,
          ],
        );
      },
    );
  }
}

class MeshPainter extends CustomPainter {
  final double progress;
  MeshPainter(this.progress);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..maskFilter = const MaskFilter.blur(BlurStyle.normal, 100);

    void drawBlur(Color color, Offset offset, double radius) {
      paint.color = color.withOpacity(0.15);
      canvas.drawCircle(offset, radius, paint);
    }

    final t = progress * 2 * pi;
    
    // Animated floating glow spots
    drawBlur(
      AppColors.primary,
      Offset(
        size.width * (0.2 + 0.1 * sin(t)),
        size.height * (0.3 + 0.1 * cos(t)),
      ),
      size.width * 0.4,
    );

    drawBlur(
      AppColors.secondary,
      Offset(
        size.width * (0.8 + 0.1 * cos(t * 0.7)),
        size.height * (0.7 + 0.1 * sin(t * 0.7)),
      ),
      size.width * 0.5,
    );

    drawBlur(
      AppColors.accent,
      Offset(
        size.width * (0.5 + 0.1 * sin(t * 0.5)),
        size.height * (0.5 + 0.1 * cos(t * 0.5)),
      ),
      size.width * 0.3,
    );
  }

  @override
  bool shouldRepaint(MeshPainter oldDelegate) => true;
}
