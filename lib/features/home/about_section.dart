import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_data.dart';
import '../../core/constants/app_strings.dart';
import '../../core/utils/responsive.dart';

import '../../widgets/glass_card.dart';

class AboutSection extends StatelessWidget {
  final GlobalKey sectionKey;

  const AboutSection({super.key, required this.sectionKey});

  @override
  Widget build(BuildContext context) {
    final isMobile = Responsive.isMobile(context);

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
                title: AppStrings.aboutTitle,
                subtitle: 'A BLEND OF ART AND CODE',
              ),
              const SizedBox(height: 80),
              // About Content Grid
              isMobile
                  ? Column(
                      children: [
                        const _AvatarCard(),
                        const SizedBox(height: 48),
                        const _AboutContent(),
                      ],
                    )
                  : Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Expanded(
                          flex: 4,
                          child: _AvatarCard(),
                        ),
                        const SizedBox(width: 64),
                        const Expanded(
                          flex: 6,
                          child: _AboutContent(),
                        ),
                      ],
                    ),
              const SizedBox(height: 100),
              // Journey / Experience Header
              const _SectionHeader(
                title: AppStrings.experienceTitle,
                subtitle: 'MY PROFESSIONAL MILESTONES',
              ),
              const SizedBox(height: 60),
              // Experience List
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

class _AvatarCard extends StatefulWidget {
  const _AvatarCard();

  @override
  State<_AvatarCard> createState() => _AvatarCardState();
}

class _AvatarCardState extends State<_AvatarCard> {
  @override
  Widget build(BuildContext context) {
    final isMobile = Responsive.isMobile(context);

    return GlassCard(
      borderRadius: 32,
      padding: const EdgeInsets.all(32),
      child: Column(
          children: [
            // Profile Image Placeholder with Neon Ring
            Container(
              padding: const EdgeInsets.all(4),
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                gradient: AppColors.primaryGradient,
              ),
              child: Container(
                width: isMobile ? 120 : 160,
                height: isMobile ? 120 : 160,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.darkBackground,
                ),
                child: Center(
                  child: ShaderMask(
                    shaderCallback: (bounds) =>
                        AppColors.primaryGradient.createShader(bounds),
                    child: Text(
                      'G',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: isMobile ? 48 : 64,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 32),
            Text(
              AppStrings.name,
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.w900,
                    fontSize: 24,
                  ),
            ),
            const SizedBox(height: 8),
            Text(
              AppStrings.role.toUpperCase(),
              style: Theme.of(context).textTheme.labelLarge?.copyWith(
                    color: Colors.white.withOpacity(0.5),
                    letterSpacing: 2,
                    fontSize: 12,
                  ),
            ),
            const SizedBox(height: 32),
            // Social Links / Quick Stats in a row
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _SocialIcon(Icons.code_rounded, () {}),
                const SizedBox(width: 16),
                _SocialIcon(Icons.link_rounded, () {}),
                const SizedBox(width: 16),
                _SocialIcon(Icons.mail_outline_rounded, () {}),
              ],
            ),
          ],
        ),
    ).animate().fadeIn(duration: 800.ms).slideX(begin: -0.1, end: 0);
  }
}

class _SocialIcon extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;
  const _SocialIcon(this.icon, this.onTap);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.05),
        shape: BoxShape.circle,
        border: Border.all(color: Colors.white.withOpacity(0.1)),
      ),
      child: Icon(icon, color: Colors.white, size: 20),
    );
  }
}

class _AboutContent extends StatelessWidget {
  const _AboutContent();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          AppStrings.aboutDescription,
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                color: Colors.white.withOpacity(0.7),
                height: 1.8,
              ),
        ),
        const SizedBox(height: 48),
        const _InfoItem(
          icon: Icons.architecture_rounded,
          title: 'CLEAN ARCHITECTURE',
          desc: 'Building scalable and maintainable enterprise solutions.',
        ),
        const SizedBox(height: 24),
        const _InfoItem(
          icon: Icons.palette_outlined,
          title: 'PREMIUM UI/UX',
          desc: 'Focusing on micro-interactions and high-end aesthetics.',
        ),
        const SizedBox(height: 24),
        const _InfoItem(
          icon: Icons.bolt_rounded,
          title: 'PERFORMANCE FIRST',
          desc: 'Optimized renders and efficient state management.',
        ),
      ],
    ).animate().fadeIn(duration: 800.ms).slideX(begin: 0.1, end: 0);
  }
}

class _InfoItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final String desc;
  const _InfoItem({required this.icon, required this.title, required this.desc});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: AppColors.primary.withOpacity(0.1),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(icon, color: AppColors.primary, size: 24),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontSize: 16,
                      fontWeight: FontWeight.w800,
                      letterSpacing: 1,
                    ),
              ),
              const SizedBox(height: 4),
              Text(
                desc,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: Colors.white.withOpacity(0.5),
                    ),
              ),
            ],
          ),
        ),
      ],
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
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: IntrinsicHeight(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Timeline
            SizedBox(
              width: 60,
              child: Column(
                children: [
                  Container(
                    width: 16,
                    height: 16,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: _isHovered ? AppColors.secondary : AppColors.primary,
                      boxShadow: [
                        BoxShadow(
                          color: (_isHovered ? AppColors.secondary : AppColors.primary)
                              .withOpacity(0.5),
                          blurRadius: 10,
                        ),
                      ],
                    ),
                  ),
                  if (!widget.isLast)
                    Expanded(
                      child: Container(
                        width: 2,
                        margin: const EdgeInsets.symmetric(vertical: 8),
                        color: Colors.white.withOpacity(0.1),
                      ),
                    ),
                ],
              ),
            ),
            // Card
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(bottom: 48),
                child: GlassCard(
                  borderRadius: 24,
                  padding: const EdgeInsets.all(28),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Text(
                              widget.experience.role,
                              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                                    fontWeight: FontWeight.w900,
                                    fontSize: 20,
                                  ),
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 12, vertical: 6),
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.05),
                              borderRadius: BorderRadius.circular(100),
                            ),
                            child: Text(
                              widget.experience.duration,
                              style: Theme.of(context).textTheme.labelLarge?.copyWith(
                                    fontSize: 10,
                                    color: Colors.white.withOpacity(0.6),
                                  ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Text(
                        widget.experience.company.toUpperCase(),
                        style: Theme.of(context).textTheme.labelLarge?.copyWith(
                              color: AppColors.primary,
                              letterSpacing: 2,
                              fontWeight: FontWeight.w700,
                            ),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        widget.experience.description,
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              color: Colors.white.withOpacity(0.6),
                              height: 1.6,
                            ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    ).animate().fadeIn(delay: (200 * widget.index).ms).slideY(begin: 0.1, end: 0);
  }
}
