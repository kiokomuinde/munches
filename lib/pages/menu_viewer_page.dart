// lib/pages/menu_viewer_page.dart

import 'package:flutter/material.dart';

class MenuViewerPage extends StatelessWidget {
  final String shortCode;
  
  const MenuViewerPage({super.key, required this.shortCode});

  @override
  Widget build(BuildContext context) {
    // Access the defined theme colors from main.dart
    final primaryColor = Theme.of(context).primaryColor;
    final secondaryColor = Theme.of(context).colorScheme.secondary;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Munches Menu: $shortCode', 
          style: Theme.of(context).textTheme.titleLarge!.copyWith(color: Colors.white)
        ),
        backgroundColor: primaryColor,
        elevation: 0,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(32.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.restaurant_menu_rounded, size: 80, color: secondaryColor),
              const SizedBox(height: 20),
              Text(
                'Fetching Menu Data for Venue Code: $shortCode',
                style: Theme.of(context).textTheme.headlineLarge,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 10),
              Text(
                'This is the dedicated guest view. You would replace this placeholder with the actual menu loading and display logic.',
                style: Theme.of(context).textTheme.bodyLarge,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 40),
              CircularProgressIndicator(color: primaryColor), // FIX: Removed const
            ],
          ),
        ),
      ),
    );
  }
}