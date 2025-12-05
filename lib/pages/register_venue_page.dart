// lib/pages/register_venue_page.dart

import 'package:flutter/material.dart';
import '../main.dart';
import 'auth_common.dart'; 
import 'page_components.dart'; // NEW Import

class RegisterVenuePage extends StatefulWidget {
  const RegisterVenuePage({super.key});

  @override
  State<RegisterVenuePage> createState() => _RegisterVenuePageState();
}

class _RegisterVenuePageState extends State<RegisterVenuePage> {
  final TextEditingController _venueNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();
  
  @override
  void dispose() {
    _venueNameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  void _handleRegistration() {
    if (_venueNameController.text.isEmpty || _emailController.text.isEmpty || _passwordController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please fill out all required fields.')),
      );
      return;
    }
    if (_passwordController.text != _confirmPasswordController.text) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Passwords do not match.')),
      );
      return;
    }
    
    print('Attempting registration for: ${_venueNameController.text} at ${_emailController.text}');
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Registration successful! Check your email for verification. (Placeholder)')),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDesktop = MediaQuery.of(context).size.width > 800;
    
    return Scaffold(
      backgroundColor: kBackgroundSweet,
      // AppBar removed for website look
      body: Container(
        // Apply gradient to the entire body container for charm
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: [kBackgroundSweet, kSecondaryAccentYummy.withOpacity(0.05)],
          ),
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [
              // 1. Custom Header
              const CustomPageHeader(title: 'Register Venue', route: '/register'),

              // 2. Auth Card
              AuthCard(
                title: 'Start Your Digital Menu Journey',
                isDesktop: isDesktop,
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    AuthTextField(
                      controller: _venueNameController,
                      labelText: 'Venue Name (e.g., The Nairobi Bistro)',
                      icon: Icons.store_mall_directory_rounded,
                    ),
                    const SizedBox(height: 25),
                    AuthTextField(
                      controller: _emailController,
                      labelText: 'Business Email',
                      icon: Icons.email_rounded,
                      keyboardType: TextInputType.emailAddress,
                    ),
                    const SizedBox(height: 25),
                    AuthTextField(
                      controller: _passwordController,
                      labelText: 'Password',
                      icon: Icons.lock_rounded,
                      obscureText: true,
                    ),
                    const SizedBox(height: 25),
                    AuthTextField(
                      controller: _confirmPasswordController,
                      labelText: 'Confirm Password',
                      icon: Icons.check_circle_rounded,
                      obscureText: true,
                    ),
                    const SizedBox(height: 35),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: _handleRegistration,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: kSecondaryAccentYummy, // Using secondary accent for registration CTA
                          padding: const EdgeInsets.symmetric(vertical: 20),
                          elevation: 10,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                        ),
                        child: const Text('Register and Get Started'),
                      ),
                    ),
                    const SizedBox(height: 20),
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pushReplacementNamed('/login');
                      },
                      child: Text(
                        'Already have an account? Login',
                        style: Theme.of(context).textTheme.bodyLarge!.copyWith(color: kPrimaryAccentSpicy, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 50), // Add bottom margin
            ],
          ),
        ),
      ),
    );
  }
}