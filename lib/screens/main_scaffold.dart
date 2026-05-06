import 'package:flutter/material.dart';
import '../utils/app_theme.dart';
import 'dashboard_screen.dart';
import 'analytics_screen.dart';
import 'controls_screen.dart';
import 'maintenance_screen.dart';

class MainScaffold extends StatefulWidget {
  final VoidCallback onToggleTheme;
  final bool isDarkMode;
  const MainScaffold({super.key, required this.onToggleTheme, required this.isDarkMode});

  @override State<MainScaffold> createState() => _MainScaffoldState();
}

class _MainScaffoldState extends State<MainScaffold> {
  int _currentIndex = 0;
  final List<Widget> _screens = const [
    DashboardScreen(),
    ControlsScreen(),
    MaintenanceScreen(),
    AnalyticsScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: const Text('AURA', style: TextStyle(fontSize: 24, fontWeight: FontWeight.w700, letterSpacing: 2)),
        foregroundColor: AppTheme.text(context),
        actions: [
          // 🌓 Theme Toggle Button
          IconButton(
            icon: AnimatedSwitcher(
              duration: const Duration(milliseconds: 200),
              child: Icon(
                widget.isDarkMode ? Icons.light_mode_rounded : Icons.dark_mode_rounded,
                key: ValueKey(widget.isDarkMode),
                size: 24,
              ),
            ),
            onPressed: widget.onToggleTheme,
            tooltip: widget.isDarkMode ? 'Switch to Light Mode' : 'Switch to Dark Mode',
          ),
          const SizedBox(width: 4),
          // 👤 Profile Icon
          Container(
            margin: const EdgeInsets.only(right: 12),
            decoration: BoxDecoration(
              color: AppTheme.primaryLight(context),
              shape: BoxShape.circle,
            ),
            child: IconButton(
              icon: const Icon(Icons.person_outline, size: 22),
              onPressed: () {},
              color: AppTheme.primary(context),
              padding: const EdgeInsets.all(8),
            ),
          ),
        ],
      ),
      body: AnimatedSwitcher(
        duration: const Duration(milliseconds: 250),
        transitionBuilder: (child, animation) => FadeTransition(opacity: animation, child: child),
        child: _screens[_currentIndex],
      ),
      bottomNavigationBar: SafeArea(
        child: Container(
          decoration: BoxDecoration(
            color: AppTheme.surface(context).withOpacity(0.98),
            borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
            boxShadow: AppTheme.cardShadow(context),
            border: Border(top: BorderSide(color: AppTheme.border(context), width: 0.5)),
          ),
          child: BottomNavigationBar(
            currentIndex: _currentIndex,
            onTap: (index) => setState(() => _currentIndex = index),
            type: BottomNavigationBarType.fixed,
            elevation: 0,
            backgroundColor: Colors.transparent,
            selectedItemColor: AppTheme.primary(context),
            unselectedItemColor: AppTheme.textSec(context),
            selectedFontSize: 11,
            unselectedFontSize: 10,
            selectedLabelStyle: const TextStyle(fontWeight: FontWeight.w600, letterSpacing: 0.5),
            unselectedLabelStyle: const TextStyle(fontWeight: FontWeight.w500),
            iconSize: 22,
            items: const [
              BottomNavigationBarItem(icon: Icon(Icons.dashboard_outlined), activeIcon: Icon(Icons.dashboard_rounded), label: 'Status'),
              BottomNavigationBarItem(icon: Icon(Icons.tune_outlined), activeIcon: Icon(Icons.tune_rounded), label: 'Controls'),
              BottomNavigationBarItem(icon: Icon(Icons.build_outlined), activeIcon: Icon(Icons.build_rounded), label: 'Service'),
              BottomNavigationBarItem(icon: Icon(Icons.analytics_outlined), activeIcon: Icon(Icons.analytics_rounded), label: 'Data'),
            ],
          ),
        ),
      ),
    );
  }
}