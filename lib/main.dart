// lib/main.dart

import 'package:flutter/material.dart';
import 'package:url_strategy/url_strategy.dart';

// Import ALL dedicated page files
import 'pages/home_page.dart'; 
import 'pages/menu_viewer_page.dart'; 
import 'pages/placeholder_page.dart'; // Still imported for general use, though less used now
import 'pages/features_page.dart';      
import 'pages/pricing_page.dart';      
import 'pages/login_page.dart';        
import 'pages/register_venue_page.dart'; 
import 'pages/how_it_works_page.dart'; // The dedicated page

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
          bodyLarge: TextStyle(fontSize: 16.0, color: kTextDark),
          bodyMedium: TextStyle(fontSize: 14.0, color: kTextDark),
          labelLarge: TextStyle(fontSize: 14.0, fontWeight: FontWeight.bold),
        ),
        // Primary Button Theme
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            foregroundColor: Colors.white, 
            backgroundColor: kPrimaryAccentSpicy,
            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            textStyle: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            elevation: 5,
          ),
        ),
        // Input Field Decoration Theme
        inputDecorationTheme: InputDecorationTheme(
          contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
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
      
      // 1. Static Routes 
      initialRoute: '/',
      routes: {
        '/': (context) => const HomePage(),
        
        // CORRECTED: Routing to all dedicated page classes
        '/features': (context) => const FeaturesPage(),         
        '/pricing': (context) => const PricingPage(),           
        '/login': (context) => const LoginPage(),               
        '/register': (context) => const RegisterVenuePage(),    
        '/how-it-works': (context) => const HowItWorksPage(), 
      },

      // 2. Dynamic Route Handler (For Guest Menu Access)
      onGenerateRoute: (settings) {
        if (settings.name!.startsWith('/menu/')) {
          final code = settings.name!.substring('/menu/'.length); 
          
          return MaterialPageRoute(
            settings: settings,
            builder: (context) => MenuViewerPage(shortCode: code),
          );
        }
        // Fallback for unknown routes
        return MaterialPageRoute(
          builder: (context) => const Scaffold(body: Center(child: Text('404 Not Found'))),
        );
      },
    );
  }
}