// lib/pages/login_page.dart

import 'package:flutter/material.dart';
import '../main.dart';
import 'auth_common.dart'; 
import 'page_components.dart'; // NEW Import

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  
  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _handleLogin() {
    if (_emailController.text.isEmpty || _passwordController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter email and password.')),
      );
      return;
    }
    
    print('Attempting login for: ${_emailController.text}');
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Login attempt successful! (Placeholder)')),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDesktop = MediaQuery.of(context).size.width > 800;
    
    return Scaffold(
      backgroundColor: kBackgroundSweet, // Set base color
      // AppBar removed for website look
      body: Container(
        // Apply gradient to the entire body container for charm
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [kBackgroundSweet, kPrimaryAccentSpicy.withOpacity(0.05)],
          ),
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [
              // 1. Custom Header
              const CustomPageHeader(title: 'Login', route: '/login'),
              
              // 2. Auth Card
              AuthCard(
                title: 'Welcome Back, Venue Manager',
                isDesktop: isDesktop,
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
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
                    const SizedBox(height: 35),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: _handleLogin,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: kPrimaryAccentSpicy,
                          padding: const EdgeInsets.symmetric(vertical: 20),
                          elevation: 10,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                        ),
                        child: const Text('Login to Dashboard'),
                      ),
                    ),
                    const SizedBox(height: 20),
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pushReplacementNamed('/register');
                      },
                      child: Text(
                        'Don\'t have an account? Register Venue',
                        style: Theme.of(context).textTheme.bodyLarge!.copyWith(color: kSecondaryAccentYummy, fontWeight: FontWeight.bold),
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