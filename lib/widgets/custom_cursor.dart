import 'package:flutter/material.dart';
import '../core/constants/app_colors.dart';
import '../core/utils/responsive.dart';

class CustomCursor extends StatefulWidget {
  final Widget child;
  const CustomCursor({super.key, required this.child});

  @override
  State<CustomCursor> createState() => _CustomCursorState();
}

class _CustomCursorState extends State<CustomCursor> {
  Offset _pointerPos = Offset.zero;
  bool _isVisible = false;

  void _onPointerMove(PointerEvent event) {
    setState(() {
      _pointerPos = event.position;
      _isVisible = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (Responsive.isMobile(context)) return widget.child;

    return MouseRegion(
      cursor: SystemMouseCursors.none,
      onEnter: (_) => setState(() => _isVisible = true),
      onExit: (_) => setState(() => _isVisible = false),
      onHover: _onPointerMove,
      child: Stack(
        children: [
          widget.child,
          if (_isVisible) ...[
            // Outer Glow / Ring
            TweenAnimationBuilder<Offset>(
              duration: const Duration(milliseconds: 150),
              curve: Curves.easeOutCubic,
              tween: Tween(begin: _pointerPos, end: _pointerPos),
              builder: (context, pos, child) {
                return Positioned(
                  left: pos.dx - 20,
                  top: pos.dy - 20,
                  child: IgnorePointer(
                    child: Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: AppColors.primary.withOpacity(0.3),
                          width: 1,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: AppColors.primary.withOpacity(0.1),
                            blurRadius: 10,
                            spreadRadius: 2,
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
            // Inner Dot
            TweenAnimationBuilder<Offset>(
              duration: const Duration(milliseconds: 50),
              curve: Curves.easeOutCubic,
              tween: Tween(begin: _pointerPos, end: _pointerPos),
              builder: (context, pos, child) {
                return Positioned(
                  left: pos.dx - 4,
                  top: pos.dy - 4,
                  child: IgnorePointer(
                    child: Container(
                      width: 8,
                      height: 8,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: AppColors.primary.withOpacity(0.8),
                            blurRadius: 10,
                            spreadRadius: 2,
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ],
        ],
      ),
    );
  }
}

