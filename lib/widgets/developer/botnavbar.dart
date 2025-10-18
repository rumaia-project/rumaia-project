import 'package:flutter/material.dart';
import 'package:rumaia_project/screens/developer/available_project_screen.dart';
import 'package:rumaia_project/screens/developer/home_screen.dart';
import 'package:rumaia_project/screens/developer/my_projects_screen.dart';
import 'package:rumaia_project/screens/developer/portfolio_screen.dart';
import 'package:rumaia_project/screens/developer/profile_screen.dart';
import 'package:rumaia_project/utils/developer/app_color.dart';

class BotnavbarScreen extends StatefulWidget {
  const BotnavbarScreen({super.key});

  @override
  State<BotnavbarScreen> createState() => _BotnavbarScreenState();
}

class _BotnavbarScreenState extends State<BotnavbarScreen> {
  int currentIndex = 0;

  final List<Widget> _pages = const [
    HomeScreen(),
    PortfolioScreen(),
    AvailableProjectsScreen(),
    MyProjectsScreen(),
    ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.backgroundColor,

      // === BODY ===
      body: IndexedStack(index: currentIndex, children: _pages),

      // === BOTTOM NAVIGATION BAR ===
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.white,
        selectedItemColor: AppColor.primaryColor,
        unselectedItemColor: Colors.grey,
        currentIndex: currentIndex,
        showUnselectedLabels: true,
        showSelectedLabels: true,
        selectedLabelStyle: const TextStyle(fontWeight: FontWeight.w600),
        unselectedLabelStyle: const TextStyle(fontWeight: FontWeight.w400),
        elevation: 8,
        onTap: (index) {
          setState(() {
            currentIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_rounded),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.pie_chart_outline_rounded),
            label: "Portfolio",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.task_alt_outlined),
            label: "Projects",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.bar_chart_rounded),
            label: "Analytics",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline_rounded),
            label: "Profile",
          ),
        ],
      ),
    );
  }
}
