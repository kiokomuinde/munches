// lib/pages/how_it_works_page.dart

import 'package:flutter/material.dart';
import '../main.dart'; // To access kTextDark, kPrimaryAccentSpicy, etc.
import 'page_components.dart'; // NEW: Import the custom header component

class HowItWorksPage extends StatelessWidget {
  const HowItWorksPage({super.key});

  final List<Map<String, dynamic>> steps = const [
    {
      'number': 1,
      'title': 'Venue Setup & Menu Builder',
      'icon': Icons.store_rounded,
      'description': '''Register your venue and use our intuitive drag-and-drop builder to craft your menu. Define categories, set prices, and add tempting descriptions and photos in minutes.''',
      'color': kPrimaryAccentSpicy,
    },
    {
      'number': 2,
      'title': 'Instant Code Generation',
      'icon': Icons.qr_code_scanner_rounded,
      'description': '''Munches instantly generates a unique **QR Code** and a **Short Code** for your venue. Download, print, or integrate them seamlessly into your existing materials.''',
      'color': kSecondaryAccentYummy,
    },
    {
      'number': 3,
      'title': 'Guest Scans or Enters Code',
      'icon': Icons.touch_app_rounded,
      'description': '''Guests simply point their phone camera at the QR code, or manually enter the short code into the Munches website on their device. No app download is ever required.''',
      'color': Color(0xFF5AA9E6), // A custom complementary color
    },
    {
      'number': 4,
      'title': 'Menu Appears Instantly',
      'icon': Icons.restaurant_menu_rounded,
      'description': '''The full, beautifully designed, and hygienic digital menu appears instantly. Changes you make in your portal (like 'sold out' flags) are reflected in real-time.''',
      'color': Color(0xFF6A994E), // A custom complementary color
    },
  ];

  @override
  Widget build(BuildContext context) {
    // Determine screen size for responsiveness
    final double screenWidth = MediaQuery.of(context).size.width;
    final bool isDesktop = screenWidth > 900;
    
    // Constant padding from home_page.dart
    const double kSectionPadding = 80.0; 

    return Scaffold(
      // AppBar is explicitly set to null as the header is now part of the body.
      appBar: null, 
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // FIX: Added the Custom Navigation Bar for consistency
            const CustomPageHeader(title: 'How It Works', route: '/how-it-works'),

            // The rest of the page content is wrapped in Padding
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: isDesktop ? kSectionPadding : 20.0,
                vertical: kSectionPadding,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Headline Section
                  Text(
                    'Ditching Paper in 4 Simple Steps',
                    style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                          color: kTextDark,
                          fontSize: isDesktop ? 48 : 36,
                        ),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    'Munches simplifies the menu experience for both you and your guests. Here is the magic behind the digital shift:',
                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                          fontSize: 18,
                          color: kTextDark.withOpacity(0.8),
                        ),
                  ),
                  const SizedBox(height: 60),

                  // Steps Grid/List
                  GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                      maxCrossAxisExtent: 400.0, // Max width for each card
                      mainAxisExtent: isDesktop ? 300 : 280, // Height for each card
                      crossAxisSpacing: 40.0,
                      mainAxisSpacing: 40.0,
                    ),
                    itemCount: steps.length,
                    itemBuilder: (context, index) {
                      final step = steps[index];
                      return _buildStepCard(
                        context,
                        step['number'] as int,
                        step['title'] as String,
                        step['icon'] as IconData,
                        step['description'] as String,
                        step['color'] as Color,
                      );
                    },
                  ),
                  
                  const SizedBox(height: 80),
                  
                  // Call to Action
                  Center(
                    child: Column(
                      children: [
                        Text(
                          'Ready to Get Started?',
                          style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                                color: kPrimaryAccentSpicy,
                                fontWeight: FontWeight.bold,
                              ),
                        ),
                        const SizedBox(height: 20),
                        SizedBox(
                          height: 60,
                          child: ElevatedButton(
                            onPressed: () {
                              // Link back to the registration page route
                              Navigator.of(context).pushNamed('/register');
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: kPrimaryAccentSpicy,
                              padding: const EdgeInsets.symmetric(horizontal: 40),
                              elevation: 10,
                            ),
                            child: const Text(
                              'Register Your Venue Now',
                              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Helper Widget for a single step card
  Widget _buildStepCard(
    BuildContext context,
    int number,
    String title,
    IconData icon,
    String description,
    Color color,
  ) {
    return Container(
      padding: const EdgeInsets.all(30.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: color.withOpacity(0.2),
            blurRadius: 15,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Step Number and Icon
          Row(
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: color,
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: Text(
                    '$number',
                    style: Theme.of(context).textTheme.titleLarge!.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.w900,
                          fontSize: 18,
                        ),
                  ),
                ),
              ),
              const SizedBox(width: 15),
              Icon(icon, size: 30, color: color),
            ],
          ),
          const SizedBox(height: 20),

          // Title
          Text(
            title,
            style: Theme.of(context).textTheme.titleLarge!.copyWith(
                  color: kTextDark,
                  fontWeight: FontWeight.bold,
                ),
          ),
          const SizedBox(height: 10),

          // Description
          Expanded(
            child: Text(
              description,
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    color: kTextDark.withOpacity(0.8),
                    height: 1.6,
                  ),
            ),
          ),
        ],
      ),
    );
  }
}