// lib/pages/home_page.dart

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'dart:async'; 
import 'package:url_launcher/url_launcher.dart'; 
import '../main.dart'; 

// --- NEW ENUM FOR INPUT MODE ---
enum InputMode { code, scan }

// --- CONSTANTS AND MOCK DATA ---
const double kDesktopWidth = 1200.0;
const double kTabletWidth = 800.0;
const double kSectionPadding = 80.0;

const List<Map<String, dynamic>> kFeatureData = [
  // ... (Feature data remains unchanged)
  {
    'icon': Icons.qr_code_scanner_rounded,
    'title': 'Instant Menu Access',
    'subtitle': 'Zero-fuss QR and Short Code entry. Tap it. Taste it. Love it. No downloads needed.',
    'color': Colors.blueAccent,
  },
  {
    'icon': Icons.update_rounded,
    'title': 'Real-Time Updates',
    'subtitle': 'Change prices, mark specials, or flag sold-out items instantly from your management portal.',
    'color': kSecondaryAccentYummy,
  },
  {
    'icon': Icons.insights_rounded,
    'title': 'Performance Insights',
    'subtitle': 'Track views, peak hours, and popular items to optimize your menu and service.',
    'color': kPrimaryAccentSpicy,
  },
  {
    'icon': Icons.security_rounded,
    'title': 'Global Compliance & Security',
    'subtitle': 'Built on a robust, secure cloud platform designed for international standards and data integrity.',
    'color': Colors.green,
  },
];

const List<Map<String, dynamic>> kTestimonials = [
  // ... (Testimonials data remains unchanged)
  {
    'quote': "Munches single-handedly cut our menu printing costs by 90% and allowed us to adapt to supply issues immediately. Our revenue increased 12% in the first quarter!",
    'name': 'Chef Alice Njeri',
    'venue': 'The Nairobi Bistro, Kenya',
  },
  {
    'quote': "The short code fallback is genius. Our customers love the speed, and we love the agility of updating our daily specials in seconds.",
    'name': 'Mark Chen',
    'venue': 'The Spice Loft, Singapore',
  },
  {
    'quote': "Beyond hygiene, the analytics dashboard showed us which items to push during which hours. It's a game-changer for revenue management.",
    'name': 'Isabella Rodriguez',
    'venue': 'Hotel Estrella, Spain',
  },
];

// --- MAIN WIDGET ---

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with SingleTickerProviderStateMixin {
  late ScrollController _scrollController;
  late AnimationController _animationController;
  final TextEditingController _codeController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  bool _isScrolled = false;
  
  // State variables for the animated slogan
  final List<String> _animatedSlogans = ['Tap it.', 'Taste it.', 'Love it.'];
  int _currentSloganIndex = 0;
  late Timer _sloganTimer;
  
  InputMode _currentMode = InputMode.code; 

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController()
      ..addListener(() {
        final isScrolled = _scrollController.offset > 50;
        if (isScrolled != _isScrolled) {
          setState(() {
            _isScrolled = isScrolled;
          });
        }
      });

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2), 
    )..repeat(reverse: true); 

    // Initialize the slogan animation timer (switches every 1.5 seconds)
    _sloganTimer = Timer.periodic(const Duration(milliseconds: 1500), (timer) {
      setState(() {
        _currentSloganIndex = (_currentSloganIndex + 1) % _animatedSlogans.length;
      });
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _animationController.dispose();
    _codeController.dispose();
    _emailController.dispose();
    _sloganTimer.cancel(); // Dispose the timer
    super.dispose();
  }

  // --- HELPER WIDGETS ---

  Widget _buildTopNavBar(bool isDesktop) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      padding: EdgeInsets.symmetric(horizontal: isDesktop ? 80.0 : 20.0, vertical: 15.0),
      decoration: _isScrolled 
          ? BoxDecoration(
              color: kBackgroundSweet.withOpacity(0.98), 
              boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 5)],
            )
          : const BoxDecoration(
              color: Colors.transparent,
            ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Logo and Brand Name
          Text(
            'Munches',
            style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                  color: kPrimaryAccentSpicy,
                  fontWeight: FontWeight.w900,
                  fontSize: isDesktop ? 30 : 24,
                ),
          ),
          
          if (isDesktop)
            Row(
              children: [
                _navBarButton('Features'),
                _navBarButton('How It Works'),
                _navBarButton('Pricing'),
                const SizedBox(width: 20),
                TextButton(
                  // LOGIN LINK: Now uses the named route
                  onPressed: () {
                    Navigator.of(context).pushNamed('/login');
                  },
                  child: Text('Login', style: Theme.of(context).textTheme.labelLarge!.copyWith(color: kTextDark.withOpacity(0.8))),
                ),
                const SizedBox(width: 10),
                ElevatedButton(
                  // REGISTER VENUE CTA: Now uses the named route
                  onPressed: () {
                    Navigator.of(context).pushNamed('/register');
                  },
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
            IconButton(
              icon: const Icon(Icons.menu, color: kTextDark),
              onPressed: () {
                // Ensure context is within a Scaffold, which it is in the main build method
                Scaffold.of(context).openEndDrawer();
              },
            ),
        ],
      ),
    );
  }

  Widget _navBarButton(String title) {
    String route;
    // Map button title to its corresponding named route
    if (title == 'Features') {
      route = '/features';
    } else if (title == 'How It Works') {
      route = '/how-it-works';
    } else if (title == 'Pricing') {
      route = '/pricing';
    } else {
      route = '/'; 
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0),
      child: TextButton(
        onPressed: () {
          // NAVIGATE TO STATIC NAMED ROUTE
          Navigator.of(context).pushNamed(route);
        },
        child: Text(
          title,
          style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                color: kTextDark,
                fontWeight: FontWeight.w600,
              ),
        ),
      ),
    );
  }

  // --- SECTION WIDGETS ---

  Widget _buildHeroSection(bool isDesktop) {
    // ... (Section code remains unchanged)
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            kBackgroundSweet, 
            kSecondaryAccentYummy.withOpacity(0.3), 
            kBackgroundSweet.withOpacity(0.8)
          ],
        ),
      ),
      padding: EdgeInsets.symmetric(
        horizontal: isDesktop ? 80.0 : 30.0,
        vertical: isDesktop ? 100.0 : 60.0,
      ),
      constraints: const BoxConstraints(minHeight: 700),
      child: isDesktop
          ? Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(child: _buildHeroText(isDesktop)),
                const SizedBox(width: 80),
                Expanded(child: _buildHeroImage(isDesktop)),
              ],
            )
          : Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                _buildHeroImage(isDesktop),
                const SizedBox(height: 40),
                _buildHeroText(isDesktop),
              ],
            ),
    );
  }
  
  // WIDGET: Animated Three-Word Slogan (Tap it. Taste it. Love it.)
  Widget _buildAnimatedThreeWordSlogan(bool isDesktop) {
    // ... (Slogan code remains unchanged)
    return SizedBox(
      height: isDesktop ? 40 : 30, // Fixed height to prevent layout jump
      child: AnimatedSwitcher(
        duration: const Duration(milliseconds: 600),
        // FIX: Replaced Curves.easeInOutBack with Curves.easeInOutCubic 
        // to prevent parametric value assertion error on web.
        switchInCurve: Curves.easeInOutCubic, 
        switchOutCurve: Curves.easeIn, 
        transitionBuilder: (Widget child, Animation<double> animation) {
          // Slide Transition (from bottom)
          final slide = Tween<Offset>(
            begin: const Offset(0.0, 1.0), // Start from below
            end: Offset.zero,
          ).animate(CurvedAnimation(
            parent: animation,
            curve: Curves.easeOutCubic, 
          ));

          // Combine Slide and Fade
          return ClipRect(
            child: SlideTransition(
              position: slide, 
              child: FadeTransition(
                opacity: animation,
                child: child,
              ),
            ),
          );
        },
        child: Text(
          _animatedSlogans[_currentSloganIndex],
          // Key is MANDATORY for AnimatedSwitcher to know the content changed
          key: ValueKey<int>(_currentSloganIndex), 
          style: Theme.of(context).textTheme.titleLarge!.copyWith(
                fontSize: isDesktop ? 30 : 24,
                fontWeight: FontWeight.w800,
                // Color changed to kSecondaryAccentYummy (Orange) as requested
                color: kSecondaryAccentYummy, 
                letterSpacing: 1.2,
              ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }

  Widget _buildHeroText(bool isDesktop) {
    // ... (Hero text code remains largely unchanged)
    return Column(
      crossAxisAlignment: isDesktop ? CrossAxisAlignment.start : CrossAxisAlignment.center,
      mainAxisAlignment: isDesktop ? MainAxisAlignment.center : MainAxisAlignment.start,
      children: [
        // 1. Main Headline
        Text(
          'Ditch the Paper. Serve the Future of Dining.',
          style: Theme.of(context).textTheme.displayLarge!.copyWith(
                fontSize: isDesktop ? 68 : 52, 
                height: 1.1,
                color: kTextDark,
              ),
          textAlign: isDesktop ? TextAlign.left : TextAlign.center,
        ),
        const SizedBox(height: 20), 

        // 2. Animated Slogan
        _buildAnimatedThreeWordSlogan(isDesktop),

        const SizedBox(height: 20),
        
        // 3. Subtext
        Text(
          'The globally compliant platform for instant, hygienic, and up-to-the-minute digital menus. Empowering hospitality, delightful for guests.',
          style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                fontSize: 18,
                color: kTextDark.withOpacity(0.8),
              ),
          textAlign: isDesktop ? TextAlign.left : TextAlign.center,
        ),
        const SizedBox(height: 40),
        
        // Primary CTA Button (Registration)
        SizedBox(
          width: isDesktop ? 300 : double.infinity,
          child: ElevatedButton(
            // PRIMARY CTA: Now uses the named route
            onPressed: () {
              Navigator.of(context).pushNamed('/register');
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: kPrimaryAccentSpicy,
              elevation: 10, 
            ),
            child: const Text('Register Your Venue Now'),
          ),
        ),
        
        const SizedBox(height: 30),
        
        // START: ANIMATED INPUT SLIDER 
        SizedBox(
          width: isDesktop ? 450 : double.infinity,
          child: Column(
            children: [
              // 1. Toggle Switch
              _buildInputToggle(isDesktop),
              const SizedBox(height: 20),
              
              // 2. Animated Content
              AnimatedSwitcher(
                duration: const Duration(milliseconds: 400),
                transitionBuilder: (Widget child, Animation<double> animation) {
                  // Sliding transition effect 
                  final slideAnimation = Tween<Offset>(
                    // Determine slide direction based on the key (mode)
                    begin: child.key == const ValueKey<InputMode>(InputMode.code) ? const Offset(-1.0, 0.0) : const Offset(1.0, 0.0),
                    end: Offset.zero,
                  ).animate(animation);

                  return ClipRRect(
                    borderRadius: BorderRadius.circular(15),
                    child: SlideTransition(
                      position: slideAnimation,
                      child: FadeTransition(
                        opacity: animation,
                        child: child,
                      ),
                    ),
                  );
                },
                child: _buildInputContent(isDesktop),
              ),
            ],
          ),
        ),
        // END: ANIMATED INPUT SLIDER
      ],
    );
  }
  
  // Widget to build the toggle buttons
  Widget _buildInputToggle(bool isDesktop) {
    // ... (Toggle code remains unchanged)
    return Container(
      decoration: BoxDecoration(
        color: kBackgroundSweet,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: kTextDark.withOpacity(0.1)),
      ),
      padding: const EdgeInsets.all(5),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          _toggleButton(
            mode: InputMode.code,
            icon: Icons.vpn_key_rounded,
            label: 'Enter Code',
            isSelected: _currentMode == InputMode.code,
          ),
          _toggleButton(
            mode: InputMode.scan,
            icon: Icons.qr_code_scanner_rounded,
            label: 'Scan QR',
            isSelected: _currentMode == InputMode.scan,
          ),
        ],
      ),
    );
  }

  // Individual toggle button
  Widget _toggleButton({
    required InputMode mode,
    required IconData icon,
    required String label,
    required bool isSelected,
  }) {
    // ... (Toggle button code remains unchanged)
    return InkWell(
      onTap: () {
        setState(() {
          _currentMode = mode;
        });
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        decoration: BoxDecoration(
          color: isSelected ? kPrimaryAccentSpicy : Colors.transparent,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          children: [
            Icon(
              icon,
              color: isSelected ? Colors.white : kTextDark.withOpacity(0.8),
              size: 20,
            ),
            const SizedBox(width: 8),
            Text(
              label,
              style: TextStyle(
                color: isSelected ? Colors.white : kTextDark,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Widget to build the animated content based on the current mode
  Widget _buildInputContent(bool isDesktop) {
    // We use a ValueKey to tell AnimatedSwitcher the widgets are different
    switch (_currentMode) {
      case InputMode.code:
        return Container(
          key: const ValueKey<InputMode>(InputMode.code),
          padding: EdgeInsets.all(isDesktop ? 15.0 : 10.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(15),
            boxShadow: [
              BoxShadow(
                color: kTextDark.withOpacity(0.1),
                blurRadius: 20,
                offset: const Offset(0, 8),
              ),
            ],
          ),
          child: Row(
            children: [
              const Icon(Icons.vpn_key_rounded, color: kPrimaryAccentSpicy),
              const SizedBox(width: 10),
              Expanded(
                child: TextField(
                  controller: _codeController,
                  decoration: const InputDecoration(
                    hintText: 'Enter Restaurant Short Code (e.g., HR1234)',
                    hintStyle: TextStyle(color: Colors.grey, fontSize: 16),
                    contentPadding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                    isDense: true,
                    border: InputBorder.none, 
                    focusedBorder: InputBorder.none,
                    fillColor: Colors.white,
                    filled: true,
                  ),
                ),
              ),
              const SizedBox(width: 10),
              ElevatedButton(
                // MENU VIEW CTA: Now uses the Dynamic Route
                onPressed: () {
                  final code = _codeController.text.trim();
                  if (code.isNotEmpty) {
                    // Navigate to the dynamic route /menu/{code}
                    Navigator.of(context).pushNamed('/menu/$code');
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: kSecondaryAccentYummy,
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                  textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  elevation: 5, 
                ),
                child: const Text('View Menu'),
              ),
            ],
          ),
        );
        
      case InputMode.scan:
        return Container(
          key: const ValueKey<InputMode>(InputMode.scan),
          height: 90, // Match the height of the code input box
          decoration: BoxDecoration(
            color: kSecondaryAccentYummy.withOpacity(0.1),
            borderRadius: BorderRadius.circular(15),
            border: Border.all(color: kSecondaryAccentYummy, width: 2),
            boxShadow: [
              BoxShadow(
                color: kTextDark.withOpacity(0.05),
                blurRadius: 10,
                offset: const Offset(0, 5),
              ),
            ],
          ),
          child: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.camera_alt_rounded, size: 30, color: kPrimaryAccentSpicy),
                const SizedBox(width: 15),
                Text(
                  'Click here to activate camera and scan QR',
                  style: Theme.of(context).textTheme.titleLarge!.copyWith(
                        color: kTextDark,
                        fontSize: 18,
                      ),
                ),
              ],
            ),
          ),
        );
    }
  }


  Widget _buildHeroImage(bool isDesktop) {
    // ... (Hero image code remains unchanged)
    final slideAnimation = Tween<Offset>(
      begin: const Offset(0.3, 0), 
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.fastOutSlowIn, 
    ));
    
    return FadeTransition(
      opacity: _animationController,
      child: SlideTransition(
        position: slideAnimation,
        child: Container(
          height: isDesktop ? 500 : 350,
          decoration: BoxDecoration(
            color: Colors.white, 
            borderRadius: BorderRadius.circular(20),
            // Stronger, warmer shadow
            boxShadow: [
              BoxShadow(
                color: kSecondaryAccentYummy.withOpacity(0.4),
                blurRadius: 40,
                offset: const Offset(10, 20),
              ),
            ],
          ),
          child: Center(
            child: Text(
              '',
              style: TextStyle(color: kTextDark.withOpacity(0.5)),
            ),
          ),
        ),
      ),
    );
  }

  // Testimonials Section
  Widget _buildTestimonialSection(bool isDesktop) {
    // ... (Testimonial code remains unchanged)
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            kPrimaryAccentSpicy.withOpacity(0.05), 
            kSecondaryAccentYummy.withOpacity(0.18), 
          ],
        ),
      ),
      padding: const EdgeInsets.symmetric(
        horizontal: kSectionPadding,
        vertical: kSectionPadding,
      ),
      child: Column(
        children: [
          Text(
            'Trusted Globally. Real Results.',
            style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                  color: kPrimaryAccentSpicy, 
                  fontSize: isDesktop ? 40 : 32,
                ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 50),
          LayoutBuilder(
            builder: (context, constraints) {
              int crossAxisCount = constraints.maxWidth > kDesktopWidth ? 3 : (constraints.maxWidth > kTabletWidth ? 2 : 1);

              return GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: kTestimonials.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: crossAxisCount,
                  crossAxisSpacing: 30.0,
                  mainAxisSpacing: 30.0,
                  childAspectRatio: isDesktop ? 1.5 : 1.3,
                ),
                itemBuilder: (context, index) {
                  return _buildTestimonialCard(kTestimonials[index]);
                },
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildTestimonialCard(Map<String, dynamic> data) {
    // ... (Testimonial card code remains unchanged)
    return Container(
      padding: const EdgeInsets.all(25.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: kSecondaryAccentYummy.withOpacity(0.15),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(Icons.format_quote_rounded, size: 36, color: kSecondaryAccentYummy),
          const SizedBox(height: 15),
          Expanded(
            child: Text(
              data['quote'] as String,
              style: Theme.of(context).textTheme.bodyLarge!.copyWith(fontStyle: FontStyle.italic, fontSize: 16),
            ),
          ),
          const Divider(height: 30, color: kBackgroundSweet),
          Text(
            data['name'] as String,
            style: Theme.of(context).textTheme.titleLarge!.copyWith(fontSize: 18, fontWeight: FontWeight.bold, color: kPrimaryAccentSpicy), 
          ),
          const SizedBox(height: 5),
          Text(
            data['venue'] as String,
            style: Theme.of(context).textTheme.bodyLarge!.copyWith(color: kTextDark.withOpacity(0.7)),
          ),
        ],
      ),
    );
  }

  // Feature Section
  Widget _buildFeatureSection(bool isDesktop) {
    // ... (Feature section code remains unchanged)
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.symmetric(
        horizontal: kSectionPadding,
        vertical: kSectionPadding,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            'The Foundation of Modern Hospitality',
            style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                  color: kTextDark,
                  fontSize: isDesktop ? 40 : 32,
                ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 50),
          LayoutBuilder(
            builder: (context, constraints) {
              int crossAxisCount;
              if (constraints.maxWidth > kDesktopWidth) {
                crossAxisCount = 4;
              } else if (constraints.maxWidth > kTabletWidth) {
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
                  crossAxisSpacing: 40.0,
                  mainAxisSpacing: 40.0,
                  childAspectRatio: isDesktop ? 1.0 : 1.5,
                ),
                itemBuilder: (context, index) {
                  return _buildFeatureCard(kFeatureData[index]);
                },
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildFeatureCard(Map<String, dynamic> data) {
    // ... (Feature card code remains unchanged)
    return Container(
      padding: const EdgeInsets.all(30.0),
      decoration: BoxDecoration(
        color: kBackgroundSweet,
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: data['color'].withOpacity(0.3), width: 2), 
        boxShadow: [
          BoxShadow(
            color: kTextDark.withOpacity(0.08),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(data['icon'] as IconData, size: 48, color: data['color']),
          const SizedBox(height: 20),
          Text(
            data['title'] as String,
            style: Theme.of(context).textTheme.titleLarge!.copyWith(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          Expanded(
            child: Text(
              data['subtitle'] as String,
              style: Theme.of(context).textTheme.bodyLarge!.copyWith(color: kTextDark.withOpacity(0.7)),
            ),
          ),
        ],
      ),
    );
  }

  // How It Works Section
  Widget _buildHowItWorksSection(bool isDesktop) {
    // ... (How It Works code remains unchanged)
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            kBackgroundSweet.withOpacity(0.8),
            kBackgroundSweet,
          ],
        ),
      ),
      padding: EdgeInsets.symmetric(
        horizontal: isDesktop ? 80.0 : 30.0,
        vertical: kSectionPadding,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            'Ready to Go Digital? Three Simple Steps.',
            style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                  color: kPrimaryAccentSpicy, 
                  fontSize: isDesktop ? 40 : 32,
                ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 60),
          
          _buildProcessStep(
            stepNumber: 1,
            title: 'Setup Your Venue Profile',
            description: 'Quickly register your hotel or restaurant and customize your digital menu with your logo and branding colors.',
            icon: Icons.store_mall_directory_rounded,
            isDesktop: isDesktop,
          ),
          const SizedBox(height: 50),
          _buildAnimatedDivider(isDesktop),
          const SizedBox(height: 50),

          _buildProcessStep(
            stepNumber: 2,
            title: 'Design Your Dynamic Menu',
            description: 'Use our intuitive drag-and-drop builder to add categories, items, prices, descriptions, and dietary tags.',
            icon: Icons.menu_book_rounded,
            isDesktop: isDesktop,
          ),
          const SizedBox(height: 50),
          _buildAnimatedDivider(isDesktop),
          const SizedBox(height: 50),

          _buildProcessStep(
            stepNumber: 3,
            title: 'Deploy, Print, & Go Live!',
            description: 'Instantly generate your unique QR and short codes. Print the design and place them on tables. Start tracking views immediately.',
            icon: Icons.cloud_download_rounded,
            isDesktop: isDesktop,
          ),
        ],
      ),
    );
  }

  Widget _buildProcessStep({
    required int stepNumber,
    required String title,
    required String description,
    required IconData icon,
    required bool isDesktop,
  }) {
    // ... (Process step code remains unchanged)
    bool isReverse = stepNumber % 2 == 0 && isDesktop;

    final stepContent = [
      SizedBox(
        width: isDesktop ? 450 : double.infinity,
        child: Column(
          crossAxisAlignment: isReverse ? CrossAxisAlignment.end : CrossAxisAlignment.start,
          children: [
            Text(
              'STEP $stepNumber',
              style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                    color: kSecondaryAccentYummy,
                    fontWeight: FontWeight.w600,
                  ),
              textAlign: isReverse ? TextAlign.right : TextAlign.left,
            ),
            const SizedBox(height: 10),
            Text(
              title,
              style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                    fontSize: isDesktop ? 36 : 28,
                    color: kTextDark,
                  ),
              textAlign: isReverse ? TextAlign.right : TextAlign.left,
            ),
            const SizedBox(height: 20),
            Text(
              description,
              style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                    fontSize: 17,
                    color: kTextDark.withOpacity(0.8),
                  ),
              textAlign: isReverse ? TextAlign.right : TextAlign.left,
            ),
          ],
        ),
      ),
      
      // Icon Circle
      Container(
        height: 120,
        width: 120,
        decoration: BoxDecoration(
          color: kPrimaryAccentSpicy.withOpacity(0.1), 
          shape: BoxShape.circle,
          border: Border.all(color: kPrimaryAccentSpicy, width: 3), 
          boxShadow: [
            BoxShadow(
              color: kPrimaryAccentSpicy.withOpacity(0.2), 
              blurRadius: 15,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: Icon(icon, size: 50, color: kPrimaryAccentSpicy), 
      ),
    ];

    return isDesktop
        ? Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: isReverse ? stepContent.reversed.toList() : stepContent,
          )
        : Column(
            children: [
              stepContent[1],
              const SizedBox(height: 30),
              stepContent[0],
            ],
          );
  }

  Widget _buildAnimatedDivider(bool isDesktop) {
    // ... (Divider code remains unchanged)
    return RotationTransition(
      turns: Tween<double>(begin: 0.0, end: 0.5).animate(_animationController),
      child: const Icon(
        Icons.arrow_downward_rounded,
        size: 50,
        color: kSecondaryAccentYummy,
      ),
    );
  }

  // Subscription Widget - Full Width Background
  Widget _buildSubscriptionSection(bool isDesktop) {
    // ... (Subscription section code remains unchanged)
    return Container(
      width: double.infinity, 
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            kSecondaryAccentYummy.withOpacity(0.95), 
            kPrimaryAccentSpicy.withOpacity(0.9), 
          ],
        ),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: isDesktop ? 80.0 : 30.0,
          vertical: kSectionPadding,
        ),
        child: Column(
          children: [
            Text(
              'Stay Updated. Get Exclusive Offers.',
              style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                    color: Colors.white,
                    fontSize: isDesktop ? 40 : 32,
                  ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            Text(
              'Subscribe to our newsletter for updates on new features, pricing changes, and special promotions.',
              style: Theme.of(context).textTheme.bodyLarge!.copyWith(color: Colors.white.withOpacity(0.9)),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 40),
            Container(
              width: isDesktop ? 600 : double.infinity,
              padding: const EdgeInsets.all(8.0), 
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    blurRadius: 15,
                    offset: const Offset(0, 10),
                  ),
                ],
              ),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _emailController,
                      decoration: const InputDecoration(
                        hintText: 'Enter your business email...',
                        hintStyle: TextStyle(color: Colors.grey),
                        contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                        isDense: true,
                        border: InputBorder.none,
                        filled: false,
                      ),
                      keyboardType: TextInputType.emailAddress,
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      if (_emailController.text.isNotEmpty) {
                        print('Subscribed email: ${_emailController.text}');
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Thank you for subscribing!')),
                        );
                        _emailController.clear();
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: kPrimaryAccentSpicy, 
                      padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 18),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      elevation: 5,
                    ),
                    child: const Text('Subscribe'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }


  Widget _buildFooter(bool isDesktop) {
    // ... (Footer code remains largely unchanged)
    return Container(
      color: kTextDark,
      padding: EdgeInsets.symmetric(
        horizontal: isDesktop ? 80.0 : 30.0,
        vertical: 50.0,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Munches',
            style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                  color: kSecondaryAccentYummy,
                  fontWeight: FontWeight.w900,
                  fontSize: 30,
                ),
          ),
          const SizedBox(height: 30),
          isDesktop
              ? Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _buildFooterColumn('Product', ['Features', 'Pricing', 'API Docs', 'Short Code Lookup']),
                    _buildFooterColumn('Company', ['About Us', 'Mission', 'Careers', 'Contact']),
                    _buildFooterColumn('Legal', ['Terms of Service', 'Privacy Policy', 'Cookie Settings', 'Sitemap']),
                    _buildFooterContact(isDesktop),
                  ],
                )
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildFooterColumn('Product', ['Features', 'Pricing', 'API Docs']),
                    const SizedBox(height: 30),
                    _buildFooterColumn('Company', ['About Us', 'Mission', 'Contact']),
                    const SizedBox(height: 30),
                    _buildFooterContact(isDesktop),
                  ],
                ),
          const Divider(color: Colors.white54, height: 60),
          Text(
            '© ${DateTime.now().year} Munches. All rights reserved. Built for the global hospitality market.',
            style: const TextStyle(color: Colors.white70, fontSize: 14),
          ),
        ],
      ),
    );
  }

  Widget _buildFooterColumn(String title, List<String> links) {
    // ... (Footer column code remains unchanged)
    return SizedBox(
      width: 200,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: Theme.of(context).textTheme.titleLarge!.copyWith(color: Colors.white, fontSize: 20),
          ),
          const SizedBox(height: 15),
          ...links.map((link) => Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: InkWell(
                  onTap: () {
                    // TODO: Implement navigation for footer links if necessary
                  },
                  child: Text(
                    link,
                    style: const TextStyle(color: Colors.white70, fontSize: 16),
                  ),
                ),
              )),
        ],
      ),
    );
  }

  Widget _buildFooterContact(bool isDesktop) {
    // ... (Footer contact code remains unchanged)
    return SizedBox(
      width: isDesktop ? 300 : double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Global Support',
            style: Theme.of(context).textTheme.titleLarge!.copyWith(color: Colors.white, fontSize: 20),
          ),
          const SizedBox(height: 15),
          Row(
            children: [
              const Icon(Icons.email, color: Colors.white70, size: 20),
              const SizedBox(width: 10),
              Text('support@munches.co', style: Theme.of(context).textTheme.bodyLarge!.copyWith(color: Colors.white70)),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              const Icon(Icons.phone, color: Colors.white70, size: 20),
              const SizedBox(width: 10),
              Text('+1 800-MUN-CHIZ', style: Theme.of(context).textTheme.bodyLarge!.copyWith(color: Colors.white70)),
            ],
          ),
          const SizedBox(height: 20),
          const Text('Follow Us:', style: TextStyle(color: Colors.white, fontSize: 16)),
          const SizedBox(height: 10),
          const Row(
            children: [
              Icon(Icons.facebook, color: Colors.white70, size: 24),
              SizedBox(width: 15),
              Icon(Icons.camera_alt, color: Colors.white70, size: 24), 
              SizedBox(width: 15),
              Icon(Icons.public, color: Colors.white70, size: 24), 
            ],
          ),
        ],
      ),
    );
  }

  // --- MAIN BUILD METHOD ---

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final isDesktop = screenSize.width > kTabletWidth;

    return Scaffold(
      body: Stack(
        children: [
          SingleChildScrollView(
            controller: _scrollController,
            child: Column(
              children: [
                _buildHeroSection(isDesktop), 
                _buildFeatureSection(isDesktop), 
                _buildTestimonialSection(isDesktop), 
                _buildHowItWorksSection(isDesktop),
                _buildSubscriptionSection(isDesktop), 
                _buildFooter(isDesktop), 
              ],
            ),
          ),
          
          // Sticky Navigation Bar
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: _buildTopNavBar(isDesktop),
          ),
        ],
      ),
      endDrawer: !isDesktop
          ? Drawer(
              child: ListView(
                padding: EdgeInsets.zero,
                children: [
                  DrawerHeader(
                    decoration: BoxDecoration(color: kPrimaryAccentSpicy),
                    child: Text('Munches', style: Theme.of(context).textTheme.headlineLarge!.copyWith(color: Colors.white)),
                  ),
                  // DRAWER LINKS: Now use named routes
                  ListTile(title: const Text('Features'), onTap: () => Navigator.of(context).pushNamed('/features')),
                  ListTile(title: const Text('How It Works'), onTap: () => Navigator.of(context).pushNamed('/how-it-works')),
                  ListTile(title: const Text('Pricing'), onTap: () => Navigator.of(context).pushNamed('/pricing')),
                  const Divider(),
                  ListTile(title: const Text('Login'), onTap: () => Navigator.of(context).pushNamed('/login')),
                  ListTile(
                    title: Text('Register Venue', style: TextStyle(color: kPrimaryAccentSpicy, fontWeight: FontWeight.bold)),
                    onTap: () => Navigator.of(context).pushNamed('/register'),
                  ),
                ],
              ),
            )
          : null,
    );
  }
}