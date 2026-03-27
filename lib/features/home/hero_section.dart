import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_strings.dart';
import '../../core/utils/responsive.dart';

class HeroSection extends StatefulWidget {
  final GlobalKey sectionKey;
  final VoidCallback onViewProjects;
  final VoidCallback onContactMe;

  // Premium Hero Section with mouse-parallax and interactive depth
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
      // Normalize to -1 to 1 range
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
      child: ConstrainedBox(
        key: widget.sectionKey,
        constraints: BoxConstraints(
          minHeight: screenHeight,
          minWidth: double.infinity,
        ),
        child: Stack(
          fit: StackFit.passthrough,
          children: [
            Positioned.fill(
              child: _ParticleBackground(
                isDark: Theme.of(context).brightness == Brightness.dark,
              ),
            ),
          // Gradient overlays for depth
          Positioned.fill(
            child: DecoratedBox(
              decoration: BoxDecoration(
                gradient: RadialGradient(
                  center: const Alignment(-0.8, -0.5),
                  radius: 1.2,
                  colors: [
                    AppColors.primary.withOpacity(0.1),
                    Colors.transparent,
                  ],
                ),
              ),
            ),
          ),
          Positioned.fill(
            child: DecoratedBox(
              decoration: BoxDecoration(
                gradient: RadialGradient(
                  center: const Alignment(0.8, 0.5),
                  radius: 1.2,
                  colors: [
                    AppColors.secondary.withOpacity(0.08),
                    Colors.transparent,
                  ],
                ),
              ),
            ),
          ),
            // Multi-layered Parallax Orbs
            Positioned(
              top: screenHeight * 0.2,
              left: -100,
              child: Transform.translate(
                offset: _mouseOffset * 30,
                child: _ParallaxOrb(
                  size: 400,
                  color: AppColors.primary.withOpacity(0.15),
                ),
              ),
            ),
            Positioned(
              bottom: screenHeight * 0.1,
              right: -150,
              child: Transform.translate(
                offset: _mouseOffset * -50,
                child: _ParallaxOrb(
                  size: 500,
                  color: AppColors.secondary.withOpacity(0.12),
                ),
              ),
            ),
            Positioned(
              top: screenHeight * 0.5,
              right: screenHeight * 0.2,
              child: Transform.translate(
                offset: _mouseOffset * 20,
                child: _ParallaxOrb(
                  size: 300,
                  color: AppColors.accent.withOpacity(0.1),
                ),
              ),
            ),
            // Content
          Center(
            child: SizedBox(
              width: Responsive.contentWidth(context),
              child: Padding(
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
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.03),
                        borderRadius: BorderRadius.circular(100),
                        border: Border.all(
                          color: Colors.white.withOpacity(0.08),
                        ),
                      ),
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
                          const SizedBox(width: 10),
                          Text(
                            'AVAILABLE FOR NEW PROJECTS',
                            style: Theme.of(context).textTheme.labelLarge?.copyWith(
                                  fontSize: 11,
                                  fontWeight: FontWeight.w700,
                                  letterSpacing: 2,
                                ),
                          ),
                        ],
                      ),
                    )
                        .animate()
                        .fadeIn(duration: 800.ms)
                        .slideY(begin: 0.2, end: 0, curve: Curves.easeOutCubic),
                    const SizedBox(height: 32),
                    // High-End Typography Title
                    Column(
                      crossAxisAlignment: isMobile
                          ? CrossAxisAlignment.center
                          : CrossAxisAlignment.start,
                      children: [
                        Transform.translate(
                          offset: _mouseOffset * 20,
                          child: Text(
                            'I AM',
                            style: Theme.of(context).textTheme.displaySmall?.copyWith(
                                  fontSize: isMobile ? 24 : 32,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.white.withOpacity(0.6),
                                  letterSpacing: 4,
                                ),
                          )
                              .animate()
                              .fadeIn(delay: 200.ms, duration: 800.ms)
                              .moveX(begin: -20, end: 0),
                        ),
                        const SizedBox(height: 8),
                        Transform.translate(
                          offset: _mouseOffset * 40,
                          child: ShaderMask(
                            shaderCallback: (bounds) =>
                                AppColors.primaryGradient.createShader(bounds),
                            child: Text(
                              AppStrings.name.toUpperCase(),
                              textAlign: isMobile ? TextAlign.center : TextAlign.left,
                              style: Theme.of(context).textTheme.displayLarge?.copyWith(
                                    fontSize: isMobile ? 48 : 96,
                                    color: Colors.white,
                                    height: 0.9,
                                  ),
                            ),
                          )
                              .animate()
                              .fadeIn(delay: 400.ms, duration: 1000.ms)
                              .slideY(begin: 0.1, end: 0),
                        ),
                      ],
                    ),
                    const SizedBox(height: 24),
                    // Dynamic Role with Typing
                    SizedBox(
                      height: isMobile ? 40 : 60,
                      child: DefaultTextStyle(
                        style: Theme.of(context).textTheme.displaySmall?.copyWith(
                                  fontSize: isMobile ? 22 : 36,
                                  fontWeight: FontWeight.w300,
                                  color: Colors.white,
                                ) ??
                            const TextStyle(),
                        child: AnimatedTextKit(
                          repeatForever: true,
                          pause: const Duration(milliseconds: 1500),
                          animatedTexts: [
                            TypewriterAnimatedText(
                              'FLUTTER DEVELOPER.',
                              speed: const Duration(milliseconds: 100),
                            ),
                            TypewriterAnimatedText(
                              'DIGITAL ARCHITECT.',
                              speed: const Duration(milliseconds: 100),
                            ),
                            TypewriterAnimatedText(
                              'UI/UX ENTHUSIAST.',
                              speed: const Duration(milliseconds: 100),
                            ),
                          ],
                        ),
                      ),
                    ).animate().fadeIn(delay: 600.ms, duration: 800.ms),
                    const SizedBox(height: 32),
                    // Refined Subtitle
                    SizedBox(
                      width: isMobile ? double.infinity : 600,
                      child: Text(
                        AppStrings.heroSubtitle,
                        textAlign: isMobile ? TextAlign.center : TextAlign.left,
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                              fontSize: isMobile ? 16 : 18,
                              color: Colors.white.withOpacity(0.7),
                              height: 1.6,
                            ),
                      ),
                    )
                        .animate()
                        .fadeIn(delay: 800.ms, duration: 800.ms)
                        .slideY(begin: 0.1, end: 0),
                    const SizedBox(height: 48),
                    // Premium CTAs
                    Wrap(
                      alignment: isMobile ? WrapAlignment.center : WrapAlignment.start,
                      spacing: 24,
                      runSpacing: 16,
                      children: [
                        _PremiumButton(
                          label: 'VIEW PROJECTS',
                          isPrimary: true,
                          onTap: widget.onViewProjects,
                        ),
                        _PremiumButton(
                          label: 'LET\'S TALK',
                          isPrimary: false,
                          onTap: widget.onContactMe,
                        ),
                      ],
                    )
                        .animate()
                        .fadeIn(delay: 1000.ms, duration: 800.ms)
                        .slideY(begin: 0.2, end: 0),
                    const SizedBox(height: 60),
                    // Minimal Stats
                    _StatsRow(isMobile: isMobile),
                  ],
                ),
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
                    width: 20,
                    height: 35,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: Colors.white.withOpacity(0.2), width: 1.5),
                    ),
                    child: Stack(
                      children: [
                        Positioned(
                          top: 5,
                          left: 0,
                          right: 0,
                          child: Center(
                            child: Container(
                              width: 3,
                              height: 8,
                              decoration: BoxDecoration(
                                color: AppColors.secondary,
                                borderRadius: BorderRadius.circular(3),
                              ),
                            ).animate(onPlay: (c) => c.repeat()).moveY(
                                  begin: 0,
                                  end: 15,
                                  duration: 1500.ms,
                                  curve: Curves.easeInOut,
                                ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    'SCROLL',
                    style: Theme.of(context).textTheme.labelLarge?.copyWith(
                          fontSize: 10,
                          letterSpacing: 3,
                          color: Colors.white.withOpacity(0.4),
                        ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      )
    );
  }
}

// ─── Stats Row ───
class _StatsRow extends StatelessWidget {
  final bool isMobile;
  const _StatsRow({required this.isMobile});

  @override
  Widget build(BuildContext context) {
    final stats = [
      (AppStrings.statProjects, AppStrings.statProjectsLabel),
      (AppStrings.statExperience, AppStrings.statExperienceLabel),
      (AppStrings.statTech, AppStrings.statTechLabel),
    ];

    return Wrap(
      alignment: isMobile ? WrapAlignment.center : WrapAlignment.start,
      spacing: isMobile ? 32 : 64,
      runSpacing: 24,
      children: stats.asMap().entries.map((entry) {
        return _StatItem(
          value: entry.value.$1,
          label: entry.value.$2,
          isMobile: isMobile,
          delay: 1200 + entry.key * 150,
        );
      }).toList(),
    );
  }
}

class _StatItem extends StatelessWidget {
  final String value;
  final String label;
  final bool isMobile;
  final int delay;

  const _StatItem({
    required this.value,
    required this.label,
    required this.isMobile,
    required this.delay,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment:
          isMobile ? CrossAxisAlignment.center : CrossAxisAlignment.start,
      children: [
        Text(
          value,
          style: Theme.of(context).textTheme.displaySmall?.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.w900,
                fontSize: isMobile ? 32 : 44,
                height: 1,
              ),
        ),
        const SizedBox(height: 8),
        Text(
          label.toUpperCase(),
          style: Theme.of(context).textTheme.labelLarge?.copyWith(
                fontSize: 11,
                letterSpacing: 2,
                color: Colors.white.withOpacity(0.4),
                height: 1.4,
              ),
        ),
      ],
    )
        .animate()
        .fadeIn(delay: Duration(milliseconds: delay), duration: 800.ms)
        .slideY(begin: 0.2, end: 0);
  }
}

// ─── Premium Button ───
class _PremiumButton extends StatefulWidget {
  final String label;
  final bool isPrimary;
  final VoidCallback onTap;

  const _PremiumButton({
    required this.label,
    required this.isPrimary,
    required this.onTap,
  });

  @override
  State<_PremiumButton> createState() => _PremiumButtonState();
}

class _PremiumButtonState extends State<_PremiumButton> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
          decoration: BoxDecoration(
            gradient: widget.isPrimary ? AppColors.primaryGradient : null,
            color: widget.isPrimary ? null : Colors.transparent,
            borderRadius: BorderRadius.circular(100),
            border: widget.isPrimary
                ? null
                : Border.all(
                    color: _isHovered ? AppColors.secondary : Colors.white.withOpacity(0.2),
                    width: 1.5,
                  ),
            boxShadow: _isHovered && widget.isPrimary
                ? [
                    BoxShadow(
                      color: AppColors.primary.withOpacity(0.4),
                      blurRadius: 30,
                      offset: const Offset(0, 10),
                    ),
                  ]
                : [],
          ),
          transform: _isHovered
              ? (Matrix4.identity()..scale(1.05))
              : Matrix4.identity(),
          child: Text(
            widget.label,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.w800,
                  letterSpacing: 2,
                  fontSize: 14,
                ),
          ),
        ),
      ),
    );
  }
}

// ─── Particle Background ───
class _ParticleBackground extends StatefulWidget {
  final bool isDark;
  const _ParticleBackground({required this.isDark});

  @override
  State<_ParticleBackground> createState() => _ParticleBackgroundState();
}

class _ParticleBackgroundState extends State<_ParticleBackground>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late List<_Particle> _particles;
  final _random = Random();

  @override
  void initState() {
    super.initState();
    _particles = List.generate(50, (_) => _Particle.random(_random));
    _controller = AnimationController(
      duration: const Duration(seconds: 30),
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
        return CustomPaint(
          painter: _ParticlePainter(
            particles: _particles,
            animationValue: _controller.value,
            isDark: widget.isDark,
          ),
          child: const SizedBox.expand(),
        );
      },
    );
  }
}

class _Particle {
  final double x;
  final double y;
  final double radius;
  final double speed;
  final double opacity;

  const _Particle({
    required this.x,
    required this.y,
    required this.radius,
    required this.speed,
    required this.opacity,
  });

  factory _Particle.random(Random random) {
    return _Particle(
      x: random.nextDouble(),
      y: random.nextDouble(),
      radius: random.nextDouble() * 2 + 0.5,
      speed: random.nextDouble() * 0.4 + 0.1,
      opacity: random.nextDouble() * 0.2 + 0.05,
    );
  }
}

class _ParticlePainter extends CustomPainter {
  final List<_Particle> particles;
  final double animationValue;
  final bool isDark;

  _ParticlePainter({
    required this.particles,
    required this.animationValue,
    required this.isDark,
  });

  @override
  void paint(Canvas canvas, Size size) {
    if (size.isEmpty) return;

    final paint = Paint()..style = PaintingStyle.fill;

    // Ambient orbs
    final orbs = [
      (0.1, 0.2, 300.0, AppColors.primary, 0.04),
      (0.9, 0.1, 250.0, AppColors.secondary, 0.03),
      (0.5, 0.8, 350.0, AppColors.accent, 0.02),
    ];
    for (final orb in orbs) {
      final dx = orb.$1 * size.width +
          sin(animationValue * 2 * pi + orb.$1 * 5) * 60;
      final dy = orb.$2 * size.height +
          cos(animationValue * 2 * pi + orb.$2 * 5) * 60;

      final shader = RadialGradient(
        colors: [
          orb.$4.withOpacity(orb.$5),
          orb.$4.withOpacity(0),
        ],
      ).createShader(
        Rect.fromCircle(center: Offset(dx, dy), radius: orb.$3),
      );

      paint.shader = shader;
      canvas.drawCircle(Offset(dx, dy), orb.$3, paint);
    }

    paint.shader = null;
    // Particles
    for (final p in particles) {
      final dx = (p.x * size.width +
              sin(animationValue * 2 * pi * p.speed + p.x * 10) * 30) %
          size.width;
      final dy = (p.y * size.height -
              animationValue * size.height * p.speed * 0.2) %
          size.height;

      paint.color = Colors.white.withOpacity(p.opacity);
      canvas.drawCircle(Offset(dx, dy), p.radius, paint);
    }
  }

  @override
  bool shouldRepaint(covariant _ParticlePainter oldDelegate) => true;
}

class _ParallaxOrb extends StatelessWidget {
  final double size;
  final Color color;

  const _ParallaxOrb({
    required this.size,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: RadialGradient(
          colors: [
            color,
            color.withOpacity(0),
          ],
        ),
      ),
    );
  }
}
