import 'package:flutter/material.dart';

class AppColors {
  AppColors._();

  // ─── Dark Theme ───
  static const darkBackground = Color(0xFF0D0D0D);
  static const darkSurface = Color(0xFF1A1A2E);
  static const darkCard = Color(0xFF16213E);
  static const darkNavbar = Color(0xFF0A0A0A);

  // ─── Light Theme ───
  static const lightBackground = Color(0xFFF5F5F7);
  static const lightSurface = Color(0xFFFFFFFF);
  static const lightCard = Color(0xFFF0F0F5);
  static const lightNavbar = Color(0xFFFFFFFF);

  // ─── Accent ───
  static const primary = Color(0xFF6C63FF);
  static const primaryLight = Color(0xFF8B83FF);
  static const accent = Color(0xFF00E5FF);
  static const accentDark = Color(0xFF00B8D4);

  // ─── Gradient ───
  static const gradientStart = Color(0xFF6C63FF);
  static const gradientEnd = Color(0xFF00E5FF);

  static const LinearGradient primaryGradient = LinearGradient(
    colors: [gradientStart, gradientEnd],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  // ─── Text ───
  static const darkTextPrimary = Color(0xFFFFFFFF);
  static const darkTextSecondary = Color(0xFFB0B0B0);
  static const darkTextTertiary = Color(0xFF707070);

  static const lightTextPrimary = Color(0xFF1A1A1A);
  static const lightTextSecondary = Color(0xFF555555);
  static const lightTextTertiary = Color(0xFF999999);
}
