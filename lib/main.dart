import 'package:flutter/material.dart';
import 'package:rumaia_project/screens/user/home_screen.dart';
import 'package:rumaia_project/screens/user/my_request_screen.dart';
import 'package:rumaia_project/screens/user/profile_screen.dart';
import 'package:rumaia_project/screens/user/property_list.dart';
import 'package:rumaia_project/screens/user/property_request_screen.dart';
import 'package:rumaia_project/screens/widget/botnav.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Rumaia',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MainNavigation(),
    );
  }
}

class MainNavigation extends StatefulWidget {
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
