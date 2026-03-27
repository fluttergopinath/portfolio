import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_strings.dart';
import '../../core/utils/responsive.dart';
import '../../widgets/glass_card.dart';

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
    if (_nameController.text.isEmpty || _emailController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('Please fill in required fields. ✍️'),
          backgroundColor: Colors.redAccent,
        ),
      );
      return;
    }

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
              const SizedBox(height: 60),
              isMobile
                  ? Column(
                      children: [
                        _buildForm(context),
                        const SizedBox(height: 48),
                        _buildContactCards(context),
                      ],
                    )
                  : Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          flex: 5,
                          child: _buildForm(context),
                        ),
                        const SizedBox(width: 48),
                        Expanded(
                          flex: 4,
                          child: _buildContactCards(context),
                        ),
                      ],
                    ),
              const SizedBox(height: 100),
              _buildFooter(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildForm(BuildContext context) {
    return GlassCard(
      padding: const EdgeInsets.all(32),
      borderRadius: 32,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'SEND A MESSAGE',
            style: Theme.of(context).textTheme.labelLarge?.copyWith(
                  fontWeight: FontWeight.w900,
                  letterSpacing: 2,
                  fontSize: 12,
                  color: AppColors.primary.withOpacity(0.8),
                ),
          ),
          const SizedBox(height: 12),
          Text(
            "Let's create something extraordinary",
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.w800,
                  letterSpacing: -0.5,
                ),
          ),
          const SizedBox(height: 32),
          _CustomTextField(
            controller: _nameController,
            hintText: 'Your Name',
            icon: Icons.person_outline_rounded,
          ),
          const SizedBox(height: 20),
          _CustomTextField(
            controller: _emailController,
            hintText: 'Your Email',
            icon: Icons.alternate_email_rounded,
            keyboardType: TextInputType.emailAddress,
          ),
          const SizedBox(height: 20),
          _CustomTextField(
            controller: _messageController,
            hintText: 'Tell me about your project...',
            icon: Icons.chat_bubble_outline_rounded,
            maxLines: 6,
          ),
          const SizedBox(height: 32),
          _SubmitButton(
            isLoading: _isSubmitting,
            onTap: _handleSubmit,
          ),
        ],
      ),
    ).animate().fadeIn(duration: 600.ms).slideY(begin: 0.1, end: 0);
  }

  Widget _buildContactCards(BuildContext context) {
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
        const SizedBox(height: 16),
        _ContactInfoCard(
          emoji: '💼',
          title: 'LinkedIn',
          subtitle: 'Gopinath MJ',
          color: const Color(0xFF0A66C2),
          onTap: () => _launchUrl(AppStrings.linkedInUrl),
          index: 1,
        ),
        const SizedBox(height: 16),
        _ContactInfoCard(
          emoji: '🐙',
          title: 'GitHub',
          subtitle: 'github.com/fluttergopinath',
          color: Colors.white,
          onTap: () => _launchUrl(AppStrings.githubUrl),
          index: 2,
        ),
        const SizedBox(height: 32),
        // Availability Card
        Container(
          padding: const EdgeInsets.all(32),
          decoration: BoxDecoration(
            color: AppColors.primary.withOpacity(0.05),
            borderRadius: BorderRadius.circular(24),
            border: Border.all(
              color: AppColors.primary.withOpacity(0.1),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    width: 12,
                    height: 12,
                    decoration: const BoxDecoration(
                      color: Color(0xFF4ADE80),
                      shape: BoxShape.circle,
                    ),
                  ).animate(onPlay: (controller) => controller.repeat())
                    .scale(duration: 1000.ms, begin: const Offset(0.8, 0.8), end: const Offset(1.2, 1.2))
                    .then()
                    .scale(duration: 1000.ms, begin: const Offset(1.2, 1.2), end: const Offset(0.8, 0.8)),
                  const SizedBox(width: 12),
                  Text(
                    'AVAILABLE FOR PROJECTS',
                    style: Theme.of(context).textTheme.labelLarge?.copyWith(
                          fontWeight: FontWeight.w900,
                          letterSpacing: 1.5,
                          fontSize: 11,
                          color: const Color(0xFF4ADE80),
                        ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Text(
                'I am currently open to freelance opportunities and full-time positions where I can contribute to impactful Flutter applications.',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  height: 1.6,
                  color: Colors.white.withOpacity(0.6),
                ),
              ),
            ],
          ),
        ).animate().fadeIn(delay: 600.ms, duration: 600.ms),
      ],
    );
  }

  Widget _buildFooter(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 60,
          height: 2,
          color: AppColors.primary.withOpacity(0.2),
        ),
        const SizedBox(height: 48),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'MADE WITH ',
              style: Theme.of(context).textTheme.labelLarge?.copyWith(
                letterSpacing: 2,
                fontSize: 10,
                color: Colors.white.withOpacity(0.35),
              ),
            ),
            const Icon(Icons.favorite_rounded, color: Colors.redAccent, size: 14),
            Text(
              ' USING FLUTTER',
              style: Theme.of(context).textTheme.labelLarge?.copyWith(
                letterSpacing: 2,
                fontSize: 10,
                color: Colors.white.withOpacity(0.35),
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Text(
          '© 2025 ${AppStrings.name.toUpperCase()}',
          style: Theme.of(context).textTheme.labelLarge?.copyWith(
                fontWeight: FontWeight.w700,
                letterSpacing: 1,
                fontSize: 11,
                color: Colors.white.withOpacity(0.2),
              ),
        ),
      ],
    ).animate().fadeIn(delay: 800.ms);
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
          title,
          style: Theme.of(context).textTheme.displayMedium?.copyWith(
                fontWeight: FontWeight.w900,
                letterSpacing: -2,
              ),
        ),
        const SizedBox(height: 16),
        Container(
          width: 80,
          height: 4,
          decoration: BoxDecoration(
            gradient: AppColors.primaryGradient,
            borderRadius: BorderRadius.circular(2),
          ),
        ),
        const SizedBox(height: 24),
        SizedBox(
          width: 600,
          child: Text(
            subtitle,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  color: Colors.white.withOpacity(0.6),
                  height: 1.5,
                  fontWeight: FontWeight.w400,
                ),
          ),
        ),
      ],
    ).animate().fadeIn(duration: 800.ms).slideY(begin: 0.2, end: 0);
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
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: 300.ms,
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: _isHovered 
                ? widget.color.withOpacity(0.1) 
                : Colors.white.withOpacity(0.03),
            borderRadius: BorderRadius.circular(24),
            border: Border.all(
              color: _isHovered 
                  ? widget.color.withOpacity(0.4) 
                  : Colors.white.withOpacity(0.05),
              width: 1.5,
            ),
          ),
          child: Row(
            children: [
              Container(
                width: 56,
                height: 56,
                decoration: BoxDecoration(
                  color: widget.color.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: Text(widget.emoji, style: const TextStyle(fontSize: 24)),
                ),
              ),
              const SizedBox(width: 20),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.title,
                      style: Theme.of(context).textTheme.labelLarge?.copyWith(
                            fontWeight: FontWeight.w900,
                            letterSpacing: 1.5,
                            fontSize: 11,
                            color: Colors.white.withOpacity(0.4),
                          ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      widget.subtitle,
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.w700,
                          ),
                    ),
                  ],
                ),
              ),
              Icon(
                Icons.arrow_forward_ios_rounded,
                color: widget.color.withOpacity(0.3),
                size: 14,
              ),
            ],
          ),
        ),
      ),
    ).animate().fadeIn(delay: (400 + widget.index * 100).ms, duration: 600.ms).slideX(begin: 0.1, end: 0);
  }
}

class _CustomTextField extends StatefulWidget {
  final TextEditingController controller;
  final String hintText;
  final IconData icon;
  final int maxLines;
  final TextInputType keyboardType;

  const _CustomTextField({
    required this.controller,
    required this.hintText,
    required this.icon,
    this.maxLines = 1,
    this.keyboardType = TextInputType.text,
  });

  @override
  State<_CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<_CustomTextField> {
  bool _isFocused = false;

  @override
  Widget build(BuildContext context) {
    return Focus(
      onFocusChange: (focused) => setState(() => _isFocused = focused),
      child: AnimatedContainer(
        duration: 300.ms,
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(_isFocused ? 0.08 : 0.03),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: _isFocused 
                ? AppColors.primary.withOpacity(0.5) 
                : Colors.white.withOpacity(0.05),
          ),
        ),
        child: TextField(
          controller: widget.controller,
          maxLines: widget.maxLines,
          keyboardType: widget.keyboardType,
          style: const TextStyle(color: Colors.white, fontSize: 15),
          decoration: InputDecoration(
            hintText: widget.hintText,
            hintStyle: TextStyle(color: Colors.white.withOpacity(0.3)),
            border: InputBorder.none,
            enabledBorder: InputBorder.none,
            focusedBorder: InputBorder.none,
            contentPadding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
            prefixIcon: Icon(
              widget.icon,
              color: _isFocused ? AppColors.primary : Colors.white.withOpacity(0.2),
              size: 20,
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
          duration: 300.ms,
          width: double.infinity,
          height: 60,
          decoration: BoxDecoration(
            gradient: _isHovered ? AppColors.primaryGradient : null,
            color: _isHovered ? null : AppColors.primary.withOpacity(0.8),
            borderRadius: BorderRadius.circular(16),
            boxShadow: _isHovered ? [
              BoxShadow(
                color: AppColors.primary.withOpacity(0.3),
                blurRadius: 20,
                offset: const Offset(0, 10),
              )
            ] : [],
          ),
          child: Center(
            child: widget.isLoading
                ? const SizedBox(
                    width: 24,
                    height: 24,
                    child: CircularProgressIndicator(
                      color: Colors.white,
                      strokeWidth: 2,
                    ),
                  )
                : Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.send_rounded, color: Colors.white, size: 20),
                      const SizedBox(width: 12),
                      const Text(
                        'SEND MESSAGE',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w900,
                          letterSpacing: 1.5,
                          fontSize: 14,
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
