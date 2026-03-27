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
              const SizedBox(height: 80),
              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: isMobile ? 1 : 2,
                  crossAxisSpacing: 32,
                  mainAxisSpacing: 32,
                  childAspectRatio: isMobile ? 1.2 : 1.1,
                ),
                itemCount: ProjectData.projects.length,
                itemBuilder: (context, index) {
                  return _ProjectCard(
                    project: ProjectData.projects[index],
                    index: index,
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
          maxTilt: 0.08,
          scale: 1.02,
          child: GlassCard(
            borderRadius: 32,
            padding: EdgeInsets.zero,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Project Icon / Emoji with Gradient Background
                Expanded(
                  flex: 5,
                  child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          accent.withOpacity(0.1),
                          AppColors.primary.withOpacity(0.05),
                        ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: const BorderRadius.vertical(
                        top: Radius.circular(32),
                      ),
                    ),
                    child: Center(
                      child: Container(
                        padding: const EdgeInsets.all(24),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.05),
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: Colors.white.withOpacity(0.1),
                          ),
                        ),
                        child: Text(
                          widget.project.emoji,
                          style: const TextStyle(fontSize: 48),
                        ),
                      ).animate(target: _isHovered ? 1 : 0).scale(
                            begin: const Offset(1, 1),
                            end: const Offset(1.15, 1.15),
                            duration: 400.ms,
                            curve: Curves.easeOutBack,
                          ),
                    ),
                  ),
                ),
                // Content
                Expanded(
                  flex: 5,
                  child: Padding(
                    padding: const EdgeInsets.all(28),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.project.title,
                          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                                fontWeight: FontWeight.w900,
                                fontSize: 24,
                              ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          widget.project.subtitle.toUpperCase(),
                          style: Theme.of(context).textTheme.labelLarge?.copyWith(
                                color: accent,
                                letterSpacing: 2,
                                fontWeight: FontWeight.w800,
                                fontSize: 11,
                              ),
                        ),
                        const SizedBox(height: 20),
                        Expanded(
                          child: Text(
                            widget.project.description,
                            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                  color: Colors.white.withOpacity(0.5),
                                  height: 1.6,
                                ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        const SizedBox(height: 20),
                        Row(
                          children: [
                            Text(
                              'EXPLORE CASE STUDY',
                              style:
                                  Theme.of(context).textTheme.labelLarge?.copyWith(
                                        fontSize: 10,
                                        fontWeight: FontWeight.w900,
                                        letterSpacing: 1.5,
                                      ),
                            ),
                            const SizedBox(width: 8),
                            Icon(
                              Icons.arrow_forward_rounded,
                              size: 14,
                              color: Colors.white.withOpacity(0.6),
                            ).animate(target: _isHovered ? 1 : 0).moveX(
                                  begin: 0,
                                  end: 6,
                                  duration: 300.ms,
                                  curve: Curves.easeOutCubic,
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
    ).animate().fadeIn(delay: (widget.index * 150).ms).slideY(begin: 0.2, end: 0);
  }

  void _showProjectDetail(BuildContext context) {
    showDialog(
      context: context,
      barrierColor: Colors.black.withOpacity(0.85),
      builder: (ctx) => ProjectDetailDialog(project: widget.project),
    );
  }
}
