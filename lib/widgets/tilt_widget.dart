import 'package:flutter/material.dart';

class TiltWidget extends StatefulWidget {
  final Widget child;
  final double maxTilt;
  final double scale;

  const TiltWidget({
    super.key,
    required this.child,
    this.maxTilt = 0.1,
    this.scale = 1.05,
  });

  @override
  State<TiltWidget> createState() => _TiltWidgetState();
}

class _TiltWidgetState extends State<TiltWidget> with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  double _x = 0;
  double _y = 0;
  bool _isHovered = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onHover(PointerEvent event, BoxConstraints constraints) {
    if (!_isHovered) return;
    
    final xPos = event.localPosition.dx;
    final yPos = event.localPosition.dy;
    
    // Normalize position from -1 to 1
    final normalizedX = (xPos / constraints.maxWidth) * 2 - 1;
    final normalizedY = (yPos / constraints.maxHeight) * 2 - 1;

    setState(() {
      _x = normalizedY * widget.maxTilt; // Tilt on Y axis based on mouse Y
      _y = -normalizedX * widget.maxTilt; // Tilt on X axis based on mouse X
    });
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return MouseRegion(
          onEnter: (_) {
            setState(() => _isHovered = true);
            _controller.forward();
          },
          onExit: (_) {
            setState(() {
              _isHovered = false;
              _x = 0;
              _y = 0;
            });
            _controller.reverse();
          },
          onHover: (e) => _onHover(e, constraints),
          child: AnimatedBuilder(
            animation: _controller,
            builder: (context, child) {
              return Transform(
                transform: Matrix4.identity()
                  ..setEntry(3, 2, 0.001) // Perspective
                  ..rotateX(_isHovered ? _x : _x * _controller.value)
                  ..rotateY(_isHovered ? _y : _y * _controller.value)
                  ..scale(_controller.value * (widget.scale - 1.0) + 1.0),
                alignment: Alignment.center,
                child: widget.child,
              );
            },
          ),
        );
      },
    );
  }
}
