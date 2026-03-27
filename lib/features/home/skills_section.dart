import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_data.dart';
import '../../core/constants/app_strings.dart';
import '../../core/utils/responsive.dart';
import '../../widgets/glass_card.dart';
import '../../widgets/tilt_widget.dart';

class SkillsSection extends StatelessWidget {
  final GlobalKey sectionKey;

  const SkillsSection({super.key, required this.sectionKey});

  @override
  Widget build(BuildContext context) {
    return Container(
      key: sectionKey,
      width: double.infinity,
      padding: Responsive.sectionPadding(context),
      child: Center(
        child: SizedBox(
          width: Responsive.contentWidth(context),
          child: Column(
            children: [
              const _SectionHeader(
                title: AppStrings.skillsTitle,
                subtitle: 'PRECISION MEETS INNOVATION',
              ),
              const SizedBox(height: 80),
              LayoutBuilder(
                builder: (context, constraints) {
                  return GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                      maxCrossAxisExtent: constraints.maxWidth < 400 ? 180 : 220,
                      crossAxisSpacing: 24,
                      mainAxisSpacing: 24,
                      mainAxisExtent: 220,
                    ),
                    itemCount: SkillData.skills.length,
                    itemBuilder: (context, index) {
                      return _SkillCard(
                        skill: SkillData.skills[index],
                        index: index,
                      );
                    },
                  );
                },
              ),
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
        Text(
          subtitle,
          style: Theme.of(context).textTheme.labelLarge?.copyWith(
                color: AppColors.secondary,
                fontWeight: FontWeight.w800,
                letterSpacing: 4,
                fontSize: 10,
              ),
        ),
        const SizedBox(height: 12),
        Text(
          title.toUpperCase(),
          style: Theme.of(context).textTheme.displaySmall?.copyWith(
                fontWeight: FontWeight.w900,
                fontSize: Responsive.isMobile(context) ? 32 : 48,
                letterSpacing: -1,
              ),
        ),
        const SizedBox(height: 20),
        Container(
          width: 60,
          height: 4,
          decoration: BoxDecoration(
            gradient: AppColors.primaryGradient,
            borderRadius: BorderRadius.circular(2),
          ),
        ),
      ],
    ).animate().fadeIn(duration: 800.ms).slideY(begin: 0.2, end: 0);
  }
}

class _SkillCard extends StatefulWidget {
  final SkillData skill;
  final int index;

  const _SkillCard({
    required this.skill,
    required this.index,
  });

  @override
  State<_SkillCard> createState() => _SkillCardState();
}

class _SkillCardState extends State<_SkillCard> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: TiltWidget(
        maxTilt: 0.1,
        scale: 1.05,
        child: GlassCard(
          borderRadius: 24,
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Icon with Neon Glow on Hover
              AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: _isHovered
                      ? AppColors.primary.withOpacity(0.2)
                      : Colors.white.withOpacity(0.05),
                  shape: BoxShape.circle,
                  boxShadow: _isHovered
                      ? [
                          BoxShadow(
                            color: AppColors.primary.withOpacity(0.3),
                            blurRadius: 20,
                          ),
                        ]
                      : [],
                ),
                child: Icon(
                  widget.skill.icon,
                  color: _isHovered ? Colors.white : AppColors.primary,
                  size: 32,
                ),
              ),
              const SizedBox(height: 20),
              Text(
                widget.skill.name,
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontSize: 16,
                      fontWeight: FontWeight.w800,
                    ),
              ),
              const SizedBox(height: 4),
              Text(
                widget.skill.category.toUpperCase(),
                style: Theme.of(context).textTheme.labelLarge?.copyWith(
                      fontSize: 10,
                      color: Colors.white.withOpacity(0.4),
                      letterSpacing: 1,
                    ),
              ),
              const SizedBox(height: 16),
              // Level indicator - Minimal neon bar
              Stack(
                children: [
                  Container(
                    height: 4,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.05),
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                  FractionallySizedBox(
                    widthFactor: widget.skill.level,
                    child: Container(
                      height: 4,
                      decoration: BoxDecoration(
                        gradient: AppColors.primaryGradient,
                        borderRadius: BorderRadius.circular(2),
                        boxShadow: [
                          BoxShadow(
                            color: AppColors.primary.withOpacity(0.3),
                            blurRadius: 4,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                    ),
                  ).animate().scaleX(
                        begin: 0,
                        end: 1,
                        duration: 1200.ms,
                        curve: Curves.easeOutCubic,
                        delay: (200 + widget.index * 100).ms,
                      ),
                ],
              ),
            ],
          ),
        ),
      ),
    ).animate().fadeIn(delay: (widget.index * 100).ms).slideY(begin: 0.2, end: 0);
  }
}
