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
        duration: const Duration(milliseconds: 800),
        curve: Curves.easeInOutCubic,
      );
    }
    Navigator.of(context).maybePop();
  }

  @override
  Widget build(BuildContext context) {
    final isMobile = Responsive.isMobile(context);
    final isDark = widget.isDark;
    final navBg = isDark
        ? AppColors.darkNavbar.withValues(alpha: 0.85)
        : AppColors.lightNavbar.withValues(alpha: 0.85);

    return ClipRRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
        child: Container(
          height: 70,
          padding: const EdgeInsets.symmetric(horizontal: 24),
          decoration: BoxDecoration(
            color: navBg,
            border: Border(
              bottom: BorderSide(
                color: AppColors.primary.withValues(alpha: 0.08),
                width: 1,
              ),
            ),
          ),
          child: Row(
            children: [
              // Logo
              ShaderMask(
                shaderCallback: (bounds) =>
                    AppColors.primaryGradient.createShader(bounds),
                child: Text(
                  'GMJ',
                  style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.w800,
                    letterSpacing: 2,
                    fontSize: isMobile ? 20 : 24,
                  ),
                ),
              ),
              const Spacer(),
              if (!isMobile) ..._buildDesktopLinks(context),
              if (isMobile) _buildMenuButton(context),
              const SizedBox(width: 12),
              _ThemeToggle(isDark: isDark, onToggle: widget.onThemeToggle),
            ],
          ),
        ),
      ),
    );
  }

  List<Widget> _buildDesktopLinks(BuildContext context) {
    return List.generate(widget.sectionLabels.length, (index) {
      final isHovered = _hoveredIndex == index;
      return MouseRegion(
        onEnter: (_) => setState(() => _hoveredIndex = index),
        onExit: (_) => setState(() => _hoveredIndex = -1),
        cursor: SystemMouseCursors.click,
        child: GestureDetector(
          onTap: () => _scrollToSection(index),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              color: isHovered
                  ? AppColors.primary.withValues(alpha: 0.1)
                  : Colors.transparent,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              widget.sectionLabels[index],
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: isHovered
                    ? AppColors.primary
                    : Theme.of(
                        context,
                      ).textTheme.bodyMedium?.color?.withValues(alpha: 0.8),
                fontWeight: isHovered ? FontWeight.w600 : FontWeight.w400,
              ),
            ),
          ),
        ),
      );
    });
  }

  Widget _buildMenuButton(BuildContext context) {
    return IconButton(
      onPressed: () => _showMobileMenu(context),
      icon: Icon(
        Icons.menu_rounded,
        color: Theme.of(context).textTheme.bodyMedium?.color,
      ),
    );
  }

  void _showMobileMenu(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (ctx) {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Navigation',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    IconButton(
                      onPressed: () => Navigator.pop(ctx),
                      icon: const Icon(Icons.close_rounded),
                    ),
                  ],
                ),
                const Divider(),
                const SizedBox(height: 10),
                ...List.generate(widget.sectionLabels.length, (index) {
                  return ListTile(
                    leading: Icon(
                      _getIconForSection(index),
                      color: AppColors.primary,
                    ),
                    title: Text(
                      widget.sectionLabels[index],
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    onTap: () {
                      Navigator.pop(ctx);
                      _scrollToSection(index);
                    },
                  );
                }),
              ],
            ),
          ),
        );
      },
    );
  }

  IconData _getIconForSection(int index) {
    switch (index) {
      case 0: return Icons.home_rounded;
      case 1: return Icons.person_rounded;
      case 2: return Icons.layers_rounded;
      case 3: return Icons.rocket_launch_rounded;
      case 4: return Icons.mail_rounded;
      default: return Icons.circle;
    }
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
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: _isHovered
                ? AppColors.primary.withValues(alpha: 0.15)
                : Colors.transparent,
            borderRadius: BorderRadius.circular(10),
          ),
          child: AnimatedSwitcher(
            duration: const Duration(milliseconds: 300),
            transitionBuilder: (child, anim) =>
                RotationTransition(turns: anim, child: child),
            child: Icon(
              widget.isDark
                  ? Icons.light_mode_rounded
                  : Icons.dark_mode_rounded,
              key: ValueKey(widget.isDark),
              color: AppColors.primary,
              size: 22,
            ),
          ),
        ),
      ),
    ).animate().fadeIn(delay: 400.ms, duration: 500.ms);
  }
}
