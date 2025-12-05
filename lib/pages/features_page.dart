// lib/pages/features_page.dart

import 'package:flutter/material.dart';
import '../main.dart'; 
import 'home_page.dart'; // For kFeatureData and kTabletWidth
import 'page_components.dart'; // NEW Import

class FeaturesPage extends StatelessWidget {
  const FeaturesPage({super.key});

  @override
  Widget build(BuildContext context) {
    final isDesktop = MediaQuery.of(context).size.width > kTabletWidth;
    final primaryColor = Theme.of(context).primaryColor;

    return Scaffold(
      backgroundColor: kBackgroundSweet, 
      // AppBar removed for website look
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Use the consistent custom web header
            const CustomPageHeader(title: 'Features', route: '/features'), 
            _buildHeader(context, isDesktop, primaryColor),
            _buildFeatureGrid(context, isDesktop),
            const SizedBox(height: 80),
            // NOTE: Add a footer here in a complete website.
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context, bool isDesktop, Color primaryColor) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: isDesktop ? 80.0 : 30.0,
        vertical: 80.0,
      ),
      decoration: BoxDecoration(
        color: kBackgroundSweet,
        border: Border(bottom: BorderSide(color: primaryColor.withOpacity(0.3), width: 1)),
      ),
      child: Column(
        children: [
          Icon(Icons.stars_rounded, size: isDesktop ? 80 : 60, color: kSecondaryAccentYummy),
          const SizedBox(height: 30),
          Text(
            'Go Digital. Go Global. Go Munches.',
            style: Theme.of(context).textTheme.displayLarge!.copyWith(
              fontSize: isDesktop ? 56 : 40,
              color: kTextDark,
              height: 1.1,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 20),
          Text(
            'Explore the powerful tools built for the modern, agile hospitality business. From instant updates to deep insights.',
            style: Theme.of(context).textTheme.bodyLarge!.copyWith(
              fontSize: 18,
              color: kTextDark.withOpacity(0.8),
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 40),
          ElevatedButton(
            onPressed: () => Navigator.of(context).pushNamed('/register'),
            style: ElevatedButton.styleFrom(
              backgroundColor: kSecondaryAccentYummy,
              padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 22),
            ),
            child: const Text('Start 30-Day Free Trial'),
          ),
        ],
      ),
    );
  }

  Widget _buildFeatureGrid(BuildContext context, bool isDesktop) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: isDesktop ? 80.0 : 30.0,
        vertical: 50.0,
      ),
      child: LayoutBuilder(
        builder: (context, constraints) {
          int crossAxisCount;
          // Using hardcoded values as kDesktopWidth/kTabletWidth may not be available here
          if (constraints.maxWidth > 1200.0) {
            crossAxisCount = 3;
          } else if (constraints.maxWidth > 800.0) {
            crossAxisCount = 2;
          } else {
            crossAxisCount = 1;
          }

          return GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: kFeatureData.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: crossAxisCount,
              crossAxisSpacing: 30.0,
              mainAxisSpacing: 30.0,
              childAspectRatio: isDesktop ? 1.2 : 1.5,
            ),
            itemBuilder: (context, index) {
              return _buildFeatureCard(context, kFeatureData[index]);
            },
          );
        },
      ),
    );
  }

  Widget _buildFeatureCard(BuildContext context, Map<String, dynamic> data) {
    final color = data['color'] as Color;
    return Card(
      elevation: 10,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Container(
        padding: const EdgeInsets.all(30.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: color.withOpacity(0.1), width: 1), 
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: color.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(data['icon'] as IconData, size: 40, color: color),
            ),
            const SizedBox(height: 25),
            Text(
              data['title'] as String,
              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                color: kTextDark, 
                fontSize: 24, 
                fontWeight: FontWeight.w800
              ),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: Text(
                data['subtitle'] as String,
                style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                  fontSize: 16, 
                  color: kTextDark.withOpacity(0.7), 
                  height: 1.5
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}