import 'package:flutter/material.dart';

class Responsive {
  static const double mobileBreakpoint = 768;
  static const double tabletBreakpoint = 1200;

  static bool isMobile(BuildContext context) =>
      MediaQuery.of(context).size.width < mobileBreakpoint;

  static bool isTablet(BuildContext context) =>
      MediaQuery.of(context).size.width >= mobileBreakpoint &&
      MediaQuery.of(context).size.width < tabletBreakpoint;

  static bool isDesktop(BuildContext context) =>
      MediaQuery.of(context).size.width >= tabletBreakpoint;

  static double contentWidth(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    if (width >= tabletBreakpoint) return 1100;
    if (width >= mobileBreakpoint) return width * 0.9;
    return width * 0.92;
  }

  static EdgeInsets sectionPadding(BuildContext context) {
    if (isMobile(context)) {
      return const EdgeInsets.symmetric(horizontal: 20, vertical: 60);
    }
    if (isTablet(context)) {
      return const EdgeInsets.symmetric(horizontal: 40, vertical: 80);
    }
    return const EdgeInsets.symmetric(horizontal: 80, vertical: 100);
  }
}
