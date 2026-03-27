import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
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

  void _onPointerEnter(PointerEvent event) {
    setState(() => _isVisible = true);
  }

  void _onPointerExit(PointerEvent event) {
    setState(() => _isVisible = false);
  }

  @override
  Widget build(BuildContext context) {
    if (Responsive.isMobile(context)) return widget.child;

    return MouseRegion(
      cursor: SystemMouseCursors.none,
      onEnter: _onPointerEnter,
      onExit: _onPointerExit,
      onHover: _onPointerMove,
      child: Stack(
        children: [
          widget.child,
          if (_isVisible)
            Positioned(
              left: _pointerPos.dx - 10,
              top: _pointerPos.dy - 10,
              child: IgnorePointer(
                child: AnimatedContainer(
                  duration: 150.ms,
                  curve: Curves.easeOutCubic,
                  width: 20,
                  height: 20,
                  decoration: BoxDecoration(
                    color: AppColors.primary.withOpacity(0.3),
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: AppColors.primary.withOpacity(0.5),
                      width: 1,
                    ),
                  ),
                ),
              ),
            ),
          if (_isVisible)
             Positioned(
              left: _pointerPos.dx - 4,
              top: _pointerPos.dy - 4,
              child: IgnorePointer(
                child: Container(
                  width: 8,
                  height: 8,
                  decoration: const BoxDecoration(
                    color: AppColors.primary,
                    shape: BoxShape.circle,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
