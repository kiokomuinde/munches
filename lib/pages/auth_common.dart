// lib/pages/auth_common.dart

import 'package:flutter/material.dart';
import '../main.dart'; // Import theme colors

// Common Widget for branded text fields
class AuthTextField extends StatelessWidget {
  final String labelText;
  final IconData icon;
  final bool obscureText;
  final TextEditingController? controller;
  final TextInputType keyboardType;

  const AuthTextField({
    super.key,
    required this.labelText,
    required this.icon,
    this.obscureText = false,
    this.controller,
    this.keyboardType = TextInputType.text,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      obscureText: obscureText,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        labelText: labelText,
        prefixIcon: Icon(icon, color: kPrimaryAccentSpicy),
        fillColor: Colors.white,
        filled: true,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: kSecondaryAccentYummy, width: 2),
        ),
      ),
      style: const TextStyle(color: kTextDark),
    );
  }
}

// Common Widget for the Auth Card layout (Enhanced)
class AuthCard extends StatelessWidget {
  final String title;
  final Widget content;
  final bool isDesktop;

  const AuthCard({
    super.key,
    required this.title,
    required this.content,
    required this.isDesktop,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 550), // Slightly wider card
        child: Container(
          margin: EdgeInsets.all(isDesktop ? 50.0 : 20.0),
          padding: EdgeInsets.all(isDesktop ? 50.0 : 30.0), // More padding
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(25), // Rounded corners
            boxShadow: [
              // Stronger, more charming shadow
              BoxShadow(
                color: kPrimaryAccentSpicy.withOpacity(0.25),
                blurRadius: 40,
                offset: const Offset(0, 15),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Small decorative element above the title
              Container(
                width: 60,
                height: 5,
                decoration: BoxDecoration(
                  color: kSecondaryAccentYummy,
                  borderRadius: BorderRadius.circular(5),
                ),
              ),
              const SizedBox(height: 20),
              Text(
                title,
                style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                      color: kPrimaryAccentSpicy,
                      fontSize: isDesktop ? 40 : 32,
                      fontWeight: FontWeight.w900,
                    ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 30),
              content,
            ],
          ),
        ),
      ),
    );
  }
}