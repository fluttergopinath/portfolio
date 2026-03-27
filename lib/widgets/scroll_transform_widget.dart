import 'package:flutter/material.dart';

class ScrollTransformWidget extends StatelessWidget {
  final Widget child;
  final ScrollController scrollController;
  final GlobalKey sectionKey;

  const ScrollTransformWidget({
    super.key,
    required this.child,
    required this.scrollController,
    required this.sectionKey,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: scrollController,
      builder: (context, child) {
        double offset = 0.0;
        double? screenHeight;
        
        try {
          final renderBox = sectionKey.currentContext?.findRenderObject() as RenderBox?;
          if (renderBox != null) {
            screenHeight = MediaQuery.of(context).size.height;
            final position = renderBox.localToGlobal(Offset.zero);
            final sectionCenter = position.dy + (renderBox.size.height / 2);
            final screenCenter = screenHeight / 2;
            
            // Normalize distance from center: 0.0 is center, 1.0 is one screen away
            offset = ((sectionCenter - screenCenter) / screenHeight).clamp(-1.5, 1.5);
          }
        } catch (e) {
          // Context might not be ready yet
        }

        if (screenHeight == null) return child!;

        // Cinematic effects based on scroll position
        final absOffset = offset.abs();
        
        // Very subtle scale down (min 0.95)
        final scale = 1.0 - (absOffset * 0.05).clamp(0.0, 0.05);

        return Transform.scale(
          scale: scale,
          child: child,
        );
      },
      child: child,
    );
  }
}
