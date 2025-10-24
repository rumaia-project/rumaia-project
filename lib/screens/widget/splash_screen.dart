import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:rumaia_project/main.dart';
import 'package:rumaia_project/screens/admin/admin_dashboard.dart';
import 'package:rumaia_project/screens/auth/role_switcher.dart';
import 'package:rumaia_project/screens/property/dashboard_property.dart';
import 'package:rumaia_project/screens/widget/onboarding.dart';
import 'package:rumaia_project/widgets/developer/botnavbar.dart';
import 'package:rumaia_project/widgets/investor/bot_nav_bar.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );

    _scaleAnimation = Tween<double>(
      begin: 0.5,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.elasticOut));

    _controller.forward();
    _checkFirstTime();
  }

  Future<void> _checkFirstTime() async {
    await Future.delayed(const Duration(seconds: 3));

    final prefs = await SharedPreferences.getInstance();
    final bool hasSeenOnboarding = prefs.getBool('hasSeenOnboarding') ?? false;
    final bool isLoggedIn = prefs.getBool('isLoggedIn') ?? false;
    final String? savedRole = prefs.getString('userRole');

    if (!mounted) return;

    if (isLoggedIn && savedRole != null) {
      // User sudah login, langsung ke dashboard sesuai role
      _navigateToDashboard(savedRole);
    } else if (hasSeenOnboarding) {
      // Sudah pernah onboarding tapi belum login
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const RoleSwitcherScreen()),
      );
    } else {
      // Pertama kali buka app
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const OnboardingScreen()),
      );
    }
  }

  void _navigateToDashboard(String role) {
    // Import dashboard sesuai role
    Widget destination;
    switch (role) {
      case 'Admin':
        destination = const AdminDashboardScreen();
        break;
      case 'Customer':
        destination = const MainNavigation();
        break;
      case 'Developer':
        destination = const BotnavbarScreen();
        break;
      case 'Property':
        destination = const DashboardProperty();
        break;
      case 'Investor':
        destination = const InvestorBotNavBarScreen();
        break;
      default:
        destination = const RoleSwitcherScreen();
    }

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => destination),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: Container(
        width: size.width,
        height: size.height,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xFF2196F3), // Blue
              Color(0xFF00BCD4), // Cyan
            ],
          ),
        ),
        child: Stack(
          children: [
            // Background Pattern
            ...List.generate(20, (index) {
              return Positioned(
                top: (index * 100) % size.height,
                left: (index * 150) % size.width,
                child: FadeIn(
                  delay: Duration(milliseconds: index * 100),
                  child: Container(
                    width: 80,
                    height: 80,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white.withOpacity(0.05),
                    ),
                  ),
                ),
              );
            }),

            // Main Content
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Logo dengan animasi
                  ScaleTransition(
                    scale: _scaleAnimation,
                    child: FadeIn(
                      duration: const Duration(milliseconds: 1000),
                      child: Container(
                        width: 140,
                        height: 140,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.2),
                              blurRadius: 30,
                              spreadRadius: 10,
                            ),
                          ],
                        ),
                        child: const Icon(
                          Icons.home_work_rounded,
                          size: 80,
                          color: Color(0xFF2196F3),
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 30),

                  // App Name
                  FadeInUp(
                    delay: const Duration(milliseconds: 500),
                    child: const Text(
                      'Rumaia',
                      style: TextStyle(
                        fontSize: 48,
                        fontWeight: FontWeight.w900,
                        color: Colors.white,
                        letterSpacing: 2,
                        shadows: [
                          Shadow(
                            color: Colors.black26,
                            offset: Offset(2, 2),
                            blurRadius: 4,
                          ),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 10),

                  // Tagline
                  FadeInUp(
                    delay: const Duration(milliseconds: 700),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 24,
                        vertical: 8,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: const Text(
                        'Property Management System',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                          letterSpacing: 0.5,
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 60),

                  // Loading Indicator
                  FadeInUp(
                    delay: const Duration(milliseconds: 1000),
                    child: Column(
                      children: [
                        SizedBox(
                          width: 40,
                          height: 40,
                          child: CircularProgressIndicator(
                            strokeWidth: 3,
                            valueColor: AlwaysStoppedAnimation<Color>(
                              Colors.white.withOpacity(0.8),
                            ),
                          ),
                        ),
                        const SizedBox(height: 16),
                        Text(
                          'Loading...',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                            color: Colors.white.withOpacity(0.8),
                            letterSpacing: 1,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            // Version at bottom
            Positioned(
              bottom: 30,
              left: 0,
              right: 0,
              child: FadeInUp(
                delay: const Duration(milliseconds: 1200),
                child: Text(
                  'Version 1.0.0',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    color: Colors.white.withOpacity(0.6),
                    letterSpacing: 0.5,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
