import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_strings.dart';
import '../../core/utils/responsive.dart';

class ContactSection extends StatefulWidget {
  final GlobalKey sectionKey;

  const ContactSection({super.key, required this.sectionKey});

  @override
  State<ContactSection> createState() => _ContactSectionState();
}

class _ContactSectionState extends State<ContactSection> {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _messageController = TextEditingController();
  bool _isSubmitting = false;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _messageController.dispose();
    super.dispose();
  }

  void _handleSubmit() {
    setState(() => _isSubmitting = true);
    Future.delayed(const Duration(seconds: 2), () {
      if (mounted) {
        setState(() => _isSubmitting = false);
        _nameController.clear();
        _emailController.clear();
        _messageController.clear();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: const Text('Message sent successfully! 🎉'),
            backgroundColor: AppColors.primary,
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        );
      }
    });
  }

  Future<void> _launchUrl(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }

  @override
  Widget build(BuildContext context) {
    final isMobile = Responsive.isMobile(context);
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      key: widget.sectionKey,
      width: double.infinity,
      padding: Responsive.sectionPadding(context),
      child: Center(
        child: SizedBox(
          width: Responsive.contentWidth(context),
          child: Column(
            children: [
              _SectionHeader(
                title: AppStrings.contactTitle,
                subtitle: AppStrings.contactSubtitle,
              ),
              const SizedBox(height: 50),
              isMobile
                  ? Column(
                      children: [
                        _buildForm(context, isDark),
                        const SizedBox(height: 32),
                        _buildContactCards(context, isDark),
                      ],
                    )
                  : Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          flex: 6,
                          child: _buildForm(context, isDark),
                        ),
                        const SizedBox(width: 36),
                        Expanded(
                          flex: 4,
                          child: _buildContactCards(context, isDark),
                        ),
                      ],
                    ),
              const SizedBox(height: 60),
              _buildFooter(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildForm(BuildContext context, bool isDark) {
    return Container(
      padding: const EdgeInsets.all(28),
      decoration: BoxDecoration(
        color: isDark
            ? AppColors.darkCard.withValues(alpha: 0.5)
            : AppColors.lightCard,
        borderRadius: BorderRadius.circular(22),
        border: Border.all(
          color: AppColors.primary.withValues(alpha: 0.08),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '💬 Send me a message',
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontSize: 18,
                ),
          ),
          const SizedBox(height: 24),
          _GlowTextField(
            controller: _nameController,
            hintText: 'Your Name',
            icon: Icons.person_rounded,
          ),
          const SizedBox(height: 16),
          _GlowTextField(
            controller: _emailController,
            hintText: 'Your Email',
            icon: Icons.email_rounded,
            keyboardType: TextInputType.emailAddress,
          ),
          const SizedBox(height: 16),
          _GlowTextField(
            controller: _messageController,
            hintText: 'Tell me about your project...',
            icon: Icons.message_rounded,
            maxLines: 5,
          ),
          const SizedBox(height: 24),
          _SubmitButton(
            isLoading: _isSubmitting,
            onTap: _handleSubmit,
          ),
        ],
      ),
    )
        .animate()
        .fadeIn(delay: 200.ms, duration: 600.ms)
        .slideX(begin: -0.1, end: 0, delay: 200.ms, duration: 600.ms);
  }

  Widget _buildContactCards(BuildContext context, bool isDark) {
    return Column(
      children: [
        _ContactInfoCard(
          emoji: '📧',
          title: 'Email',
          subtitle: AppStrings.email,
          color: AppColors.primary,
          onTap: () => _launchUrl('mailto:${AppStrings.email}'),
          index: 0,
        ),
        const SizedBox(height: 14),
        _ContactInfoCard(
          emoji: '📞',
          title: 'Phone',
          subtitle: AppStrings.phone,
          color: const Color(0xFF4ADE80),
          onTap: () => _launchUrl('tel:${AppStrings.phone}'),
          index: 1,
        ),
        const SizedBox(height: 14),
        _ContactInfoCard(
          emoji: '💼',
          title: 'LinkedIn',
          subtitle: 'Connect with me',
          color: const Color(0xFF0A66C2),
          onTap: () => _launchUrl(AppStrings.linkedInUrl),
          index: 2,
        ),
        const SizedBox(height: 14),
        _ContactInfoCard(
          emoji: '🐙',
          title: 'GitHub',
          subtitle: 'Check my repos',
          color: isDark ? Colors.white : Colors.black87,
          onTap: () => _launchUrl(AppStrings.githubUrl),
          index: 3,
        ),
        const SizedBox(height: 28),
        // CTA Card
        Container(
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                AppColors.primary.withValues(alpha: 0.1),
                AppColors.accent.withValues(alpha: 0.05),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(18),
            border: Border.all(
              color: AppColors.primary.withValues(alpha: 0.15),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('🚀', style: TextStyle(fontSize: 28)),
              const SizedBox(height: 12),
              Text(
                "Let's build together",
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontSize: 17,
                    ),
              ),
              const SizedBox(height: 8),
              Text(
                'Available for freelance projects and full-time opportunities.',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ],
          ),
        )
            .animate()
            .fadeIn(delay: 800.ms, duration: 600.ms)
            .slideY(begin: 0.1, end: 0, delay: 800.ms, duration: 600.ms),
      ],
    );
  }

  Widget _buildFooter(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 28),
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(
            color: AppColors.primary.withValues(alpha: 0.08),
          ),
        ),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Designed & Built with ',
                style: Theme.of(context).textTheme.labelLarge,
              ),
              const Text('💙', style: TextStyle(fontSize: 16)),
              Text(
                ' using Flutter',
                style: Theme.of(context).textTheme.labelLarge,
              ),
            ],
          ),
          const SizedBox(height: 6),
          Text(
            '© 2025 ${AppStrings.name}',
            style: Theme.of(context).textTheme.labelLarge?.copyWith(
                  fontSize: 12,
                ),
          ),
        ],
      ),
    )
        .animate()
        .fadeIn(delay: 600.ms, duration: 500.ms);
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
        SizedBox(
          width: Responsive.isMobile(context) ? double.infinity : 500,
          child: Text(
            subtitle,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  fontSize: Responsive.isMobile(context) ? 14 : 16,
                ),
          ),
        ),
      ],
    )
        .animate()
        .fadeIn(duration: 600.ms)
        .slideY(begin: 0.3, end: 0, duration: 600.ms);
  }
}

class _ContactInfoCard extends StatefulWidget {
  final String emoji;
  final String title;
  final String subtitle;
  final Color color;
  final VoidCallback onTap;
  final int index;

  const _ContactInfoCard({
    required this.emoji,
    required this.title,
    required this.subtitle,
    required this.color,
    required this.onTap,
    required this.index,
  });

  @override
  State<_ContactInfoCard> createState() => _ContactInfoCardState();
}

class _ContactInfoCardState extends State<_ContactInfoCard> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 250),
          padding: const EdgeInsets.all(18),
          decoration: BoxDecoration(
            color: isDark
                ? AppColors.darkCard.withValues(alpha: _isHovered ? 0.8 : 0.5)
                : AppColors.lightCard.withValues(alpha: _isHovered ? 1 : 0.7),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: _isHovered
                  ? widget.color.withValues(alpha: 0.3)
                  : AppColors.primary.withValues(alpha: 0.05),
            ),
            boxShadow: _isHovered
                ? [
                    BoxShadow(
                      color: widget.color.withValues(alpha: 0.1),
                      blurRadius: 16,
                      offset: const Offset(0, 4),
                    ),
                  ]
                : [],
          ),
          transform: _isHovered
              ? (Matrix4.identity()..translate(0.0, -3.0, 0.0))
              : Matrix4.identity(),
          child: Row(
            children: [
              Text(widget.emoji, style: const TextStyle(fontSize: 24)),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.title,
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            fontSize: 15,
                          ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      widget.subtitle,
                      style: Theme.of(context).textTheme.labelLarge?.copyWith(
                            color: widget.color,
                          ),
                    ),
                  ],
                ),
              ),
              Icon(
                Icons.arrow_outward_rounded,
                color: widget.color.withValues(alpha: 0.5),
                size: 18,
              ),
            ],
          ),
        ),
      ),
    )
        .animate()
        .fadeIn(
          delay: Duration(milliseconds: 400 + widget.index * 150),
          duration: 500.ms,
        )
        .slideX(
          begin: 0.15,
          end: 0,
          delay: Duration(milliseconds: 400 + widget.index * 150),
          duration: 500.ms,
        );
  }
}

class _GlowTextField extends StatefulWidget {
  final TextEditingController controller;
  final String hintText;
  final IconData icon;
  final int maxLines;
  final TextInputType keyboardType;

  const _GlowTextField({
    required this.controller,
    required this.hintText,
    required this.icon,
    this.maxLines = 1,
    this.keyboardType = TextInputType.text,
  });

  @override
  State<_GlowTextField> createState() => _GlowTextFieldState();
}

class _GlowTextFieldState extends State<_GlowTextField> {
  bool _isFocused = false;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        boxShadow: _isFocused
            ? [
                BoxShadow(
                  color: AppColors.primary.withValues(alpha: 0.15),
                  blurRadius: 16,
                  offset: const Offset(0, 4),
                ),
              ]
            : [],
      ),
      child: Focus(
        onFocusChange: (focused) => setState(() => _isFocused = focused),
        child: TextField(
          controller: widget.controller,
          maxLines: widget.maxLines,
          keyboardType: widget.keyboardType,
          style: Theme.of(context).textTheme.bodyMedium,
          decoration: InputDecoration(
            hintText: widget.hintText,
            prefixIcon: Padding(
              padding: const EdgeInsets.only(left: 16, right: 12),
              child: Icon(
                widget.icon,
                color: _isFocused
                    ? AppColors.primary
                    : Theme.of(context)
                        .textTheme
                        .labelLarge
                        ?.color
                        ?.withValues(alpha: 0.5),
                size: 20,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _SubmitButton extends StatefulWidget {
  final bool isLoading;
  final VoidCallback onTap;

  const _SubmitButton({required this.isLoading, required this.onTap});

  @override
  State<_SubmitButton> createState() => _SubmitButtonState();
}

class _SubmitButtonState extends State<_SubmitButton> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: widget.isLoading ? null : widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          width: double.infinity,
          padding: const EdgeInsets.symmetric(vertical: 18),
          decoration: BoxDecoration(
            gradient: AppColors.primaryGradient,
            borderRadius: BorderRadius.circular(14),
            boxShadow: _isHovered
                ? [
                    BoxShadow(
                      color: AppColors.primary.withValues(alpha: 0.45),
                      blurRadius: 24,
                      offset: const Offset(0, 8),
                    ),
                  ]
                : [
                    BoxShadow(
                      color: AppColors.primary.withValues(alpha: 0.2),
                      blurRadius: 12,
                      offset: const Offset(0, 4),
                    ),
                  ],
          ),
          transform: _isHovered
              ? (Matrix4.identity()..translate(0.0, -2.0, 0.0))
              : Matrix4.identity(),
          child: Center(
            child: widget.isLoading
                ? const SizedBox(
                    width: 22,
                    height: 22,
                    child: CircularProgressIndicator(
                      color: Colors.white,
                      strokeWidth: 2.5,
                    ),
                  )
                : Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(Icons.send_rounded,
                          color: Colors.white, size: 18),
                      const SizedBox(width: 10),
                      Text(
                        'Send Message',
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                            ),
                      ),
                    ],
                  ),
          ),
        ),
      ),
    );
  }
}
