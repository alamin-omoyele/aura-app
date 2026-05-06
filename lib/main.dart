import 'package:flutter/material.dart';
import 'screens/main_scaffold.dart';
import 'utils/app_theme.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  AppTheme.setupSystemUI(true); // Start with light mode UI
  runApp(const CarApp());
}

class CarApp extends StatefulWidget {
  const CarApp({super.key});
  @override State<CarApp> createState() => _CarAppState();
}

class _CarAppState extends State<CarApp> {
  ThemeMode _themeMode = ThemeMode.light;

  void toggleTheme() {
    setState(() {
      _themeMode = _themeMode == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
      AppTheme.setupSystemUI(_themeMode == ThemeMode.dark);
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      themeMode: _themeMode,
      theme: ThemeData(
        brightness: Brightness.light,
        scaffoldBackgroundColor: AppTheme.lightBg,
        primaryColor: AppTheme.lightPrimary,
        useMaterial3: true,
        textTheme: const TextTheme(
          bodyLarge: AppTheme.body,
          bodyMedium: AppTheme.body,
          titleLarge: AppTheme.h2,
          titleMedium: AppTheme.h3,
        ),
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: AppTheme.darkBg,
        primaryColor: AppTheme.darkPrimary,
        useMaterial3: true,
        textTheme: const TextTheme(
          bodyLarge: AppTheme.body,
          bodyMedium: AppTheme.body,
          titleLarge: AppTheme.h2,
          titleMedium: AppTheme.h3,
        ).apply(bodyColor: AppTheme.darkText, displayColor: AppTheme.darkText),
      ),
      home: MainScaffold(onToggleTheme: toggleTheme, isDarkMode: _themeMode == ThemeMode.dark),
    );
  }
}