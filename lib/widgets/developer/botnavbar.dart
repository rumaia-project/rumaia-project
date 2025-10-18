import 'package:flutter/material.dart';
import 'package:rumaia_project/screens/developer/home_screen.dart';
import 'package:rumaia_project/utils/developer/app_color.dart';

class BotnavbarScreen extends StatefulWidget {
  const BotnavbarScreen({super.key});

  @override
  State<BotnavbarScreen> createState() => _BotnavbarScreenState();
}

class _BotnavbarScreenState extends State<BotnavbarScreen> {
  int currentIndex = 0;

  static const List<Widget> widgetOptions = <Widget>[
    HomeScreen(),
    Center(child: Text("Halaman 2")),
    Center(child: Text("Halaman 3")),
    Center(child: Text("Halaman 4")),
    Center(child: Text("Halaman 5")),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.backgroundColor,
      body: widgetOptions[currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        selectedItemColor: AppColor.primaryColor,
        unselectedItemColor: Colors.grey,
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
            icon: Icon(Icons.work_outline_rounded),
            label: "Portfolio",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.task_alt_outlined),
            label: "Project",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.analytics_rounded),
            label: "Analitycs",
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
