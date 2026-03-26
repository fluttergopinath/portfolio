import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_strings.dart';
import '../../core/utils/responsive.dart';

class HeroSection extends StatelessWidget {
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
  Widget build(BuildContext context) {
    final isMobile = Responsive.isMobile(context);
    final screenHeight = MediaQuery.of(context).size.height;

    return ConstrainedBox(
      key: sectionKey,
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
          // Gradient overlay
          Positioned.fill(
            child: DecoratedBox(
              decoration: BoxDecoration(
                gradient: RadialGradient(
                  center: Alignment.topLeft,
                  radius: 1.5,
                  colors: [
                    AppColors.primary.withValues(alpha: 0.08),
                    Colors.transparent,
                  ],
                ),
              ),
            ),
          ),
          // Content
          Center(
            child: SizedBox(
              width: Responsive.contentWidth(context),
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(
                  horizontal: isMobile ? 20 : 40,
                  vertical: 60,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment:
                      isMobile ? CrossAxisAlignment.center : CrossAxisAlignment.start,
                  children: [
                    // Status badge
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      decoration: BoxDecoration(
                        color: AppColors.primary.withValues(alpha: 0.08),
                        borderRadius: BorderRadius.circular(30),
                        border: Border.all(
                          color: AppColors.primary.withValues(alpha: 0.15),
                        ),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                            width: 8,
                            height: 8,
                            decoration: BoxDecoration(
                              color: const Color(0xFF4ADE80),
                              shape: BoxShape.circle,
                              boxShadow: [
                                BoxShadow(
                                  color: const Color(0xFF4ADE80).withValues(alpha: 0.5),
                                  blurRadius: 6,
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(width: 8),
                          Text(
                            'Available for work',
                            style: Theme.of(context).textTheme.labelLarge?.copyWith(
                                  color: AppColors.primary,
                                  fontWeight: FontWeight.w500,
                                ),
                          ),
                        ],
                      ),
                    )
                        .animate()
                        .fadeIn(duration: 600.ms)
                        .slideY(begin: -0.5, end: 0, duration: 600.ms),
                    const SizedBox(height: 20),
                    // Name with gradient
                    ShaderMask(
                      shaderCallback: (bounds) =>
                          AppColors.primaryGradient.createShader(bounds),
                      child: Text(
                        AppStrings.name,
                        textAlign: isMobile ? TextAlign.center : TextAlign.left,
                        style: Theme.of(context).textTheme.displayLarge?.copyWith(
                              color: Colors.white,
                              fontSize: MediaQuery.of(context).size.width < 380 ? 32 : (isMobile ? 40 : 60),
                              letterSpacing: -1,
                              height: 1.1,
                            ),
                      ),
                    )
                        .animate()
                        .fadeIn(delay: 200.ms, duration: 600.ms)
                        .slideY(begin: 0.3, end: 0, duration: 600.ms),
                    const SizedBox(height: 8),
                    // Typing animation
                    SizedBox(
                      height: isMobile ? 32 : 44,
                      child: DefaultTextStyle(
                        style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                                  fontSize: MediaQuery.of(context).size.width < 380 ? 18 : (isMobile ? 20 : 28),
                                  fontWeight: FontWeight.w500,
                                ) ??
                            const TextStyle(),
                        child: AnimatedTextKit(
                          repeatForever: true,
                          pause: const Duration(milliseconds: 2000),
                          animatedTexts: [
                            TypewriterAnimatedText(
                              '> ${AppStrings.role}',
                              speed: const Duration(milliseconds: 70),
                            ),
                            TypewriterAnimatedText(
                              '> Clean Architecture Expert',
                              speed: const Duration(milliseconds: 70),
                            ),
                            TypewriterAnimatedText(
                              '> UI/UX Perfectionist',
                              speed: const Duration(milliseconds: 70),
                            ),
                            TypewriterAnimatedText(
                              '> Mobile App Innovator',
                              speed: const Duration(milliseconds: 70),
                            ),
                          ],
                        ),
                      ),
                    )
                        .animate()
                        .fadeIn(delay: 500.ms, duration: 600.ms),
                    const SizedBox(height: 14),
                    // Subtitle
                    SizedBox(
                      width: isMobile ? double.infinity : 560,
                      child: Text(
                        AppStrings.heroSubtitle,
                        textAlign: isMobile ? TextAlign.center : TextAlign.left,
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                              height: 1.8,
                              fontSize: isMobile ? 14 : 16,
                            ),
                      ),
                    )
                        .animate()
                        .fadeIn(delay: 700.ms, duration: 600.ms)
                        .slideY(begin: 0.2, end: 0, duration: 600.ms),
                    const SizedBox(height: 28),
                    // CTA Buttons
                    Wrap(
                      alignment: isMobile ? WrapAlignment.center : WrapAlignment.start,
                      spacing: 16,
                      runSpacing: 12,
                      children: [
                        _GradientButton(
                          label: 'View Projects',
                          icon: Icons.rocket_launch_rounded,
                          onTap: onViewProjects,
                        ),
                        _OutlineButton(
                          label: 'Contact Me',
                          icon: Icons.mail_outline_rounded,
                          onTap: onContactMe,
                        ),
                      ],
                    )
                        .animate()
                        .fadeIn(delay: 900.ms, duration: 600.ms)
                        .slideY(begin: 0.3, end: 0, duration: 600.ms),
                    const SizedBox(height: 36),
                    // Stats row
                    _StatsRow(isMobile: isMobile),
                  ],
                ),
              ),
            ),
          ),
          // Scroll indicator
          Positioned(
            bottom: 30,
            left: 0,
            right: 0,
            child: Center(
              child: Column(
                children: [
                  Text(
                    'Scroll to explore',
                    style: Theme.of(context).textTheme.labelLarge?.copyWith(
                          fontSize: 12,
                        ),
                  ),
                  const SizedBox(height: 8),
                  Icon(
                    Icons.keyboard_arrow_down_rounded,
                    color: AppColors.primary.withValues(alpha: 0.6),
                    size: 24,
                  ),
                ],
              )
                  .animate(onPlay: (c) => c.repeat(reverse: true))
                  .slideY(begin: 0, end: 0.3, duration: 1200.ms),
            ),
          )
              .animate()
              .fadeIn(delay: 1500.ms, duration: 800.ms),
        ],
      ),
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
      (AppStrings.statClients, AppStrings.statClientsLabel),
    ];

    return Wrap(
      alignment: isMobile ? WrapAlignment.center : WrapAlignment.start,
      spacing: isMobile ? 24 : 40,
      runSpacing: 20,
      children: stats.asMap().entries.map((entry) {
        return _StatItem(
          value: entry.value.$1,
          label: entry.value.$2,
          isMobile: isMobile,
          delay: 1100 + entry.key * 100,
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
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        ShaderMask(
          shaderCallback: (bounds) =>
              AppColors.primaryGradient.createShader(bounds),
          child: Text(
            value,
            style: Theme.of(context).textTheme.displaySmall?.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.w800,
                  fontSize: isMobile ? 26 : 32,
                ),
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.labelLarge?.copyWith(
                fontSize: 12,
                height: 1.3,
              ),
        ),
      ],
    )
        .animate()
        .fadeIn(delay: Duration(milliseconds: delay), duration: 500.ms)
        .slideY(
          begin: 0.3,
          end: 0,
          delay: Duration(milliseconds: delay),
          duration: 500.ms,
        );
  }
}

// ─── Buttons ───
class _GradientButton extends StatefulWidget {
  final String label;
  final IconData icon;
  final VoidCallback onTap;

  const _GradientButton({
    required this.label,
    required this.icon,
    required this.onTap,
  });

  @override
  State<_GradientButton> createState() => _GradientButtonState();
}

class _GradientButtonState extends State<_GradientButton> {
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
          padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 16),
          decoration: BoxDecoration(
            gradient: AppColors.primaryGradient,
            borderRadius: BorderRadius.circular(14),
            boxShadow: _isHovered
                ? [
                    BoxShadow(
                      color: AppColors.primary.withValues(alpha: 0.45),
                      blurRadius: 24,
                      offset: const Offset(0, 8),
                    ),
                  ]
                : [
                    BoxShadow(
                      color: AppColors.primary.withValues(alpha: 0.2),
                      blurRadius: 12,
                      offset: const Offset(0, 4),
                    ),
                  ],
          ),
          transform: _isHovered
              ? (Matrix4.identity()..translate(0.0, -3.0, 0.0))
              : Matrix4.identity(),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(widget.icon, color: Colors.white, size: 18),
              const SizedBox(width: 10),
              Text(
                widget.label,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _OutlineButton extends StatefulWidget {
  final String label;
  final IconData icon;
  final VoidCallback onTap;

  const _OutlineButton({
    required this.label,
    required this.icon,
    required this.onTap,
  });

  @override
  State<_OutlineButton> createState() => _OutlineButtonState();
}

class _OutlineButtonState extends State<_OutlineButton> {
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
          padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 16),
          decoration: BoxDecoration(
            color: _isHovered
                ? AppColors.primary.withValues(alpha: 0.1)
                : Colors.transparent,
            borderRadius: BorderRadius.circular(14),
            border: Border.all(
              color: _isHovered
                  ? AppColors.primary
                  : AppColors.primary.withValues(alpha: 0.4),
              width: 1.5,
            ),
          ),
          transform: _isHovered
              ? (Matrix4.identity()..translate(0.0, -3.0, 0.0))
              : Matrix4.identity(),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(widget.icon,
                  color: AppColors.primary, size: 18),
              const SizedBox(width: 10),
              Text(
                widget.label,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: AppColors.primary,
                      fontWeight: FontWeight.w600,
                    ),
              ),
            ],
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
    _particles = List.generate(40, (_) => _Particle.random(_random));
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
      radius: random.nextDouble() * 3 + 1,
      speed: random.nextDouble() * 0.5 + 0.2,
      opacity: random.nextDouble() * 0.3 + 0.05,
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

    // Draw gradient orbs
    final orbPaint = Paint()..style = PaintingStyle.fill;

    // Big ambient orbs
    final orbs = [
      (0.1, 0.25, 220.0, AppColors.primary, 0.06),
      (0.8, 0.15, 180.0, AppColors.accent, 0.04),
      (0.45, 0.75, 250.0, AppColors.primary, 0.03),
      (0.9, 0.8, 150.0, AppColors.accent, 0.05),
    ];

    for (final orb in orbs) {
      final dx = orb.$1 * size.width +
          sin(animationValue * 2 * pi + orb.$1 * 4) * 40;
      final dy = orb.$2 * size.height +
          cos(animationValue * 2 * pi + orb.$2 * 4) * 40;

      orbPaint.shader = RadialGradient(
        colors: [
          orb.$4.withValues(alpha: orb.$5),
          orb.$4.withValues(alpha: 0),
        ],
      ).createShader(
        Rect.fromCircle(center: Offset(dx, dy), radius: orb.$3),
      );

      canvas.drawCircle(Offset(dx, dy), orb.$3, orbPaint);
    }

    // Draw particles
    for (final p in particles) {
      final dx = (p.x * size.width +
              sin(animationValue * 2 * pi * p.speed + p.x * 10) * 20) %
          size.width;
      final dy = (p.y * size.height -
              animationValue * size.height * p.speed * 0.3) %
          size.height;

      paint.color = (isDark ? Colors.white : AppColors.primary)
          .withValues(alpha: p.opacity);
      canvas.drawCircle(Offset(dx, dy), p.radius, paint);
    }
  }

  @override
  bool shouldRepaint(covariant _ParticlePainter oldDelegate) =>
      oldDelegate.animationValue != animationValue;
}
