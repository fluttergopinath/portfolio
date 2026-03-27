import 'package:flutter/material.dart';

class AppColors {
  AppColors._();

  // ─── Dark Theme ───
  static const darkBackground = Color(0xFF020202);
  static const darkSurface = Color(0xFF0A0A0A);
  static const darkCard = Color(0xFF111111);
  static const darkNavbar = Color(0xFF050505);

  // ─── Light Theme ───
  static const lightBackground = Color(0xFFF8F9FA);
  static const lightSurface = Color(0xFFFFFFFF);
  static const lightCard = Color(0xFFF1F3F5);
  static const lightNavbar = Color(0xFFFFFFFF);

  // ─── Accent & Neon ───
  static const primary = Color(0xFF7000FF); // Electric Purple
  static const secondary = Color(0xFF00F0FF); // Neon Cyan
  static const accent = Color(0xFFFF00E5); // Neon Pink
  
  static const primaryLight = Color(0xFF9140FF);
  static const secondaryLight = Color(0xFF66F5FF);

  // ─── Gradients ───
  static const LinearGradient primaryGradient = LinearGradient(
    colors: [primary, secondary],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient accentGradient = LinearGradient(
    colors: [primary, accent],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  // ─── Text ───
  static const darkTextPrimary = Color(0xFFFFFFFF);
  static const darkTextSecondary = Color(0xFFA0A0A0);
  static const darkTextTertiary = Color(0xFF606060);

  static const lightTextPrimary = Color(0xFF121212);
  static const lightTextSecondary = Color(0xFF495057);
  static const lightTextTertiary = Color(0xFFADB5BD);
}
