import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import '../core/constants/app_colors.dart';
import '../core/utils/responsive.dart';
import 'glass_card.dart';

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
        duration: const Duration(milliseconds: 1200),
        curve: Curves.easeInOutExpo,
      );
    }
    if (Navigator.of(context).canPop()) {
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    final isMobile = Responsive.isMobile(context);
    final isDark = widget.isDark;

    return Container(
      height: 100,
      padding: EdgeInsets.symmetric(
        horizontal: Responsive.isDesktop(context) ? 80 : 20,
        vertical: 20,
      ),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1400),
          child: GlassCard(
            borderRadius: 100,
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 0),
            blur: 20,
            opacity: 0.1,
            child: Row(
              children: [
                // Logo Section
                GestureDetector(
                  onTap: () => _scrollToSection(0),
                  child: MouseRegion(
                    cursor: SystemMouseCursors.click,
                    child: Row(
                      children: [
                        Container(
                          width: 36,
                          height: 36,
                          decoration: BoxDecoration(
                            gradient: AppColors.premiumGradient,
                            borderRadius: BorderRadius.circular(12),
                            boxShadow: [
                              BoxShadow(
                                color: AppColors.primary.withOpacity(0.3),
                                blurRadius: 15,
                              ),
                            ],
                          ),
                          child: const Icon(Icons.flash_on_rounded, color: Colors.white, size: 20),
                        ),
                        const SizedBox(width: 14),
                        if (!isMobile)
                          Text(
                            'GOPINATH.DEV',
                            style: GoogleFonts.outfit(
                              fontWeight: FontWeight.w900,
                              letterSpacing: 2,
                              fontSize: 14,
                              color: Colors.white,
                            ),
                          ),
                      ],
                    ),
                  ),
                ),
                const Spacer(),
                
                // Desktop Navigation
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
                            duration: 300.ms,
                            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                            margin: const EdgeInsets.symmetric(horizontal: 4),
                            decoration: BoxDecoration(
                              color: isHovered 
                                  ? Colors.white.withOpacity(0.05) 
                                  : Colors.transparent,
                              borderRadius: BorderRadius.circular(100),
                            ),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  widget.sectionLabels[index].toUpperCase(),
                                  style: GoogleFonts.outfit(
                                    fontWeight: isHovered ? FontWeight.w800 : FontWeight.w600,
                                    fontSize: 11,
                                    letterSpacing: 2,
                                    color: isHovered ? Colors.white : Colors.white.withOpacity(0.5),
                                  ),
                                ),
                                if (isHovered)
                                  Container(
                                    height: 2,
                                    width: 12,
                                    margin: const EdgeInsets.only(top: 4),
                                    decoration: BoxDecoration(
                                      color: AppColors.primary,
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                  ).animate().scaleX(begin: 0, end: 1),
                              ],
                            ),
                          ),
                        ),
                      );
                    }),
                  ),
                
                if (isMobile)
                  IconButton(
                    onPressed: () => _showMobileMenu(context),
                    icon: const Icon(Icons.menu_open_rounded, color: Colors.white, size: 28),
                  ),
                  
                const SizedBox(width: 12),
                _ThemeToggle(isDark: isDark, onToggle: widget.onThemeToggle),
              ],
            ),
          ),
        ),
      ),
    ).animate().fadeIn(duration: 800.ms).slideY(begin: -0.5, end: 0);
  }

  void _showMobileMenu(BuildContext context) {
    showGeneralDialog(
      context: context,
      barrierDismissible: true,
      barrierLabel: 'Menu',
      barrierColor: Colors.black.withOpacity(0.95),
      transitionDuration: 500.ms,
      pageBuilder: (ctx, anim1, anim2) {
        return Scaffold(
          backgroundColor: Colors.transparent,
          body: Stack(
            children: [
              Positioned(
                top: 40,
                right: 20,
                child: IconButton(
                  icon: const Icon(Icons.close_rounded, color: Colors.white, size: 32),
                  onPressed: () => Navigator.pop(ctx),
                ),
              ),
              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(widget.sectionLabels.length, (index) {
                    return GestureDetector(
                      onTap: () => _scrollToSection(index),
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 24),
                        child: Text(
                          widget.sectionLabels[index].toUpperCase(),
                          style: GoogleFonts.outfit(
                            fontSize: 40,
                            fontWeight: FontWeight.w900,
                            letterSpacing: 8,
                            color: Colors.white,
                          ),
                        ).animate().fadeIn(delay: (index * 100).ms).slideX(begin: 0.3, end: 0),
                      ),
                    );
                  }),
                ),
              ),
            ],
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
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: _isHovered 
                ? AppColors.primary.withOpacity(0.15) 
                : Colors.white.withOpacity(0.05),
            shape: BoxShape.circle,
            border: Border.all(
              color: _isHovered ? AppColors.primary.withOpacity(0.3) : Colors.white.withOpacity(0.1),
            ),
          ),
          child: Icon(
            widget.isDark ? Icons.light_mode_rounded : Icons.dark_mode_rounded,
            color: Colors.white,
            size: 22,
          ),
        ),
      ),
    );
  }
}

