import 'package:flutter/material.dart';
import 'package:rumaia_project/screens/investor/investor_home_screen.dart';
import 'package:rumaia_project/screens/investor/investor_opportunities_screen.dart';
import 'package:rumaia_project/screens/investor/investor_portfolio_screen.dart';
import 'package:rumaia_project/screens/investor/investor_profile_screen.dart';
import 'package:rumaia_project/screens/investor/investor_profit_screen.dart';
import 'package:rumaia_project/utils/investor/investor_color.dart';

class InvestorBotNavBarScreen extends StatefulWidget {
  const InvestorBotNavBarScreen({super.key});
  @override
  State<InvestorBotNavBarScreen> createState() =>
      _InvestorBotNavBarScreenState();
}

class _InvestorBotNavBarScreenState extends State<InvestorBotNavBarScreen> {
  int currentIndex = 0;

  final List<Widget> _pages = const [
    InvestorHomeScreen(),
    InvestorOpportunitiesScreen(),
    InvestorPortfolioScreen(),
    InvestorProfitScreen(),
    InvestorProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: InvestorColor.backgroundColor,

      // === BODY ===
      body: IndexedStack(index: currentIndex, children: _pages),

      // === BOTTOM NAVIGATION BAR ===
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.white,
        selectedItemColor: InvestorColor.primaryColor,
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
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_rounded),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.trending_up_rounded),
            label: "Invest",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.pie_chart_rounded),
            label: "Portfolio",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.payment_rounded),
            label: "Earnings",
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
