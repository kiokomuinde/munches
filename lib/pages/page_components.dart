// lib/pages/page_components.dart

import 'package:flutter/material.dart';
import '../main.dart'; // Import theme constants

// Custom web-style navigation header to replace AppBar
class CustomPageHeader extends StatelessWidget {
  final String title;
  final String route; // Current route, used for highlighting the active link

  const CustomPageHeader({
    super.key,
    required this.title,
    required this.route,
  });

  
  Widget _navBarButton(BuildContext context, String title, String targetRoute) {
    final isSelected = route == targetRoute;
    final Color activeColor = kPrimaryAccentSpicy;

    // Use a Container wrapper to apply a subtle, rounded background color 
    // for the active button, achieving a more modern, transparent look.
    return Container(
      decoration: isSelected
          ? BoxDecoration(
              color: activeColor.withOpacity(0.12), // Subtle light background (12% opacity)
              borderRadius: BorderRadius.circular(8),
            )
          : null,
      
      child: TextButton(
        onPressed: () {
          Navigator.of(context).pushNamed(targetRoute);
        },
        // Adjust padding and size to ensure the hit area looks clean within the container
        style: TextButton.styleFrom(
          padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
          minimumSize: Size.zero, 
          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        ),
        child: Text(
          title,
          style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                // Use primary accent color for text, maintain consistency
                color: isSelected ? activeColor : kTextDark.withOpacity(0.8),
                fontWeight: isSelected ? FontWeight.w700 : FontWeight.w600,
                decoration: TextDecoration.none, // Removed the underline
              ),
        ),
      ),
    );
  }


  @override
  Widget build(BuildContext context) {
    final isDesktop = MediaQuery.of(context).size.width > 800;

    return Container(
      padding: EdgeInsets.symmetric(horizontal: isDesktop ? 80.0 : 20.0, vertical: 15.0),
      decoration: BoxDecoration(
        color: kBackgroundSweet.withOpacity(0.98), 
        boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 5)],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Logo and Brand Name (Tappable to go home)
          InkWell(
            onTap: () => Navigator.of(context).pushNamed('/'),
            child: Text(
              'Munches',
              style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                    color: kPrimaryAccentSpicy,
                    fontWeight: FontWeight.w900,
                    fontSize: isDesktop ? 30 : 24,
                  ),
            ),
          ),
          
          if (isDesktop)
            // Desktop Navigation Links
            Row(
              children: [
                _navBarButton(context, 'Features', '/features'),
                _navBarButton(context, 'How It Works', '/how-it-works'),
                _navBarButton(context, 'Pricing', '/pricing'),
                const SizedBox(width: 20),
                TextButton(
                  onPressed: () => Navigator.of(context).pushNamed('/login'),
                  child: Text('Login', style: Theme.of(context).textTheme.labelLarge!.copyWith(color: kTextDark.withOpacity(0.8))),
                ),
                const SizedBox(width: 10),
                ElevatedButton(
                  onPressed: () => Navigator.of(context).pushNamed('/register'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: kPrimaryAccentSpicy,
                    padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 15),
                    textStyle: const TextStyle(fontSize: 16),
                    elevation: 8, 
                  ),
                  child: const Text('Register Venue'),
                ),
              ],
            )
          else
            // Mobile Menu Placeholder
            IconButton(
              icon: const Icon(Icons.home_rounded, color: kTextDark),
              onPressed: () {
                // For mobile, simply navigate back home
                Navigator.of(context).pushNamed('/');
              },
            ),
        ],
      ),
    );
  }
}