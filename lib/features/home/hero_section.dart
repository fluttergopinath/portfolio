import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_strings.dart';
import '../../core/utils/responsive.dart';
import '../../widgets/mesh_gradient_background.dart';
import '../../widgets/glass_card.dart';
import '../../widgets/tilt_widget.dart';

class HeroSection extends StatefulWidget {
  final GlobalKey sectionKey;
  final VoidCallback onViewProjects;
  final VoidCallback onContactMe;

  const HeroSection({
    super.key,
    required this.sectionKey,
    required this.onViewProjects,
    required this.onContactMe,
  });

  @override
  State<HeroSection> createState() => _HeroSectionState();
}

class _HeroSectionState extends State<HeroSection> {
  Offset _mouseOffset = Offset.zero;

  void _onMouseMove(PointerEvent event) {
    if (!mounted) return;
    final size = MediaQuery.of(context).size;
    setState(() {
      _mouseOffset = Offset(
        (event.position.dx / size.width) * 2 - 1,
        (event.position.dy / size.height) * 2 - 1,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final isMobile = Responsive.isMobile(context);
    final screenHeight = MediaQuery.of(context).size.height;

    return MouseRegion(
      onHover: _onMouseMove,
      child: MeshGradientBackground(
        child: ConstrainedBox(
          key: widget.sectionKey,
          constraints: BoxConstraints(
            minHeight: screenHeight,
            minWidth: double.infinity,
          ),
          child: Stack(
            children: [
              // 3D Floating Shapes in background
              if (!isMobile) ...[
                Positioned(
                  top: screenHeight * 0.1,
                  right: 100,
                  child: _Floating3DBox(
                    size: 150,
                    color: AppColors.primary,
                    mouseOffset: _mouseOffset,
                    speed: 0.5,
                  ),
                ),
                Positioned(
                  bottom: screenHeight * 0.2,
                  left: 50,
                  child: _Floating3DBox(
                    size: 100,
                    color: AppColors.secondary,
                    mouseOffset: _mouseOffset,
                    speed: -0.8,
                  ),
                ),
                Positioned(
                  top: screenHeight * 0.6,
                  right: screenHeight * 0.3,
                  child: _Floating3DBox(
                    size: 80,
                    color: AppColors.accent,
                    mouseOffset: _mouseOffset,
                    speed: 1.2,
                  ),
                ),
              ],

              Center(
                child: Container(
                  width: Responsive.contentWidth(context),
                  padding: EdgeInsets.symmetric(
                    horizontal: isMobile ? 24 : 40,
                    vertical: 80,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment:
                        isMobile ? CrossAxisAlignment.center : CrossAxisAlignment.start,
                    children: [
                      // Modern Badge
                      GlassCard(
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                        borderRadius: 100,
                        blur: 10,
                        opacity: 0.05,
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Container(
                              width: 8,
                              height: 8,
                              decoration: BoxDecoration(
                                color: const Color(0xFF00FF94),
                                shape: BoxShape.circle,
                                boxShadow: [
                                  BoxShadow(
                                    color: const Color(0xFF00FF94).withOpacity(0.5),
                                    blurRadius: 10,
                                    spreadRadius: 2,
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(width: 12),
                            Text(
                              'AVAILABLE FOR NEW PROJECTS',
                              style: Theme.of(context).textTheme.labelLarge?.copyWith(
                                    fontSize: 10,
                                    fontWeight: FontWeight.w800,
                                  ),
                            ),
                          ],
                        ),
                      )
                          .animate()
                          .fadeIn(duration: 800.ms)
                          .slideY(begin: 0.2, end: 0),
                      const SizedBox(height: 40),
                      
                      // Hero Typography
                      TiltWidget(
                        maxTilt: 0.05,
                        child: Column(
                          crossAxisAlignment: isMobile
                              ? CrossAxisAlignment.center
                              : CrossAxisAlignment.start,
                          children: [
                            Text(
                              'I AM',
                              style: Theme.of(context).textTheme.displaySmall?.copyWith(
                                    fontSize: isMobile ? 24 : 40,
                                    fontWeight: FontWeight.w300,
                                    color: Colors.white.withOpacity(0.5),
                                    letterSpacing: 8,
                                  ),
                            ).animate().fadeIn(delay: 200.ms).moveX(begin: -20, end: 0),
                            const SizedBox(height: 12),
                            ShaderMask(
                              shaderCallback: (bounds) =>
                                  AppColors.premiumGradient.createShader(bounds),
                              child: Text(
                                AppStrings.name.toUpperCase(),
                                style: Theme.of(context).textTheme.displayLarge?.copyWith(
                                      fontSize: isMobile ? 56 : 120,
                                      color: Colors.white,
                                    ),
                              ),
                            ).animate().fadeIn(delay: 400.ms).slideY(begin: 0.1, end: 0),
                          ],
                        ),
                      ),
                      
                      const SizedBox(height: 32),
                      
                      // Animated Role
                      SizedBox(
                        height: isMobile ? 40 : 60,
                        child: DefaultTextStyle(
                          style: Theme.of(context).textTheme.displaySmall?.copyWith(
                                fontSize: isMobile ? 24 : 44,
                                fontWeight: FontWeight.w200,
                                color: Colors.white,
                              ) ??
                              const TextStyle(),
                          child: AnimatedTextKit(
                            repeatForever: true,
                            pause: const Duration(milliseconds: 2000),
                            animatedTexts: [
                              TypewriterAnimatedText('FLUTTER DEVELOPER.'),
                              TypewriterAnimatedText('DIGITAL ARCHITECT.'),
                              TypewriterAnimatedText('UI/UX ENTHUSIAST.'),
                            ],
                          ),
                        ),
                      ).animate().fadeIn(delay: 600.ms),
                      
                      const SizedBox(height: 40),
                      
                      // Subtitle
                      SizedBox(
                        width: isMobile ? double.infinity : 700,
                        child: Text(
                          AppStrings.heroSubtitle,
                          textAlign: isMobile ? TextAlign.center : TextAlign.left,
                          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                                color: Colors.white.withOpacity(0.6),
                              ),
                        ),
                      ).animate().fadeIn(delay: 800.ms).slideY(begin: 0.1, end: 0),
                      
                      const SizedBox(height: 64),
                      
                      // CTAs
                      Wrap(
                        alignment: isMobile ? WrapAlignment.center : WrapAlignment.start,
                        spacing: 24,
                        runSpacing: 20,
                        children: [
                          _PremiumCTA(
                            label: 'VIEW PROJECTS',
                            onPressed: widget.onViewProjects,
                            isPrimary: true,
                          ),
                          _PremiumCTA(
                            label: 'LET\'S TALK',
                            onPressed: widget.onContactMe,
                            isPrimary: false,
                          ),
                        ],
                      ).animate().fadeIn(delay: 1000.ms).slideY(begin: 0.2, end: 0),
                    ],
                  ),
                ),
              ),
              
              // Scroll Indicator
              Positioned(
                bottom: 40,
                left: 0,
                right: 0,
                child: Center(
                  child: Column(
                    children: [
                      Container(
                        width: 1,
                        height: 60,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              Colors.white.withOpacity(0),
                              Colors.white.withOpacity(0.5),
                              Colors.white.withOpacity(0),
                            ],
                          ),
                        ),
                      ).animate(onPlay: (c) => c.repeat()).shimmer(duration: 2.seconds),
                      const SizedBox(height: 16),
                      Text(
                        'SCROLL',
                        style: Theme.of(context).textTheme.labelLarge?.copyWith(
                              fontSize: 10,
                              letterSpacing: 4,
                              color: Colors.white.withOpacity(0.3),
                            ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _PremiumCTA extends StatefulWidget {
  final String label;
  final VoidCallback onPressed;
  final bool isPrimary;

  const _PremiumCTA({
    required this.label,
    required this.onPressed,
    required this.isPrimary,
  });

  @override
  State<_PremiumCTA> createState() => _PremiumCTAState();
}

class _PremiumCTAState extends State<_PremiumCTA> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedContainer(
        duration: 300.ms,
        curve: Curves.easeOutCubic,
        transform: Matrix4.identity()..scale(_isHovered ? 1.05 : 1.0),
        child: ElevatedButton(
          onPressed: widget.onPressed,
          style: ElevatedButton.styleFrom(
            backgroundColor: widget.isPrimary ? AppColors.primary : Colors.transparent,
            side: widget.isPrimary ? null : BorderSide(color: Colors.white.withOpacity(0.2)),
            padding: const EdgeInsets.symmetric(horizontal: 48, vertical: 24),
          ),
          child: Text(
            widget.label,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w900,
              letterSpacing: 2,
            ),
          ),
        ),
      ).animate(target: _isHovered ? 1 : 0).boxShadow(
            begin: const BoxShadow(color: Colors.transparent, blurRadius: 0),
            end: BoxShadow(
              color: (widget.isPrimary ? AppColors.primary : AppColors.secondary).withOpacity(0.4),
              blurRadius: 30,
              spreadRadius: 2,
            ),
          ),
    );
  }
}

class _Floating3DBox extends StatelessWidget {
  final double size;
  final Color color;
  final Offset mouseOffset;
  final double speed;

  const _Floating3DBox({
    required this.size,
    required this.color,
    required this.mouseOffset,
    required this.speed,
  });

  @override
  Widget build(BuildContext context) {
    return Transform(
      transform: Matrix4.identity()
        ..setEntry(3, 2, 0.001)
        ..rotateX(mouseOffset.dy * speed * 0.5)
        ..rotateY(mouseOffset.dx * speed * 0.5)
        ..translate(mouseOffset.dx * 30 * speed, mouseOffset.dy * 30 * speed),
      alignment: Alignment.center,
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(size * 0.2),
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              color.withOpacity(0.2),
              color.withOpacity(0.05),
            ],
          ),
          border: Border.all(
            color: color.withOpacity(0.3),
            width: 2,
          ),
          boxShadow: [
            BoxShadow(
              color: color.withOpacity(0.2),
              blurRadius: 40,
              spreadRadius: 5,
            ),
          ],
        ),
      ),
    ).animate(onPlay: (c) => c.repeat()).moveY(
          begin: -20,
          end: 20,
          duration: 4.seconds,
          curve: Curves.easeInOut,
        );
  }
}

