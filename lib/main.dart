// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:rumaia_project/screens/admin/admin_dashboard.dart';
import 'package:rumaia_project/screens/auth/role_switcher.dart';
import 'package:rumaia_project/screens/property/dashboard_property.dart';
import 'package:rumaia_project/screens/user/home_screen.dart';
import 'package:rumaia_project/screens/user/my_request_screen.dart';
import 'package:rumaia_project/screens/user/profile_screen.dart';
import 'package:rumaia_project/screens/user/property_list.dart';
import 'package:rumaia_project/screens/user/property_request_screen.dart';
import 'package:rumaia_project/screens/widget/botnav.dart';
import 'package:rumaia_project/screens/widget/splash_screen.dart';
import 'package:rumaia_project/widgets/developer/botnavbar.dart';
import 'package:rumaia_project/widgets/investor/bot_nav_bar.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Rumaia',
      theme: ThemeData(
        primaryColor: const Color(0xFF2196F3),
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF2196F3),
          secondary: const Color(0xFF00BCD4),
        ),
        visualDensity: VisualDensity.adaptivePlatformDensity,
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
      home: const SplashScreen(), // Selalu mulai dari splash screen
    );
  }
}

class MainNavigation extends StatefulWidget {
  const MainNavigation({super.key});

  @override
  _MainNavigationState createState() => _MainNavigationState();
}

class _MainNavigationState extends State<MainNavigation> {
  int _currentIndex = 0;

  // Method untuk navigasi dari home screen
  void _navigateFromHome(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _getCurrentScreen(),
      bottomNavigationBar: BottomNavBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
    );
  }

  Widget _getCurrentScreen() {
    switch (_currentIndex) {
      case 0:
        return HomeScreen(onNavigate: _navigateFromHome);
      case 1:
        return PropertyListScreen();
      case 2:
        return PropertyRequestScreen();
      case 3:
        return MyRequestsScreen();
      case 4:
        return ProfileScreen();
      default:
        return HomeScreen(onNavigate: _navigateFromHome);
    }
  }
}

// Helper class untuk logout dari mana saja
class AuthHelper {
  // Logout function - hapus session tapi tetap simpan hasSeenOnboarding
  static Future<void> logout(BuildContext context) async {
    final prefs = await SharedPreferences.getInstance();

    // Hapus data login tapi tetap simpan hasSeenOnboarding
    await prefs.remove('userRole');
    await prefs.remove('username');

    if (!context.mounted) return;

    // Kembali ke pilih role (skip onboarding)
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (_) => const RoleSwitcherScreen()),
      (route) => false,
    );
  }

  // Get user data dari SharedPreferences
  static Future<Map<String, dynamic>> getUserData() async {
    final prefs = await SharedPreferences.getInstance();
    return {
      'role': prefs.getString('userRole'),
      'username': prefs.getString('username'),
      'hasSeenOnboarding': prefs.getBool('hasSeenOnboarding') ?? false,
    };
  }

  // Get dashboard widget berdasarkan role
  static Widget getDashboardByRole(String role) {
    switch (role) {
      case 'Admin':
        return const AdminDashboardScreen();
      case 'Customer':
        return const MainNavigation();
      case 'Developer':
        return const BotnavbarScreen();
      case 'Property':
        return const DashboardProperty();
      case 'Investor':
        return const InvestorBotNavBarScreen();
      default:
        return const RoleSwitcherScreen();
    }
  }

  // Clear all data (untuk testing/reset)
  static Future<void> clearAllData() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }
}
