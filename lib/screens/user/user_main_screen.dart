// user_main_screen.dart ini kerangka utama yang memiliki BottomNavigationBar yang nampung main page
// main page itu  (home, biodata, family, requests).
import 'package:flutter/material.dart';

import 'biodata_form_screen.dart';
import 'family_management_screen.dart';
import 'my_requests_screen.dart';
import 'property_home_screen.dart';

class UserMainScreen extends StatefulWidget {
  const UserMainScreen({super.key});

  @override
  State<UserMainScreen> createState() => _UserMainScreenState();
}

class _UserMainScreenState extends State<UserMainScreen> {
  int _currentIndex = 0;

  final List<Widget> _screens = const [
    UserHomeScreen(),
    BiodataFormScreen(),
    FamilyManagementScreen(),
    MyRequestsScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    final bool showAppBar = _currentIndex != 0;

    return Scaffold(
      appBar: showAppBar
          ? AppBar(
              title: Text(_getAppBarTitle()),
              backgroundColor: const Color(0xFFF8F9FA),
              elevation: 0.5,
              scrolledUnderElevation: 1,
              centerTitle: true,
            )
          : null,
      body: IndexedStack(index: _currentIndex, children: _screens),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _currentIndex,
        onDestinationSelected: (index) => setState(() => _currentIndex = index),
        backgroundColor: Colors.white,
        indicatorColor: Colors.blue.shade100,
        height: 70,
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.home_work_outlined),
            selectedIcon: Icon(Icons.home_work),
            label: 'Home',
          ),
          NavigationDestination(
            icon: Icon(Icons.person_outline_rounded),
            selectedIcon: Icon(Icons.person_rounded),
            label: 'Biodata',
          ),
          NavigationDestination(
            icon: Icon(Icons.family_restroom_outlined),
            selectedIcon: Icon(Icons.family_restroom),
            label: 'Family',
          ),
          NavigationDestination(
            icon: Icon(Icons.history_outlined),
            selectedIcon: Icon(Icons.history),
            label: 'Requests',
          ),
        ],
      ),
    );
  }

  String _getAppBarTitle() {
    switch (_currentIndex) {
      case 1:
        return 'Biodata';
      case 2:
        return 'Family Management';
      case 3:
        return 'My Requests';
      default:
        return '';
    }
  }
}
