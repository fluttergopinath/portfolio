import 'package:flutter/material.dart';

class AppColors {
  AppColors._();

  // ─── Deep Premium Dark Theme ───
  static const darkBackground = Color(0xFF030303);
  static const darkSurface = Color(0xFF080808);
  static const darkCard = Color(0xFF0C0C0C);
  static const darkNavbar = Color(0xFF050505);
  
  // ─── Glow & Glass Colors ───
  static const glassBorder = Color(0x33FFFFFF);
  static const glassHighlight = Color(0x1AFFFFFF);
  
  // ─── Light Theme (Minimal/Premium) ───
  static const lightBackground = Color(0xFFFBFBFE);
  static const lightSurface = Color(0xFFFFFFFF);
  static const lightCard = Color(0xFFF1F3F5);
  static const lightNavbar = Color(0xFFFFFFFF);

  // ─── Futuristic Accent & Neon ───
  static const primary = Color(0xFF8B5CF6); // Modern Violet
  static const secondary = Color(0xFF06B6D4); // Cyan/Aqua
  static const accent = Color(0xFFEC4899); // Pink/Rose
  
  static const primaryGlow = Color(0x668B5CF6);
  static const secondaryGlow = Color(0x6606B6D4);
  static const accentGlow = Color(0x66EC4899);

  // ─── Gradients ───
  static const LinearGradient premiumGradient = LinearGradient(
    colors: [primary, secondary],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient sunsetGradient = LinearGradient(
    colors: [primary, accent],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient darkGlowGradient = LinearGradient(
    colors: [Color(0xFF1E1B4B), Color(0xFF030303)],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );

  // ─── Text ───
  static const darkTextPrimary = Color(0xFFF8FAFC);
  static const darkTextSecondary = Color(0xFF94A3B8);
  static const darkTextTertiary = Color(0xFF475569);

  static const lightTextPrimary = Color(0xFF0F172A);
  static const lightTextSecondary = Color(0xFF475569);
  static const lightTextTertiary = Color(0xFF94A3B8);
}

