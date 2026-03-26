import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_data.dart';
import '../../core/constants/app_strings.dart';
import '../../core/utils/responsive.dart';

class AboutSection extends StatelessWidget {
  final GlobalKey sectionKey;

  const AboutSection({super.key, required this.sectionKey});

  @override
  Widget build(BuildContext context) {
    final isMobile = Responsive.isMobile(context);
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      key: sectionKey,
      width: double.infinity,
      padding: Responsive.sectionPadding(context),
      child: Center(
        child: SizedBox(
          width: Responsive.contentWidth(context),
          child: Column(
            children: [
              _SectionHeader(
                title: AppStrings.aboutTitle,
                subtitle: 'Get to know me better',
              ),
              const SizedBox(height: 60),
              // About Content
              isMobile
                  ? Column(
                      children: [
                        _AvatarCard(isDark: isDark),
                        const SizedBox(height: 40),
                        _AboutContent(isDark: isDark),
                      ],
                    )
                  : Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          flex: 4,
                          child: _AvatarCard(isDark: isDark),
                        ),
                        const SizedBox(width: 50),
                        Expanded(
                          flex: 6,
                          child: _AboutContent(isDark: isDark),
                        ),
                      ],
                    ),
              const SizedBox(height: 60),
              // Experience Timeline
              _SectionHeader(
                title: AppStrings.experienceTitle,
                subtitle: 'My professional journey',
              ),
              const SizedBox(height: 40),
              ...ExperienceData.experiences.asMap().entries.map((entry) {
                return _ExperienceCard(
                  experience: entry.value,
                  index: entry.key,
                  isLast: entry.key == ExperienceData.experiences.length - 1,
                );
              }),
            ],
          ),
        ),
      ),
    );
  }
}

class _SectionHeader extends StatelessWidget {
  final String title;
  final String subtitle;
  const _SectionHeader({required this.title, required this.subtitle});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(title, style: Theme.of(context).textTheme.displaySmall),
        const SizedBox(height: 8),
        Container(
          width: 50,
          height: 3,
          decoration: BoxDecoration(
            gradient: AppColors.primaryGradient,
            borderRadius: BorderRadius.circular(2),
          ),
        ),
        const SizedBox(height: 12),
        Text(
          subtitle,
          style: Theme.of(context).textTheme.bodyMedium,
        ),
      ],
    )
        .animate()
        .fadeIn(duration: 600.ms)
        .slideY(begin: 0.3, end: 0, duration: 600.ms);
  }
}

class _AvatarCard extends StatefulWidget {
  final bool isDark;
  const _AvatarCard({required this.isDark});

  @override
  State<_AvatarCard> createState() => _AvatarCardState();
}

class _AvatarCardState extends State<_AvatarCard> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeOutCubic,
        transform: _isHovered
            ? (Matrix4.identity()..scale(1.02))
            : Matrix4.identity(),
        child: Container(
          padding: const EdgeInsets.all(3),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(24),
            gradient: _isHovered ? AppColors.primaryGradient : null,
            border: _isHovered
                ? null
                : Border.all(
                    color: AppColors.primary.withValues(alpha: 0.15),
                    width: 1.5,
                  ),
          ),
          child: Container(
            constraints: BoxConstraints(
              minHeight: Responsive.isMobile(context) ? 320 : 380,
            ),
            padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 16),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(22),
              color: widget.isDark ? AppColors.darkCard : AppColors.lightCard,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Avatar circle with gradient ring
                Container(
                  padding: const EdgeInsets.all(4),
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: AppColors.primaryGradient,
                  ),
                  child: Container(
                    width: 120,
                    height: 120,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: widget.isDark
                          ? AppColors.darkCard
                          : AppColors.lightCard,
                    ),
                    child: Center(
                      child: ShaderMask(
                        shaderCallback: (bounds) =>
                            AppColors.primaryGradient.createShader(bounds),
                        child: const Text(
                          'G',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 48,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                Text(
                  AppStrings.name,
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontSize: Responsive.isMobile(context) ? 20 : 22,
                      ),
                ),
                const SizedBox(height: 6),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                  decoration: BoxDecoration(
                    color: AppColors.primary.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    AppStrings.role,
                    style: Theme.of(context).textTheme.labelLarge?.copyWith(
                          color: AppColors.primary,
                          fontWeight: FontWeight.w600,
                        ),
                  ),
                ),
                const SizedBox(height: 24),
                // Quick info chips
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  alignment: WrapAlignment.center,
                  children: ['🎯 Flutter', '🔥 Dart', '☁️ Firebase'].map((s) {
                    return Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 6),
                      decoration: BoxDecoration(
                        color: AppColors.primary.withValues(alpha: 0.05),
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(
                          color: AppColors.primary.withValues(alpha: 0.1),
                        ),
                      ),
                      child: Text(
                        s,
                        style: Theme.of(context).textTheme.labelLarge?.copyWith(
                              fontSize: 12,
                            ),
                      ),
                    );
                  }).toList(),
                ),
              ],
            ),
          ),
        ),
      ),
    )
        .animate()
        .fadeIn(delay: 200.ms, duration: 600.ms)
        .slideX(begin: -0.15, end: 0, duration: 600.ms);
  }
}

class _AboutContent extends StatelessWidget {
  final bool isDark;
  const _AboutContent({required this.isDark});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          AppStrings.aboutDescription,
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                fontSize: Responsive.isMobile(context) ? 14 : 16,
              ),
        ),
        const SizedBox(height: 28),
        _InfoRow(
          icon: Icons.work_outline_rounded,
          label: 'Experience',
          value: AppStrings.aboutExperience,
          color: AppColors.primary,
        ),
        const SizedBox(height: 14),
        _InfoRow(
          icon: Icons.auto_awesome_rounded,
          label: 'Specialization',
          value: AppStrings.aboutSpecialization,
          color: AppColors.accent,
        ),
        const SizedBox(height: 14),
        _InfoRow(
          icon: Icons.location_on_outlined,
          label: 'Location',
          value: 'India',
          color: const Color(0xFF66BB6A),
        ),
      ],
    )
        .animate()
        .fadeIn(delay: 400.ms, duration: 600.ms)
        .slideX(begin: 0.15, end: 0, duration: 600.ms);
  }
}

class _InfoRow extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  final Color color;

  const _InfoRow({
    required this.icon,
    required this.label,
    required this.value,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: color.withValues(alpha: 0.1)),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(icon, color: color, size: 20),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: Theme.of(context).textTheme.labelLarge?.copyWith(
                        color: color,
                        fontWeight: FontWeight.w600,
                      ),
                ),
                const SizedBox(height: 2),
                Text(value, style: Theme.of(context).textTheme.bodyMedium),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _ExperienceCard extends StatefulWidget {
  final ExperienceData experience;
  final int index;
  final bool isLast;

  const _ExperienceCard({
    required this.experience,
    required this.index,
    required this.isLast,
  });

  @override
  State<_ExperienceCard> createState() => _ExperienceCardState();
}

class _ExperienceCardState extends State<_ExperienceCard> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final isMobile = Responsive.isMobile(context);
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final content = Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Timeline line + dot
        SizedBox(
          width: 40,
          child: Column(
            children: [
              Container(
                width: 14,
                height: 14,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: AppColors.primaryGradient,
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.primary.withValues(alpha: 0.3),
                      blurRadius: 8,
                    ),
                  ],
                ),
              ),
              if (!widget.isLast)
                Container(
                  width: 2,
                  height: 100, // Small line on mobile, will be expanded by layout or just fixed
                  constraints: const BoxConstraints(minHeight: 40),
                  color: AppColors.primary.withValues(alpha: 0.15),
                ),
            ],
          ),
        ),
        const SizedBox(width: 16),
        // Card
        Expanded(
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            margin: const EdgeInsets.only(bottom: 24),
            padding: const EdgeInsets.all(22),
            decoration: BoxDecoration(
              color: isDark
                  ? AppColors.darkCard.withValues(alpha: _isHovered ? 0.9 : 0.5)
                  : AppColors.lightCard.withValues(alpha: _isHovered ? 1 : 0.7),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: _isHovered
                    ? AppColors.primary.withValues(alpha: 0.3)
                    : AppColors.primary.withValues(alpha: 0.05),
              ),
              boxShadow: _isHovered
                  ? [
                      BoxShadow(
                        color: AppColors.primary.withValues(alpha: 0.08),
                        blurRadius: 20,
                        offset: const Offset(0, 6),
                      ),
                    ]
                  : [],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(
                      widget.experience.icon,
                      color: AppColors.primary,
                      size: 22,
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        widget.experience.role,
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                              fontSize: isMobile ? 16 : 17,
                            ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Wrap(
                  spacing: 12,
                  runSpacing: 8,
                  children: [
                    Text(
                      widget.experience.company,
                      style: Theme.of(context).textTheme.labelLarge?.copyWith(
                            color: AppColors.primary,
                          ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 4),
                      decoration: BoxDecoration(
                        color: AppColors.primary.withValues(alpha: 0.08),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Text(
                        widget.experience.duration,
                        style: Theme.of(context).textTheme.labelLarge?.copyWith(
                              fontSize: 11,
                              color: AppColors.primary,
                            ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Text(
                  widget.experience.description,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ],
            ),
          ),
        ),
      ],
    );

    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: content, // Removed IntrinsicHeight which caused overflows on some screens
    )
        .animate()
        .fadeIn(
          delay: Duration(milliseconds: 200 + widget.index * 200),
          duration: 500.ms,
        )
        .slideX(
          begin: 0.1,
          end: 0,
          delay: Duration(milliseconds: 200 + widget.index * 200),
          duration: 500.ms,
        );
  }
}
