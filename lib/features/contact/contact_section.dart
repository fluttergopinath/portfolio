import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_strings.dart';
import '../../core/utils/responsive.dart';
import '../../widgets/glass_card.dart';
import '../../widgets/tilt_widget.dart';

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
          content: Text('Please fill in required fields. ✍️', style: GoogleFonts.outfit()),
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
            content: Text('Message sent successfully! 🎉', style: GoogleFonts.outfit(fontWeight: FontWeight.w600)),
            backgroundColor: AppColors.primary,
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
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
              const _SectionHeader(
                title: 'GET IN TOUCH',
                subtitle: 'LET\'S BUILD THE FUTURE TOGETHER',
              ),
              const SizedBox(height: 100),
              if (isMobile)
                Column(
                  children: [
                    _buildForm(context),
                    const SizedBox(height: 64),
                    _buildContactCards(context),
                  ],
                )
              else
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      flex: 6,
                      child: _buildForm(context),
                    ),
                    const SizedBox(width: 80),
                    Expanded(
                      flex: 4,
                      child: _buildContactCards(context),
                    ),
                  ],
                ),
              const SizedBox(height: 140),
              _buildFooter(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildForm(BuildContext context) {
    return GlassCard(
      padding: EdgeInsets.all(Responsive.isMobile(context) ? 24 : 48),
      borderRadius: 40,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'SEND A MESSAGE',
            style: GoogleFonts.outfit(
              fontWeight: FontWeight.w900,
              letterSpacing: 4,
              fontSize: 12,
              color: AppColors.primary,
            ),
          ),
          const SizedBox(height: 24),
          Text(
            "HAVE A VISION?\nLET'S REALIZE IT.",
            style: GoogleFonts.outfit(
              fontWeight: FontWeight.w900,
              fontSize: 32,
              height: 1.1,
              letterSpacing: -1,
            ),
          ),
          const SizedBox(height: 48),
          _CustomTextField(
            controller: _nameController,
            hintText: 'FULL NAME',
            icon: Icons.person_rounded,
          ),
          const SizedBox(height: 24),
          _CustomTextField(
            controller: _emailController,
            hintText: 'EMAIL ADDRESS',
            icon: Icons.email_rounded,
            keyboardType: TextInputType.emailAddress,
          ),
          const SizedBox(height: 24),
          _CustomTextField(
            controller: _messageController,
            hintText: 'YOUR MESSAGE...',
            icon: Icons.chat_bubble_rounded,
            maxLines: 5,
          ),
          const SizedBox(height: 48),
          _SubmitButton(
            isLoading: _isSubmitting,
            onTap: _handleSubmit,
          ),
        ],
      ),
    ).animate().fadeIn(duration: 800.ms).slideX(begin: -0.1, end: 0);
  }

  Widget _buildContactCards(BuildContext context) {
    return Column(
      children: [
        _ContactInfoCard(
          icon: Icons.alternate_email_rounded,
          title: 'EMAIL',
          subtitle: AppStrings.email,
          color: AppColors.primary,
          onTap: () => _launchUrl('mailto:${AppStrings.email}'),
          index: 0,
        ),
        const SizedBox(height: 24),
        _ContactInfoCard(
          icon: Icons.terminal_rounded,
          title: 'LINKEDIN',
          subtitle: 'GOPINATH MJ',
          color: const Color(0xFF0A66C2),
          onTap: () => _launchUrl(AppStrings.linkedInUrl),
          index: 1,
        ),
        const SizedBox(height: 24),
        _ContactInfoCard(
          icon: Icons.code_rounded,
          title: 'GITHUB',
          subtitle: 'FLUTTERGOPINATH',
          color: Colors.white,
          onTap: () => _launchUrl(AppStrings.githubUrl),
          index: 2,
        ),
        const SizedBox(height: 40),
        
        // Availability Status
        GlassCard(
          padding: const EdgeInsets.all(32),
          borderRadius: 32,
          opacity: 0.03,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    width: 12,
                    height: 12,
                    decoration: const BoxDecoration(
                      color: Color(0xFF00FF94),
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Color(0xFF00FF94),
                          blurRadius: 10,
                        ),
                      ],
                    ),
                  ).animate(onPlay: (c) => c.repeat()).shimmer(duration: 2.seconds),
                  const SizedBox(width: 16),
                  Text(
                    'OPEN FOR NEW OPPORTUNITIES',
                    style: GoogleFonts.outfit(
                      fontWeight: FontWeight.w900,
                      letterSpacing: 2,
                      fontSize: 10,
                      color: const Color(0xFF00FF94),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Text(
                'Interested in working together? Reach out for freelance inquiries or collaborations.',
                style: GoogleFonts.outfit(
                  height: 1.6,
                  fontSize: 14,
                  color: Colors.white.withOpacity(0.5),
                ),
              ),
            ],
          ),
        ).animate().fadeIn(delay: 800.ms),
      ],
    ).animate().fadeIn(duration: 800.ms).slideX(begin: 0.1, end: 0);
  }

  Widget _buildFooter(BuildContext context) {
    return Column(
      children: [
        // Glowing Neon Line
        Container(
          width: 200,
          height: 2,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                AppColors.primary.withOpacity(0),
                AppColors.primary,
                AppColors.secondary,
                AppColors.secondary.withOpacity(0),
              ],
            ),
            boxShadow: [
              BoxShadow(
                color: AppColors.primary.withOpacity(0.5),
                blurRadius: 10,
                spreadRadius: 1,
              ),
            ],
          ),
        ).animate(onPlay: (c) => c.repeat()).shimmer(duration: 3.seconds, color: Colors.white.withOpacity(0.2)),
        
        const SizedBox(height: 80),
        
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'DESIGNED & ENGINEERED BY ',
              style: GoogleFonts.outfit(
                letterSpacing: 4,
                fontSize: 10,
                fontWeight: FontWeight.w700,
                color: Colors.white.withOpacity(0.3),
              ),
            ),
            Text(
              AppStrings.name.toUpperCase(),
              style: GoogleFonts.outfit(
                letterSpacing: 4,
                fontSize: 10,
                fontWeight: FontWeight.w900,
                color: AppColors.primary,
              ),
            ),
          ],
        ).animate().fadeIn(delay: 400.ms),
        
        const SizedBox(height: 24),
        
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _FooterSocialIcon(Icons.terminal_rounded, AppStrings.githubUrl),
            const SizedBox(width: 20),
            _FooterSocialIcon(Icons.alternate_email_rounded, 'mailto:${AppStrings.email}'),
            const SizedBox(width: 20),
            _FooterSocialIcon(Icons.work_rounded, AppStrings.linkedInUrl),
          ],
        ),
        
        const SizedBox(height: 48),
        
        Text(
          '© 2026 • BUILT WITH FLUTTER & PASSION',
          style: GoogleFonts.outfit(
            fontWeight: FontWeight.w900,
            letterSpacing: 2,
            fontSize: 9,
            color: Colors.white.withOpacity(0.1),
          ),
        ),
        
        const SizedBox(height: 40),
      ],
    ).animate().fadeIn(delay: 800.ms);
  }
}

class _FooterSocialIcon extends StatefulWidget {
  final IconData icon;
  final String url;
  const _FooterSocialIcon(this.icon, this.url);

  @override
  State<_FooterSocialIcon> createState() => _FooterSocialIconState();
}

class _FooterSocialIconState extends State<_FooterSocialIcon> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: GestureDetector(
        onTap: () => launchUrl(Uri.parse(widget.url)),
        child: AnimatedScale(
          scale: _isHovered ? 1.2 : 1.0,
          duration: 200.ms,
          child: AnimatedContainer(
            duration: 200.ms,
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: _isHovered ? AppColors.primary.withOpacity(0.1) : Colors.transparent,
              shape: BoxShape.circle,
              border: Border.all(
                color: _isHovered ? AppColors.primary.withOpacity(0.5) : Colors.white.withOpacity(0.05),
              ),
            ),
            child: Icon(
              widget.icon,
              color: _isHovered ? AppColors.primary : Colors.white.withOpacity(0.3),
              size: 20,
            ),
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
          ),
        ),
      ],
    ).animate().fadeIn(duration: 800.ms).slideY(begin: 0.2, end: 0);
  }
}

class _ContactInfoCard extends StatefulWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final Color color;
  final VoidCallback onTap;
  final int index;

  const _ContactInfoCard({
    required this.icon,
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
        child: TiltWidget(
          maxTilt: 0.1,
          child: GlassCard(
            padding: const EdgeInsets.all(32),
            borderRadius: 32,
            opacity: _isHovered ? 0.1 : 0.05,
            borderColor: _isHovered ? widget.color.withOpacity(0.4) : null,
            child: Row(
              children: [
                Container(
                  width: 64,
                  height: 64,
                  decoration: BoxDecoration(
                    color: widget.color.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: widget.color.withOpacity(0.2)),
                  ),
                  child: Icon(widget.icon, color: widget.color, size: 28),
                ),
                const SizedBox(width: 24),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.title,
                        style: GoogleFonts.outfit(
                          fontWeight: FontWeight.w900,
                          letterSpacing: 2,
                          fontSize: 10,
                          color: Colors.white.withOpacity(0.4),
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        widget.subtitle,
                        style: GoogleFonts.outfit(
                          fontWeight: FontWeight.w800,
                          fontSize: 16,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
                Icon(
                  Icons.arrow_outward_rounded,
                  color: widget.color.withOpacity(0.3),
                  size: 20,
                ),
              ],
            ),
          ),
        ),
      ),
    ).animate().fadeIn(delay: (widget.index * 150).ms).slideX(begin: 0.1, end: 0);
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
          borderRadius: BorderRadius.circular(24),
          border: Border.all(
            color: _isFocused ? AppColors.primary : Colors.white.withOpacity(0.05),
            width: 1.5,
          ),
        ),
        child: TextField(
          controller: widget.controller,
          maxLines: widget.maxLines,
          keyboardType: widget.keyboardType,
          style: GoogleFonts.outfit(color: Colors.white, fontSize: 16),
          decoration: InputDecoration(
            hintText: widget.hintText,
            hintStyle: GoogleFonts.outfit(
              color: Colors.white.withOpacity(0.2),
              fontWeight: FontWeight.w700,
              letterSpacing: 2,
              fontSize: 12,
            ),
            border: InputBorder.none,
            contentPadding: const EdgeInsets.symmetric(horizontal: 28, vertical: 24),
            prefixIcon: Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: Icon(
                widget.icon,
                color: _isFocused ? AppColors.primary : Colors.white.withOpacity(0.1),
                size: 22,
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
          duration: 300.ms,
          width: double.infinity,
          height: 72,
          decoration: BoxDecoration(
            gradient: AppColors.premiumGradient,
            borderRadius: BorderRadius.circular(24),
            boxShadow: [
              BoxShadow(
                color: AppColors.primary.withOpacity(_isHovered ? 0.4 : 0.2),
                blurRadius: _isHovered ? 30 : 15,
                spreadRadius: _isHovered ? 2 : 0,
              ),
            ],
          ),
          child: Center(
            child: widget.isLoading
                ? const SizedBox(
                    width: 24,
                    height: 24,
                    child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2),
                  )
                : Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.rocket_launch_rounded, color: Colors.white, size: 24),
                      const SizedBox(width: 16),
                      Text(
                        'INITIALIZE CONNECTION',
                        style: GoogleFonts.outfit(
                          color: Colors.white,
                          fontWeight: FontWeight.w900,
                          letterSpacing: 4,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
          ),
        ).animate(target: _isHovered ? 1 : 0).scale(begin: const Offset(1, 1), end: const Offset(1.02, 1.02)),
      ),
    );
  }
}

