// lib/pages/pricing_page.dart

import 'package:flutter/material.dart';
import '../main.dart'; // Import theme colors
import 'page_components.dart'; // NEW Import

class PricingPage extends StatelessWidget {
  const PricingPage({super.key});

  @override
  Widget build(BuildContext context) {
    final isDesktop = MediaQuery.of(context).size.width > 800;
    final primaryColor = Theme.of(context).primaryColor;
    final secondaryColor = Theme.of(context).colorScheme.secondary;

    return Scaffold(
      backgroundColor: kBackgroundSweet,
      // AppBar removed for website look
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Use the consistent custom web header
            const CustomPageHeader(title: 'Pricing', route: '/pricing'),
            _buildHeader(context, isDesktop, primaryColor, secondaryColor), 
            _buildPricingCards(isDesktop, primaryColor, secondaryColor),
            const SizedBox(height: 80),
            // NOTE: Add a footer here in a complete website.
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context, bool isDesktop, Color primaryColor, Color secondaryColor) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: isDesktop ? 80.0 : 30.0,
        vertical: 60.0,
      ),
      color: kBackgroundSweet,
      child: Column(
        children: [
          Text(
            'Simple Pricing. Powerful Results.',
            style: Theme.of(context).textTheme.displayLarge!.copyWith(
              fontSize: isDesktop ? 56 : 40,
              color: kTextDark,
              height: 1.1,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 20),
          Text(
            'No hidden fees. Choose the plan that fits your venue size and business needs. All plans include 24/7 support.',
            style: Theme.of(context).textTheme.bodyLarge!.copyWith(
              fontSize: 18,
              color: kTextDark.withOpacity(0.8),
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 40),
          // Example toggle for monthly/annual pricing
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(50),
              border: Border.all(color: primaryColor.withOpacity(0.3)),
            ),
            child: Text(
              'Annually (Save 20%) | Monthly',
              style: TextStyle(
                color: primaryColor,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPricingCards(bool isDesktop, Color primaryColor, Color secondaryColor) {
    const List<Map<String, dynamic>> plans = [
      {
        'name': 'Starter',
        'price': '\$9',
        'subtitle': 'Per venue / month (Billed Annually)',
        'features': ['1 Digital Menu', 'Short Code Access', 'Real-Time Updates', 'Basic Analytics'],
        'isPopular': false,
        'buttonText': 'Start Free Trial',
      },
      {
        'name': 'Pro Venue',
        'price': '\$29',
        'subtitle': 'Per venue / month (Billed Annually)',
        'features': ['5 Digital Menus', 'QR Code Generation', 'Advanced Analytics', 'Menu Scheduling', 'Priority Support', 'Dedicated Onboarding'],
        'isPopular': true,
        'buttonText': 'Go Pro',
      },
      {
        'name': 'Enterprise',
        'price': 'Custom',
        'subtitle': 'For large chains and hotels',
        'features': ['Unlimited Menus', 'Multi-Language Support', 'Dedicated Account Manager', 'Custom API Integration', 'SLA Guarantee', 'On-Site Training'],
        'isPopular': false,
        'buttonText': 'Contact Sales',
      },
    ];

    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: isDesktop ? 80.0 : 30.0,
        vertical: 50.0,
      ),
      child: LayoutBuilder(
        builder: (context, constraints) {
          int crossAxisCount = constraints.maxWidth > 1000 ? 3 : (constraints.maxWidth > 600 ? 2 : 1);
          
          return GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: plans.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: crossAxisCount,
              crossAxisSpacing: 30.0,
              mainAxisSpacing: 30.0,
              childAspectRatio: isDesktop ? 0.8 : 1.0,
            ),
            itemBuilder: (context, index) {
              final plan = plans[index];
              final accentColor = plan['isPopular'] ? secondaryColor : primaryColor;
              
              return _buildPlanCard(context, plan, accentColor);
            },
          );
        },
      ),
    );
  }

  Widget _buildPlanCard(BuildContext context, Map<String, dynamic> plan, Color accentColor) {
    final isPopular = plan['isPopular'] as bool;

    return Card(
      elevation: isPopular ? 15 : 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
        side: BorderSide(color: accentColor, width: isPopular ? 4 : 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (isPopular)
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 10),
              decoration: BoxDecoration(
                color: accentColor,
                borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
              ),
              child: const Text(
                '🥇 MOST POPULAR',
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.white, fontWeight: FontWeight.w900, fontSize: 16),
              ),
            ),
          Padding(
            padding: const EdgeInsets.all(30.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  plan['name'] as String,
                  style: Theme.of(context).textTheme.headlineLarge!.copyWith(color: accentColor, fontSize: 36, fontWeight: FontWeight.w900),
                ),
                const SizedBox(height: 15),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      plan['price'] as String,
                      style: Theme.of(context).textTheme.displayLarge!.copyWith(fontSize: 48, color: kTextDark),
                    ),
                    if (plan['price'] != 'Custom')
                      Padding(
                        padding: const EdgeInsets.only(bottom: 8.0, left: 4.0),
                        child: Text(
                          '/mo',
                          style: Theme.of(context).textTheme.bodyLarge!.copyWith(color: kTextDark.withOpacity(0.6), fontWeight: FontWeight.w600),
                        ),
                      ),
                  ],
                ),
                Text(
                  plan['subtitle'] as String,
                  style: Theme.of(context).textTheme.bodyLarge!.copyWith(color: kTextDark.withOpacity(0.7), fontSize: 14),
                ),
                const Divider(height: 40, color: Colors.grey),
                ...((plan['features'] as List<String>).map((feature) => Padding(
                  padding: const EdgeInsets.only(bottom: 15.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Icon(Icons.check_circle_rounded, color: accentColor, size: 20),
                      const SizedBox(width: 10),
                      Flexible(
                        child: Text(
                          feature,
                          style: Theme.of(context).textTheme.bodyLarge!.copyWith(height: 1.2),
                        ),
                      ),
                    ],
                  ),
                )).toList()),
                const SizedBox(height: 30),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pushNamed(plan['name'] == 'Enterprise' ? '/contact' : '/register');
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: accentColor,
                      padding: const EdgeInsets.symmetric(vertical: 20),
                      elevation: 10,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    ),
                    child: Text(plan['buttonText'] as String),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}