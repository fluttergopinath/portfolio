import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../core/constants/app_data.dart';
import '../../core/utils/responsive.dart';
import '../../widgets/glass_card.dart';

class ProjectDetailDialog extends StatelessWidget {
  final ProjectData project;

  const ProjectDetailDialog({super.key, required this.project});

  @override
  Widget build(BuildContext context) {
    final isMobile = Responsive.isMobile(context);
    final screenWidth = MediaQuery.of(context).size.width;
    final dialogWidth = isMobile ? screenWidth * 0.95 : 800.0;
    final accent = project.accentColor;

    return Center(
      child: Material(
        color: Colors.transparent,
        child: GlassCard(
          borderRadius: 32,
          padding: EdgeInsets.zero, // Remove padding to use full width for SingleChildScrollView
          child: SizedBox(
            width: dialogWidth,
            child: ConstrainedBox(
              constraints: BoxConstraints(
                maxHeight: MediaQuery.of(context).size.height * 0.85,
              ),
              child: SingleChildScrollView(
                padding: EdgeInsets.all(isMobile ? 24 : 48),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Header
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: 80,
                          height: 80,
                          decoration: BoxDecoration(
                            color: accent.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(
                              color: accent.withOpacity(0.2),
                            ),
                          ),
                          child: Center(
                            child: Text(
                              project.emoji,
                              style: const TextStyle(fontSize: 40),
                            ),
                          ),
                        ),
                        const SizedBox(width: 24),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                project.title,
                                style: Theme.of(context)
                                    .textTheme
                                    .headlineMedium
                                    ?.copyWith(
                                      fontWeight: FontWeight.w900,
                                      fontSize: isMobile ? 28 : 36,
                                      letterSpacing: -1,
                                    ),
                              ),
                              const SizedBox(height: 8),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 12, vertical: 6),
                                decoration: BoxDecoration(
                                  color: accent.withOpacity(0.1),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Text(
                                  project.subtitle.toUpperCase(),
                                  style: Theme.of(context)
                                      .textTheme
                                      .labelLarge
                                      ?.copyWith(
                                        color: accent,
                                        fontWeight: FontWeight.w800,
                                        letterSpacing: 1.5,
                                        fontSize: 11,
                                      ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        IconButton(
                          onPressed: () => Navigator.of(context).pop(),
                          icon: const Icon(Icons.close_rounded),
                          color: Colors.white.withOpacity(0.5),
                        ),
                      ],
                    ).animate().fadeIn(duration: 400.ms).slideX(begin: 0.1, end: 0),
                    const SizedBox(height: 48),

                    _DetailBlock(
                      title: 'PROJECT OVERVIEW',
                      icon: Icons.info_outline_rounded,
                      accent: accent,
                      child: Text(
                        project.description,
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                              height: 1.8,
                              color: Colors.white.withOpacity(0.7),
                            ),
                      ),
                    ),
                    const SizedBox(height: 40),

                    _DetailBlock(
                      title: 'KEY FEATURES & INNOVATIONS',
                      icon: Icons.auto_awesome_rounded,
                      accent: accent,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: project.features.asMap().entries.map((e) {
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 16),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  margin: const EdgeInsets.only(top: 8),
                                  width: 8,
                                  height: 8,
                                  decoration: BoxDecoration(
                                    color: accent,
                                    shape: BoxShape.circle,
                                    boxShadow: [
                                      BoxShadow(
                                        color: accent.withOpacity(0.5),
                                        blurRadius: 8,
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(width: 16),
                                Expanded(
                                  child: Text(
                                    e.value,
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyMedium
                                        ?.copyWith(
                                          height: 1.5,
                                          fontSize: 16,
                                          color: Colors.white.withOpacity(0.8),
                                        ),
                                  ),
                                ),
                              ],
                            ),
                          ).animate().fadeIn(delay: (200 + e.key * 100).ms).moveX(begin: 10, end: 0);
                        }).toList(),
                      ),
                    ),
                    const SizedBox(height: 40),

                    _DetailBlock(
                      title: 'SOLVING COMPLEX CHALLENGES',
                      icon: Icons.psychology_outlined,
                      accent: accent,
                      child: Container(
                        padding: const EdgeInsets.all(24),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.03),
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                            color: Colors.white.withOpacity(0.05),
                          ),
                        ),
                        child: Text(
                          project.challenges,
                          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                fontStyle: FontStyle.italic,
                                height: 1.6,
                                color: Colors.white.withOpacity(0.6),
                              ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 40),

                    _DetailBlock(
                      title: 'TECHNOLOGY STACK',
                      icon: Icons.code_rounded,
                      accent: accent,
                      child: Wrap(
                        spacing: 12,
                        runSpacing: 12,
                        children: project.techStack.map((tech) {
                          return Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 10),
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.05),
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(
                                color: Colors.white.withOpacity(0.1),
                              ),
                            ),
                            child: Text(
                              tech,
                              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                    color: accent,
                                    fontWeight: FontWeight.w700,
                                    fontSize: 13,
                                  ),
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    ).animate().fadeIn(duration: 400.ms).scale(begin: const Offset(0.9, 0.9), end: const Offset(1, 1));
  }
}

class _DetailBlock extends StatelessWidget {
  final String title;
  final IconData icon;
  final Color accent;
  final Widget child;

  const _DetailBlock({
    required this.title,
    required this.icon,
    required this.accent,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(icon, color: accent, size: 20),
            const SizedBox(width: 12),
            Text(
              title,
              style: Theme.of(context).textTheme.labelLarge?.copyWith(
                    fontWeight: FontWeight.w900,
                    letterSpacing: 2,
                    fontSize: 12,
                    color: Colors.white.withOpacity(0.4),
                  ),
            ),
          ],
        ),
        const SizedBox(height: 20),
        child,
      ],
    ).animate().fadeIn(delay: 200.ms, duration: 400.ms).slideY(begin: 0.05, end: 0);
  }
}
