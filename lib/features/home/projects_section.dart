import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_data.dart';
import '../../core/constants/app_strings.dart';
import '../../core/utils/responsive.dart';
import '../projects/project_detail_dialog.dart';
import '../../widgets/glass_card.dart';
import '../../widgets/tilt_widget.dart';

class ProjectsSection extends StatelessWidget {
  final GlobalKey sectionKey;

  const ProjectsSection({super.key, required this.sectionKey});

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
                title: AppStrings.projectsTitle,
                subtitle: 'SHOWCASING RECENT VENTURES',
              ),
              const SizedBox(height: 100),
              LayoutBuilder(
                builder: (context, constraints) {
                  return GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: isMobile ? 1 : 2,
                      crossAxisSpacing: 48,
                      mainAxisSpacing: 48,
                      childAspectRatio: isMobile ? 0.9 : 1.0,
                    ),
                    itemCount: ProjectData.projects.length,
                    itemBuilder: (context, index) {
                      return _ProjectCard(
                        project: ProjectData.projects[index],
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
                letterSpacing: 6,
                fontSize: 12,
              ),
        ),
        const SizedBox(height: 24),
        Text(
          title.toUpperCase(),
          style: Theme.of(context).textTheme.displayMedium?.copyWith(
                fontWeight: FontWeight.w900,
                letterSpacing: -2,
              ),
        ),
        const SizedBox(height: 32),
        Container(
          width: 80,
          height: 4,
          decoration: BoxDecoration(
            gradient: AppColors.premiumGradient,
            borderRadius: BorderRadius.circular(2),
          ),
        ),
      ],
    ).animate().fadeIn(duration: 800.ms).slideY(begin: 0.2, end: 0);
  }
}

class _ProjectCard extends StatefulWidget {
  final ProjectData project;
  final int index;

  const _ProjectCard({required this.project, required this.index});

  @override
  State<_ProjectCard> createState() => _ProjectCardState();
}

class _ProjectCardState extends State<_ProjectCard> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final accent = widget.project.accentColor;

    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () => _showProjectDetail(context),
        child: TiltWidget(
          maxTilt: 0.1,
          scale: 1.05,
          child: GlassCard(
            borderRadius: 40,
            padding: EdgeInsets.zero,
            opacity: _isHovered ? 0.1 : 0.05,
            borderColor: _isHovered ? accent.withOpacity(0.5) : null,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Project Visual with Layered Depth
                Expanded(
                  flex: 6,
                  child: Stack(
                    children: [
                      // Gradient Background
                      Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              accent.withOpacity(0.2),
                              AppColors.primary.withOpacity(0.05),
                            ],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                          borderRadius: const BorderRadius.vertical(
                            top: Radius.circular(40),
                          ),
                        ),
                      ),
                      // Floating Visual Element
                      Center(
                        child: Transform(
                          transform: Matrix4.identity()
                            ..translate(0.0, _isHovered ? -10.0 : 0.0)
                            ..setEntry(3, 2, 0.001),
                          child: Container(
                            width: 140,
                            height: 140,
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.05),
                              shape: BoxShape.circle,
                              boxShadow: [
                                BoxShadow(
                                  color: accent.withOpacity(0.2),
                                  blurRadius: 40,
                                  spreadRadius: 5,
                                ),
                              ],
                            ),
                            child: Center(
                              child: Text(
                                widget.project.emoji,
                                style: const TextStyle(fontSize: 64),
                              ),
                            ),
                          ),
                        ).animate(target: _isHovered ? 1 : 0).scale(
                              begin: const Offset(1, 1),
                              end: const Offset(1.2, 1.2),
                              duration: 500.ms,
                              curve: Curves.easeOutBack,
                            ),
                      ),
                    ],
                  ),
                ),
                // Content Layer
                Expanded(
                  flex: 4,
                  child: Padding(
                    padding: EdgeInsets.all(Responsive.isMobile(context) ? 20 : 40),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          widget.project.title,
                          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                                fontWeight: FontWeight.w900,
                                fontSize: 28,
                                letterSpacing: -0.5,
                              ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          widget.project.subtitle.toUpperCase(),
                          style: Theme.of(context).textTheme.labelLarge?.copyWith(
                                color: accent,
                                letterSpacing: 3,
                                fontWeight: FontWeight.w800,
                                fontSize: 11,
                              ),
                        ),
                        const SizedBox(height: 16),
                        Row(
                          children: [
                            Text(
                              'EXPLORE CASE STUDY',
                              style: Theme.of(context).textTheme.labelLarge?.copyWith(
                                    fontSize: 10,
                                    fontWeight: FontWeight.w900,
                                    letterSpacing: 2,
                                  ),
                            ),
                            const SizedBox(width: 12),
                            Container(
                              padding: const EdgeInsets.all(6),
                              decoration: BoxDecoration(
                                color: accent.withOpacity(0.1),
                                shape: BoxShape.circle,
                              ),
                              child: Icon(
                                Icons.arrow_outward_rounded,
                                size: 14,
                                color: accent,
                              ),
                            ).animate(target: _isHovered ? 1 : 0).moveX(
                                  begin: 0,
                                  end: 4,
                                  duration: 300.ms,
                                ).moveY(
                                  begin: 0,
                                  end: -4,
                                  duration: 300.ms,
                                ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    ).animate().fadeIn(delay: (widget.index * 100).ms).scale(
          begin: const Offset(0.9, 0.9),
          end: const Offset(1, 1),
          duration: 800.ms,
          curve: Curves.easeOutBack,
        );
  }

  void _showProjectDetail(BuildContext context) {
    showDialog(
      context: context,
      barrierColor: Colors.black.withOpacity(0.9),
      builder: (ctx) => ProjectDetailDialog(project: widget.project),
    );
  }
}

