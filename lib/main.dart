// main.dart

import 'package:flutter/material.dart';
import 'package:url_strategy/url_strategy.dart';
import 'pages/home_page.dart';

// --- Color Palette ---
const Color kPrimaryAccentSpicy = Color(0xFFE84A5F); // Bright Red/Coral
const Color kSecondaryAccentYummy = Color(0xFFFF9F1C); // Bright Orange
const Color kTextDark = Color(0xFF323842);
const Color kBackgroundSweet = Color(0xFFFDF3E7);

void main() {
  // Use path strategy for clean web URLs (e.g., /home instead of #/home)
  setPathUrlStrategy();
  runApp(const MunchesApp());
}

class MunchesApp extends StatelessWidget {
  const MunchesApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Munches: Tap it. Taste it. Love it.',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        // Primary Theme Colors
        primaryColor: kPrimaryAccentSpicy,
        colorScheme: ColorScheme.light(
          primary: kPrimaryAccentSpicy,
          secondary: kSecondaryAccentYummy,
          background: kBackgroundSweet,
          surface: Colors.white,
          onPrimary: Colors.white,
          onSecondary: kTextDark,
        ),
        scaffoldBackgroundColor: kBackgroundSweet,
        
        // Font & Typography (Using Montserrat for modern appeal)
        fontFamily: 'Montserrat',
        textTheme: const TextTheme(
          displayLarge: TextStyle(fontSize: 56.0, fontWeight: FontWeight.w900, color: kTextDark), // Headline
          headlineLarge: TextStyle(fontSize: 48.0, fontWeight: FontWeight.w700, color: kTextDark), // Section Titles
          titleLarge: TextStyle(fontSize: 22.0, fontWeight: FontWeight.w600, color: kTextDark),
          bodyLarge: TextStyle(fontSize: 16.0, color: kTextDark, height: 1.5),
          labelLarge: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold, color: Colors.white), // Button Text
        ),
        
        // Button Theme
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: kPrimaryAccentSpicy,
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            textStyle: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ),
        
        // Input Field Theme (For the code entry box)
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: kSecondaryAccentYummy, width: 2),
          ),
          labelStyle: const TextStyle(color: kTextDark),
        ),
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const HomePage(),
      },
    );
  }
}