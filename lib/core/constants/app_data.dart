import 'package:flutter/material.dart';

class ProjectData {
  final String title;
  final String subtitle;
  final String description;
  final List<String> features;
  final List<String> techStack;
  final String challenges;
  final IconData icon;
  final Color accentColor;
  final String emoji;

  const ProjectData({
    required this.title,
    required this.subtitle,
    required this.description,
    required this.features,
    required this.techStack,
    required this.challenges,
    required this.icon,
    required this.accentColor,
    required this.emoji,
  });

  static const List<ProjectData> projects = [
    ProjectData(
      title: 'Bees of Business',
      subtitle: 'Business Networking App',
      emoji: '🐝',
      description:
          'A comprehensive business networking platform that connects professionals, '
          'enabling meaningful connections and fostering business growth through events '
          'and profile-based networking. Built to handle thousands of concurrent users.',
      features: [
        'Smart user connection & networking graph',
        'Rich profile system with portfolio showcase',
        'Event creation, management & RSVP',
        'Business matchmaking algorithm',
        'Push notifications & real-time updates',
      ],
      techStack: ['Flutter', 'Dart', 'REST APIs', 'Bloc', 'Firebase'],
      challenges:
          'Built a scalable connection system with real-time updates and complex '
          'profile management with multi-layered data synchronization across devices.',
      icon: Icons.hive_rounded,
      accentColor: Color(0xFFFFA726),
    ),
    ProjectData(
      title: 'Qansult',
      subtitle: 'Consultation Platform',
      emoji: '💬',
      description:
          'A modern consultation platform connecting domain experts with clients, '
          'featuring seamless booking workflows and integrated real-time chat '
          'for professional consultations across multiple domains.',
      features: [
        'Expert discovery & booking system',
        'Real-time chat with media sharing',
        'Consultation scheduling & calendar sync',
        'Rating & review system with analytics',
        'Secure payment integration',
      ],
      techStack: ['Flutter', 'Dart', 'REST APIs', 'Firebase', 'Bloc'],
      challenges:
          'Implemented real-time bidirectional chat with optimistic UI updates and a robust '
          'booking system with conflict resolution and timezone handling.',
      icon: Icons.forum_rounded,
      accentColor: Color(0xFF42A5F5),
    ),
    ProjectData(
      title: 'Swift Project',
      subtitle: 'Service-Based System',
      emoji: '⚡',
      description:
          'A service-oriented application built to streamline backend-driven '
          'workflows, providing a clean and intuitive interface for managing '
          'complex service requests and multi-step operations.',
      features: [
        'Backend-driven dynamic UI rendering',
        'Service request lifecycle management',
        'Role-based access control & permissions',
        'Automated workflow pipelines',
        'Offline-first with sync capabilities',
      ],
      techStack: ['Flutter', 'Dart', 'REST APIs', 'Bloc'],
      challenges:
          'Designed a flexible, backend-driven UI architecture that adapts to '
          'dynamic service configurations without requiring app updates.',
      icon: Icons.speed_rounded,
      accentColor: Color(0xFF66BB6A),
    ),
    ProjectData(
      title: 'AllCollegeEvent',
      subtitle: 'Event Discovery App',
      emoji: '🎓',
      description:
          'An event discovery platform for college students to find, filter, '
          'and engage with events across multiple institutions, featuring '
          'smart recommendations and social engagement features.',
      features: [
        'AI-powered event recommendations',
        'Advanced multi-filter search engine',
        'Category-based browsing with tags',
        'Event listing with rich media details',
        'Social sharing & friend invitations',
      ],
      techStack: ['Flutter', 'Dart', 'REST APIs', 'Firebase', 'Bloc'],
      challenges:
          'Built an efficient filtering engine with infinite-scroll pagination and '
          'category-based search across thousands of events with sub-100ms response.',
      icon: Icons.event_rounded,
      accentColor: Color(0xFFEF5350),
    ),
  ];
}

class SkillData {
  final String name;
  final double level;
  final IconData icon;
  final String category;

  const SkillData({
    required this.name,
    required this.level,
    required this.icon,
    required this.category,
  });

  static const List<SkillData> skills = [
    SkillData(
      name: 'Flutter',
      level: 0.92,
      icon: Icons.flutter_dash,
      category: 'Frontend',
    ),
    SkillData(
      name: 'Dart',
      level: 0.90,
      icon: Icons.code_rounded,
      category: 'Language',
    ),
    SkillData(
      name: 'REST APIs',
      level: 0.85,
      icon: Icons.api_rounded,
      category: 'Backend',
    ),
    SkillData(
      name: 'Firebase',
      level: 0.82,
      icon: Icons.cloud_rounded,
      category: 'Backend',
    ),
    SkillData(
      name: 'Bloc / Cubit',
      level: 0.88,
      icon: Icons.layers_rounded,
      category: 'State Mgmt',
    ),
    SkillData(
      name: 'Figma',
      level: 0.80,
      icon: Icons.draw_rounded,
      category: 'UI/UX',
    ),
    SkillData(
      name: 'CI/CD Pipeline',
      level: 0.78,
      icon: Icons.rocket_launch_rounded,
      category: 'DevOps',
    ),
    SkillData(
      name: 'Android Deploy',
      level: 0.85,
      icon: Icons.android_rounded,
      category: 'Deploy',
    ),
    SkillData(
      name: 'iOS Deploy',
      level: 0.82,
      icon: Icons.apple_rounded,
      category: 'Deploy',
    ),
    SkillData(
      name: 'UI/UX Design',
      level: 0.85,
      icon: Icons.design_services_rounded,
      category: 'Design',
    ),
    SkillData(
      name: 'Clean Arch',
      level: 0.87,
      icon: Icons.architecture_rounded,
      category: 'Architecture',
    ),
  ];
}

class ExperienceData {
  final String role;
  final String company;
  final String duration;
  final String description;
  final IconData icon;

  const ExperienceData({
    required this.role,
    required this.company,
    required this.duration,
    required this.description,
    required this.icon,
  });

  static const List<ExperienceData> experiences = [
    ExperienceData(
      role: 'Flutter Developer',
      company: 'Freelance / Projects',
      duration: '2023 - Present',
      description:
          'Building production-ready mobile apps with Flutter, '
          'implementing clean architecture and state management with Bloc.',
      icon: Icons.rocket_launch_rounded,
    ),
    ExperienceData(
      role: 'Mobile App Developer',
      company: 'Project-Based',
      duration: '2022 - 2023',
      description:
          'Developed cross-platform mobile applications, '
          'integrating REST APIs and Firebase services.',
      icon: Icons.phone_android_rounded,
    ),
  ];
}
