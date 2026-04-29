import 'package:flutter/material.dart';

class AppColors {
  // Primary colors
  static const Color primary = Color(0xFF6366F1); // Indigo 500
  static const Color secondary = Color(0xFF8B5CF6); // Violet 500
  static const Color accent = Color(0xFF10B981); // Emerald 500
  static const Color warning = Color(0xFFF59E0B); // Amber 500
  static const Color error = Color(0xFFEF4444); // Red 500
  
  // Background colors
  static const Color background = Color(0xFF0F172A); // Slate 900
  static const Color surface = Color(0xFF1E293B); // Slate 800
  static const Color surfaceLight = Color(0xFF334155); // Slate 700
  
  // Text colors
  static const Color textPrimary = Colors.white;
  static const Color textSecondary = Color(0xFF94A3B8); // Slate 400
  static const Color textMuted = Color(0xFF64748B); // Slate 500
  
  // Gradients
  static const LinearGradient primaryGradient = LinearGradient(
    colors: [primary, secondary],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static final LinearGradient glassGradient = LinearGradient(
    colors: [
      Colors.white.withOpacity(0.1),
      Colors.white.withOpacity(0.02),
    ],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static final LinearGradient surfaceGradient = LinearGradient(
    colors: [
      surface,
      surface.withOpacity(0.8),
    ],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );
}
