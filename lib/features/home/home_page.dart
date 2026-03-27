import 'package:flutter/material.dart';
import '../../widgets/navbar.dart';
import 'hero_section.dart';
import 'about_section.dart';
import 'skills_section.dart';
import 'projects_section.dart';
import '../../features/contact/contact_section.dart';
import '../../widgets/custom_cursor.dart';
import '../../widgets/scroll_transform_widget.dart';

class HomePage extends StatefulWidget {
  final VoidCallback onThemeToggle;
  final bool isDark;

  const HomePage({
    super.key,
    required this.onThemeToggle,
    required this.isDark,
  });

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _scrollController = ScrollController();

  // Section keys for smooth scrolling
  final _heroKey = GlobalKey();
  final _aboutKey = GlobalKey();
  final _skillsKey = GlobalKey();
  final _projectsKey = GlobalKey();
  final _contactKey = GlobalKey();

  List<String> get _sectionLabels =>
      ['Home', 'About', 'Skills', 'Projects', 'Contact'];

  List<GlobalKey> get _sectionKeys =>
      [_heroKey, _aboutKey, _skillsKey, _projectsKey, _contactKey];

  void _scrollToSection(GlobalKey key) {
    final ctx = key.currentContext;
    if (ctx != null) {
      Scrollable.ensureVisible(
        ctx,
        duration: const Duration(milliseconds: 1000),
        curve: Curves.easeInOutExpo,
      );
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomCursor(
        child: Stack(
          children: [
          // Main scrollable content
          SingleChildScrollView(
            controller: _scrollController,
            physics: const BouncingScrollPhysics(),
            child: Column(
              children: [
                ScrollTransformWidget(
                  scrollController: _scrollController,
                  sectionKey: _heroKey,
                  child: HeroSection(
                    sectionKey: _heroKey,
                    onViewProjects: () => _scrollToSection(_projectsKey),
                    onContactMe: () => _scrollToSection(_contactKey),
                  ),
                ),
                ScrollTransformWidget(
                  scrollController: _scrollController,
                  sectionKey: _aboutKey,
                  child: AboutSection(sectionKey: _aboutKey),
                ),
                ScrollTransformWidget(
                  scrollController: _scrollController,
                  sectionKey: _skillsKey,
                  child: SkillsSection(sectionKey: _skillsKey),
                ),
                ScrollTransformWidget(
                  scrollController: _scrollController,
                  sectionKey: _projectsKey,
                  child: ProjectsSection(sectionKey: _projectsKey),
                ),
                ScrollTransformWidget(
                  scrollController: _scrollController,
                  sectionKey: _contactKey,
                  child: ContactSection(sectionKey: _contactKey),
                ),
              ],
            ),
          ),
          // Sticky navbar
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: NavBar(
              sectionLabels: _sectionLabels,
              sectionKeys: _sectionKeys,
              onThemeToggle: widget.onThemeToggle,
              isDark: widget.isDark,
            ),
          ),
        ],
      ),
    ));
  }
}
