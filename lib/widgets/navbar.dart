import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../core/constants/app_colors.dart';
import '../core/utils/responsive.dart';

class NavBar extends StatefulWidget {
  final List<String> sectionLabels;
  final List<GlobalKey> sectionKeys;
  final VoidCallback onThemeToggle;
  final bool isDark;

  const NavBar({
    super.key,
    required this.sectionLabels,
    required this.sectionKeys,
    required this.onThemeToggle,
    required this.isDark,
  });

  @override
  State<NavBar> createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  int _hoveredIndex = -1;

  void _scrollToSection(int index) {
    final key = widget.sectionKeys[index];
    final ctx = key.currentContext;
    if (ctx != null) {
      Scrollable.ensureVisible(
        ctx,
        duration: const Duration(milliseconds: 1000),
        curve: Curves.easeInOutExpo,
      );
    }
    Navigator.of(context).maybePop();
  }

  @override
  Widget build(BuildContext context) {
    final isMobile = Responsive.isMobile(context);
    final isDark = widget.isDark;

    return ClipRRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
        child: AnimatedContainer(
          duration: 400.ms,
          height: 80,
          padding: EdgeInsets.symmetric(
            horizontal: Responsive.isDesktop(context) ? 60 : 24,
          ),
          decoration: BoxDecoration(
            color: (isDark ? Colors.black : Colors.white).withOpacity(0.7),
            border: Border(
              bottom: BorderSide(
                color: (isDark ? Colors.white : Colors.black).withOpacity(0.05),
                width: 1,
              ),
            ),
          ),
          child: Row(
            children: [
              // Minimal Logo
              GestureDetector(
                onTap: () => _scrollToSection(0),
                child: MouseRegion(
                  cursor: SystemMouseCursors.click,
                  child: Row(
                    children: [
                      Container(
                        width: 32,
                        height: 32,
                        decoration: BoxDecoration(
                          gradient: AppColors.primaryGradient,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: const Center(
                          child: Text(
                            'G',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w900,
                              fontSize: 18,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      if (!isMobile)
                        Text(
                          'GOPINATH MJ',
                          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                fontWeight: FontWeight.w900,
                                letterSpacing: 1,
                                fontSize: 14,
                              ),
                        ),
                    ],
                  ),
                ),
              ),
              const Spacer(),
              if (!isMobile)
                Row(
                  children: List.generate(widget.sectionLabels.length, (index) {
                    final isHovered = _hoveredIndex == index;
                    return MouseRegion(
                      onEnter: (_) => setState(() => _hoveredIndex = index),
                      onExit: (_) => setState(() => _hoveredIndex = -1),
                      child: GestureDetector(
                        onTap: () => _scrollToSection(index),
                        child: AnimatedContainer(
                          duration: 200.ms,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 10),
                          margin: const EdgeInsets.symmetric(horizontal: 4),
                          decoration: BoxDecoration(
                            color: isHovered 
                                ? AppColors.primary.withOpacity(0.1) 
                                : Colors.transparent,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Text(
                            widget.sectionLabels[index].toUpperCase(),
                            style: Theme.of(context).textTheme.labelLarge?.copyWith(
                                  fontWeight: isHovered 
                                      ? FontWeight.w800 
                                      : FontWeight.w600,
                                  fontSize: 11,
                                  letterSpacing: 1.5,
                                  color: isHovered 
                                      ? AppColors.primary 
                                      : Colors.white.withOpacity(0.5),
                                ),
                          ),
                        ),
                      ),
                    );
                  }),
                ),
              if (isMobile)
                IconButton(
                  onPressed: () => _showMobileMenu(context),
                  icon: const Icon(Icons.notes_rounded, size: 28),
                ),
              const SizedBox(width: 12),
              _ThemeToggle(isDark: isDark, onToggle: widget.onThemeToggle),
            ],
          ),
        ),
      ),
    ).animate().slideY(begin: -1, end: 0, duration: 600.ms, curve: Curves.easeOutCubic);
  }

  void _showMobileMenu(BuildContext context) {
    showGeneralDialog(
      context: context,
      barrierDismissible: true,
      barrierLabel: 'Menu',
      barrierColor: Colors.black.withOpacity(0.9),
      transitionDuration: 400.ms,
      pageBuilder: (ctx, anim1, anim2) {
        return Scaffold(
          backgroundColor: Colors.transparent,
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(widget.sectionLabels.length, (index) {
                return GestureDetector(
                  onTap: () => _scrollToSection(index),
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 20),
                    child: Text(
                      widget.sectionLabels[index].toUpperCase(),
                      style: const TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.w900,
                        letterSpacing: 4,
                        color: Colors.white,
                      ),
                    ).animate().fadeIn(delay: (index * 100).ms).slideX(begin: 0.2, end: 0),
                  ),
                );
              }),
            ),
          ),
        );
      },
    );
  }
}

class _ThemeToggle extends StatefulWidget {
  final bool isDark;
  final VoidCallback onToggle;

  const _ThemeToggle({required this.isDark, required this.onToggle});

  @override
  State<_ThemeToggle> createState() => _ThemeToggleState();
}

class _ThemeToggleState extends State<_ThemeToggle> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: widget.onToggle,
        child: AnimatedContainer(
          duration: 300.ms,
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: _isHovered 
                ? AppColors.primary.withOpacity(0.1) 
                : Colors.white.withOpacity(0.05),
            shape: BoxShape.circle,
            border: Border.all(
              color: _isHovered 
                  ? AppColors.primary.withOpacity(0.3) 
                  : Colors.white.withOpacity(0.1),
            ),
          ),
          child: Icon(
            widget.isDark ? Icons.light_mode_rounded : Icons.dark_mode_rounded,
            color: widget.isDark ? AppColors.primary : Colors.white,
            size: 20,
          ),
        ),
      ),
    );
  }
}
