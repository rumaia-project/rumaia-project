import 'package:flutter/material.dart';
import 'package:rumaia_project/main.dart';
import 'package:rumaia_project/screens/admin/admin_dashboard.dart';
import 'package:rumaia_project/screens/property/dashboard_property.dart';
import 'package:rumaia_project/widgets/developer/botnavbar.dart';
import 'package:rumaia_project/widgets/investor/bot_nav_bar.dart';

class RoleSwitcherScreen extends StatefulWidget {
  const RoleSwitcherScreen({super.key});

  @override
  State<RoleSwitcherScreen> createState() => _RoleSwitcherScreenState();
}

class _RoleSwitcherScreenState extends State<RoleSwitcherScreen> {
  String? selectedRole;

  final Map<String, Map<String, dynamic>> roles = {
    'Admin': {
      'icon': Icons.admin_panel_settings_rounded,
      'widget': const AdminDashboardScreen(),
      'color': Colors.redAccent,
    },
    'Customer': {
      'icon': Icons.person_outline_rounded,
      'widget': const MainNavigation(),
      'color': Colors.teal,
    },
    'Developer': {
      'icon': Icons.developer_board,
      'widget': const BotnavbarScreen(),
      'color': Colors.purple,
    },
    'Property': {
      'icon': Icons.apartment_rounded,
      'widget': const DashboardProperty(),
      'color': Colors.indigo,
    },
    'Investor': {
      'icon': Icons.trending_up_rounded,
      'widget': const InvestorBotNavBarScreen(),
      'color': Colors.orange,
    },
  };

  void _navigateToRole(BuildContext context, Widget destination) {
    Navigator.of(context).push(
      PageRouteBuilder(
        transitionDuration: const Duration(milliseconds: 300),
        pageBuilder: (_, __, ___) => destination,
        transitionsBuilder: (_, animation, __, child) {
          return FadeTransition(
            opacity: CurvedAnimation(parent: animation, curve: Curves.easeOut),
            child: ScaleTransition(
              scale: Tween<double>(begin: 0.98, end: 1.0).animate(animation),
              child: child,
            ),
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme;

    return Scaffold(
      backgroundColor: color.surface,
      appBar: AppBar(
        title: const Text(
          'Guest Role',
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
        centerTitle: true,
        elevation: 0,
        backgroundColor: color.surface,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
        child: Column(
          children: [
            Icon(Icons.manage_accounts_rounded, size: 80, color: color.primary),
            const SizedBox(height: 16),
            Text(
              'Login as',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w700,
                color: color.onSurface,
              ),
            ),
            const SizedBox(height: 32),

            Expanded(
              child: ListView.separated(
                itemCount: roles.length,
                separatorBuilder: (_, __) => const SizedBox(height: 16),
                itemBuilder: (context, index) {
                  final name = roles.keys.elementAt(index);
                  final data = roles[name]!;
                  final isSelected = selectedRole == name;

                  return Material(
                    color: color.surfaceContainerHighest,
                    borderRadius: BorderRadius.circular(18),
                    elevation: isSelected ? 3 : 1,
                    clipBehavior: Clip.antiAlias,
                    child: InkWell(
                      onTap: () {
                        setState(() => selectedRole = name);
                        Future.delayed(const Duration(milliseconds: 150), () {
                          _navigateToRole(context, data['widget']);
                        });
                      },
                      splashColor: data['color'].withOpacity(0.1),
                      highlightColor: Colors.transparent,
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 250),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 22,
                        ),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: isSelected
                                ? data['color']
                                : color.outlineVariant.withOpacity(0.3),
                            width: isSelected ? 2 : 1,
                          ),
                          borderRadius: BorderRadius.circular(18),
                        ),
                        child: Row(
                          children: [
                            CircleAvatar(
                              radius: 26,
                              backgroundColor: data['color'].withOpacity(0.15),
                              child: Icon(
                                data['icon'],
                                color: data['color'],
                                size: 26,
                              ),
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: Text(
                                name,
                                style: TextStyle(
                                  fontSize: 17,
                                  fontWeight: FontWeight.w600,
                                  color: color.onSurface,
                                ),
                              ),
                            ),
                            AnimatedOpacity(
                              opacity: isSelected ? 1 : 0,
                              duration: const Duration(milliseconds: 250),
                              child: Icon(
                                Icons.arrow_forward_ios_rounded,
                                color: data['color'],
                                size: 18,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),

            const SizedBox(height: 20),
            Text(
              '© Rumaia Project',
              style: TextStyle(
                color: color.outline,
                fontSize: 13,
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
