import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_data.dart';
import '../../core/constants/app_strings.dart';
import '../../core/utils/responsive.dart';
import '../../widgets/glass_card.dart';
import '../../widgets/tilt_widget.dart';

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
              const SizedBox(height: 100),
              
              // Main Content
              if (isMobile)
                Column(
                  children: [
                    const _AvatarCard(),
                    const SizedBox(height: 64),
                    const _AboutContent(),
                  ],
                )
              else
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Expanded(
                      flex: 4,
                      child: _AvatarCard(),
                    ),
                    const SizedBox(width: 80),
                    const Expanded(
                      flex: 6,
                      child: _AboutContent(),
                    ),
                  ],
                ),
                
              const SizedBox(height: 140),
              
              // Experience Section
              const _SectionHeader(
                title: AppStrings.experienceTitle,
                subtitle: 'MY PROFESSIONAL JOURNEY',
              ),
              const SizedBox(height: 80),
              
              ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 900),
                child: Column(
                  children: ExperienceData.experiences.asMap().entries.map((entry) {
                    return _ExperienceCard(
                      experience: entry.value,
                      index: entry.key,
                      isLast: entry.key == ExperienceData.experiences.length - 1,
                    );
                  }).toList(),
                ),
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
          style: GoogleFonts.outfit(
            color: AppColors.secondary,
            fontWeight: FontWeight.w800,
            letterSpacing: 6,
            fontSize: 12,
          ),
        ),
        const SizedBox(height: 24),
        Text(
          title.toUpperCase(),
          style: GoogleFonts.outfit(
            fontWeight: FontWeight.w900,
            letterSpacing: -2,
            fontSize: Responsive.isMobile(context) ? 36 : 56,
            color: Colors.white,
          ),
        ),
        const SizedBox(height: 32),
        Container(
          width: 80,
          height: 4,
          decoration: BoxDecoration(
            gradient: AppColors.premiumGradient,
            borderRadius: BorderRadius.circular(2),
            boxShadow: [
              BoxShadow(
                color: AppColors.primary.withOpacity(0.5),
                blurRadius: 15,
              ),
            ],
          ),
        ),
      ],
    ).animate().fadeIn(duration: 800.ms).slideY(begin: 0.2, end: 0);
  }
}

class _AvatarCard extends StatelessWidget {
  const _AvatarCard();

  @override
  Widget build(BuildContext context) {
    return TiltWidget(
      maxTilt: 0.1,
      child: GlassCard(
        borderRadius: 40,
        padding: const EdgeInsets.all(40),
        child: Column(
          children: [
            // Profile Image with Complex Glow
            Stack(
              alignment: Alignment.center,
              children: [
                Container(
                  width: 220,
                  height: 220,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: AppColors.premiumGradient,
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.primary.withOpacity(0.3),
                        blurRadius: 40,
                        spreadRadius: 5,
                      ),
                    ],
                  ),
                ),
                Container(
                  width: 204,
                  height: 204,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Color(0xFF0A0A0A),
                  ),
                  child: ClipOval(
                    child: Image.asset(
                      'assets/images/avatar.png',
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ],
            ).animate().scale(duration: 800.ms, curve: Curves.easeOutBack),
            
            const SizedBox(height: 40),
            
            Text(
              AppStrings.name,
              textAlign: TextAlign.center,
              style: GoogleFonts.outfit(
                fontWeight: FontWeight.w900,
                fontSize: 32,
                letterSpacing: -1,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              AppStrings.role.toUpperCase(),
              style: GoogleFonts.outfit(
                color: AppColors.primary,
                letterSpacing: 4,
                fontSize: 12,
                fontWeight: FontWeight.w800,
              ),
            ),
            
            const SizedBox(height: 40),
            
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _SocialIcon(Icons.terminal_rounded),
                const SizedBox(width: 20),
                _SocialIcon(Icons.alternate_email_rounded),
                const SizedBox(width: 20),
                _SocialIcon(Icons.workspace_premium_rounded),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _SocialIcon extends StatefulWidget {
  final IconData icon;
  const _SocialIcon(this.icon);

  @override
  State<_SocialIcon> createState() => _SocialIconState();
}

class _SocialIconState extends State<_SocialIcon> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedContainer(
        duration: 300.ms,
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: _isHovered ? Colors.white.withOpacity(0.1) : Colors.white.withOpacity(0.03),
          shape: BoxShape.circle,
          border: Border.all(
            color: _isHovered ? Colors.white.withOpacity(0.3) : Colors.white.withOpacity(0.1),
          ),
        ),
        child: Icon(widget.icon, color: Colors.white, size: 22),
      ),
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
          'ARCHITECTING DIGITAL\nEXPERIENCES.',
          style: GoogleFonts.outfit(
            fontSize: 44,
            fontWeight: FontWeight.w900,
            height: 1.1,
            letterSpacing: -1,
          ),
        ),
        const SizedBox(height: 32),
        Text(
          AppStrings.aboutDescription,
          style: GoogleFonts.outfit(
            color: Colors.white.withOpacity(0.6),
            fontSize: 18,
            height: 1.8,
          ),
        ),
        const SizedBox(height: 48),
        
        const _HighlightItem(
          icon: Icons.auto_awesome_rounded,
          title: 'CUTTING-EDGE STACK',
          desc: 'Leveraging Flutter & Dart to build high-performance, native-quality web and mobile applications.',
        ),
        const SizedBox(height: 32),
        const _HighlightItem(
          icon: Icons.layers_rounded,
          title: 'SCALABLE ARCHITECTURE',
          desc: 'Implementing Clean Architecture and robust state management for maintainable, enterprise-grade code.',
        ),
        const SizedBox(height: 32),
        const _HighlightItem(
          icon: Icons.touch_app_rounded,
          title: 'USER-CENTRIC DESIGN',
          desc: 'Focusing on micro-interactions and premium aesthetics to create unforgettable user journeys.',
        ),
      ],
    ).animate().fadeIn(duration: 800.ms).slideX(begin: 0.1, end: 0);
  }
}

class _HighlightItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final String desc;
  const _HighlightItem({required this.icon, required this.title, required this.desc});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: AppColors.primary.withOpacity(0.1),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: AppColors.primary.withOpacity(0.2)),
          ),
          child: Icon(icon, color: AppColors.primary, size: 28),
        ),
        const SizedBox(width: 24),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: GoogleFonts.outfit(
                  fontSize: 16,
                  fontWeight: FontWeight.w900,
                  letterSpacing: 2,
                  color: AppColors.secondary,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                desc,
                style: GoogleFonts.outfit(
                  color: Colors.white.withOpacity(0.5),
                  fontSize: 15,
                  height: 1.5,
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
            // Timeline Rail
            SizedBox(
              width: 80,
              child: Column(
                children: [
                  AnimatedContainer(
                    duration: 300.ms,
                    width: 20,
                    height: 20,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: _isHovered ? AppColors.primary : Colors.transparent,
                      border: Border.all(
                        color: AppColors.primary,
                        width: 4,
                      ),
                      boxShadow: [
                        if (_isHovered)
                          BoxShadow(
                            color: AppColors.primary.withOpacity(0.5),
                            blurRadius: 15,
                            spreadRadius: 2,
                          ),
                      ],
                    ),
                  ),
                  if (!widget.isLast)
                    Expanded(
                      child: Container(
                        width: 2,
                        margin: const EdgeInsets.symmetric(vertical: 12),
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              AppColors.primary.withOpacity(0.5),
                              AppColors.primary.withOpacity(0.05),
                            ],
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ),
            
            // Experience Details
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(bottom: 64),
                child: GlassCard(
                  borderRadius: 32,
                  padding: const EdgeInsets.all(40),
                  opacity: _isHovered ? 0.08 : 0.04,
                  borderColor: _isHovered ? AppColors.primary.withOpacity(0.3) : null,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Text(
                              widget.experience.role,
                              style: GoogleFonts.outfit(
                                fontWeight: FontWeight.w900,
                                fontSize: 24,
                                letterSpacing: -0.5,
                              ),
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.05),
                              borderRadius: BorderRadius.circular(100),
                            ),
                            child: Text(
                              widget.experience.duration,
                              style: GoogleFonts.outfit(
                                fontSize: 10,
                                fontWeight: FontWeight.w800,
                                letterSpacing: 1,
                                color: AppColors.secondary,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      Text(
                        widget.experience.company.toUpperCase(),
                        style: GoogleFonts.outfit(
                          color: Colors.white.withOpacity(0.4),
                          letterSpacing: 4,
                          fontSize: 12,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(height: 24),
                      Text(
                        widget.experience.description,
                        style: GoogleFonts.outfit(
                          color: Colors.white.withOpacity(0.6),
                          fontSize: 16,
                          height: 1.7,
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
    ).animate().fadeIn(delay: (widget.index * 150).ms).slideX(begin: 0.1, end: 0);
  }
}

