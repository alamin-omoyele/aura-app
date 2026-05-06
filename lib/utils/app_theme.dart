import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AppTheme {
  // 🎨 Ethereal Motion Color Palette
  // Light Mode
  static const lightBg = Color(0xFFF8F9F9);
  static const lightSurface = Colors.white;
  static const lightPrimary = Color(0xFF2D423B); // Forest green
  static const lightPrimaryLight = Color(0xFFD0E8DE);
  static const lightText = Color(0xFF172C26);
  static const lightTextSec = Color(0xFF424845);
  static const lightBorder = Color(0xFFE1E3E3);

  // Dark Mode
  static const darkBg = Color(0xFF0A0A0A);
  static const darkSurface = Color(0xFF1A1D1D);
  static const darkPrimary = Color(0xFFB4CCC2); // Lighter green for contrast
  static const darkPrimaryLight = Color(0xFF2D423B);
  static const darkText = Color(0xFFF0F1F1);
  static const darkTextSec = Color(0xFF9CA3AF);
  static const darkBorder = Color(0xFF2E3131);

  // 📏 Layout Constants
  static const screenPadding = EdgeInsets.fromLTRB(24, 0, 24, 0);
  static const cardPadding = EdgeInsets.all(20);
  static const cardRadius = BorderRadius.all(Radius.circular(16));
  static const smallRadius = BorderRadius.all(Radius.circular(12));
  static const pillRadius = BorderRadius.all(Radius.circular(50));

  // 🔤 Google/iOS-Style Typography (Big, Clear, Readable)
  static const TextStyle h1 = TextStyle(
    fontSize: 28, fontWeight: FontWeight.w700, letterSpacing: -0.5, height: 1.2);
  static const TextStyle h2 = TextStyle(
    fontSize: 22, fontWeight: FontWeight.w600, letterSpacing: -0.3, height: 1.3);
  static const TextStyle h3 = TextStyle(
    fontSize: 18, fontWeight: FontWeight.w600, height: 1.4);
  static const TextStyle body = TextStyle(
    fontSize: 16, fontWeight: FontWeight.w400, height: 1.5);
  static const TextStyle bodyBold = TextStyle(
    fontSize: 16, fontWeight: FontWeight.w600, height: 1.5);
  static const TextStyle caption = TextStyle(
    fontSize: 13, fontWeight: FontWeight.w400, color: Color(0xFF6B7280), height: 1.4);
  static const TextStyle label = TextStyle(
    fontSize: 11, fontWeight: FontWeight.w600, letterSpacing: 1.2, height: 1.0);

  // 🌓 Adaptive Helpers (Call these in build() methods)
  static Color bg(BuildContext c) => Theme.of(c).brightness == Brightness.dark ? darkBg : lightBg;
  static Color surface(BuildContext c) => Theme.of(c).brightness == Brightness.dark ? darkSurface : lightSurface;
  static Color primary(BuildContext c) => Theme.of(c).brightness == Brightness.dark ? darkPrimary : lightPrimary;
  static Color primaryLight(BuildContext c) => Theme.of(c).brightness == Brightness.dark ? darkPrimaryLight : lightPrimaryLight;
  static Color text(BuildContext c) => Theme.of(c).brightness == Brightness.dark ? darkText : lightText;
  static Color textSec(BuildContext c) => Theme.of(c).brightness == Brightness.dark ? darkTextSec : lightTextSec;
  static Color border(BuildContext c) => Theme.of(c).brightness == Brightness.dark ? darkBorder : lightBorder;

  // 🎨 Modern Soft Shadow (Subtle elevation)
  static List<BoxShadow> cardShadow(BuildContext c) => [
    BoxShadow(
      color: (Theme.of(c).brightness == Brightness.dark ? Colors.white : Colors.black).withOpacity(0.04),
      blurRadius: 12,
      offset: const Offset(0, 4),
      spreadRadius: 0,
    ),
  ];

  // 🔄 System UI Helper (Call in main.dart)
  static void setupSystemUI(bool isDark) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: isDark ? Brightness.light : Brightness.dark,
      systemNavigationBarColor: Colors.transparent,
      systemNavigationBarIconBrightness: isDark ? Brightness.light : Brightness.dark,
    ));
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
  }
}