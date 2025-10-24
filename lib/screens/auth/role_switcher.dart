// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:rumaia_project/screens/auth/login.dart'; // Import LoginScreen

class RoleSwitcherScreen extends StatefulWidget {
  const RoleSwitcherScreen({super.key});

  @override
  State<RoleSwitcherScreen> createState() => _RoleSwitcherScreenState();
}

class _RoleSwitcherScreenState extends State<RoleSwitcherScreen>
    with SingleTickerProviderStateMixin {
  String? selectedRole;
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  final Map<String, Map<String, dynamic>> roles = {
    'Customer': {
      'icon': Icons.person_outline_rounded,
      'color': const Color(0xFF4ECDC4),
      'gradient': const [Color(0xFF4ECDC4), Color(0xFF44A8A0)],
      'description': 'Jelajahi properti impian',
    },
    'Developer': {
      'icon': Icons.developer_board,
      'color': const Color(0xFF9B59B6),
      'gradient': const [Color(0xFF9B59B6), Color(0xFF8E44AD)],
      'description': 'Bangun & kembangkan proyek\n(Verifikasi diperlukan)',
    },
    'Investor': {
      'icon': Icons.trending_up_rounded,
      'color': const Color(0xFFFF9800),
      'gradient': const [Color(0xFFFF9800), Color(0xFFF57C00)],
      'description': 'Monitor investasi properti',
    },
  };

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );
    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));
    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.1),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOutCubic));
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _navigateToLogin(BuildContext context, String role) {
    // Simpan role ke SharedPreferences dan navigasi ke LoginScreen
    Navigator.of(context).push(
      PageRouteBuilder(
        transitionDuration: const Duration(milliseconds: 400),
        pageBuilder: (_, __, ___) => LoginScreen(selectedRole: role),
        transitionsBuilder: (_, animation, __, child) {
          return FadeTransition(
            opacity: CurvedAnimation(
              parent: animation,
              curve: Curves.easeInOut,
            ),
            child: ScaleTransition(
              scale: Tween<double>(begin: 0.95, end: 1.0).animate(
                CurvedAnimation(parent: animation, curve: Curves.easeOutCubic),
              ),
              child: child,
            ),
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final color = Theme.of(context).colorScheme;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: color.surface,
      body: SafeArea(
        child: CustomScrollView(
          physics: const BouncingScrollPhysics(),
          slivers: [
            // Header Section dengan Gradient
            SliverToBoxAdapter(
              child: FadeTransition(
                opacity: _fadeAnimation,
                child: SlideTransition(
                  position: _slideAnimation,
                  child: Container(
                    padding: EdgeInsets.fromLTRB(
                      24,
                      size.height * 0.04,
                      24,
                      32,
                    ),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: isDark
                            ? [color.surface, color.surfaceContainerHighest]
                            : [Colors.white, color.surfaceContainerLowest],
                      ),
                    ),
                    child: Column(
                      children: [
                        // Logo Rumaia dengan bentuk avatar yang clean
                        Container(
                          width: 100,
                          height: 100,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                color: color.primary.withOpacity(0.2),
                                blurRadius: 20,
                                spreadRadius: 2,
                              ),
                              BoxShadow(
                                color: Colors.black.withOpacity(0.1),
                                blurRadius: 10,
                                offset: const Offset(0, 4),
                              ),
                            ],
                            // Hapus gradient background yang membuat bingkai tebal
                          ),
                          child: ClipOval(
                            child: Image.asset(
                              'assets/images/logo_rumaia_nofont.png',
                              width: 90,
                              height: 90,
                              fit: BoxFit
                                  .cover, // Ganti dari contain ke cover untuk fill penuh
                              errorBuilder: (context, error, stackTrace) {
                                // Fallback yang lebih clean
                                return Container(
                                  decoration: const BoxDecoration(
                                    gradient: LinearGradient(
                                      begin: Alignment.topLeft,
                                      end: Alignment.bottomRight,
                                      colors: [
                                        Color(0xFF2196F3),
                                        Color(0xFF00BCD4),
                                      ],
                                    ),
                                    shape: BoxShape.circle,
                                  ),
                                  child: const Icon(
                                    Icons.home_work_rounded,
                                    size: 50,
                                    color: Colors.white,
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                        const SizedBox(height: 24),
                        // Welcome Text
                        Text(
                          'Selamat Datang',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: color.onSurface.withOpacity(0.7),
                            letterSpacing: 0.5,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Pilih Peran Anda',
                          style: TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.w800,
                            color: color.onSurface,
                            letterSpacing: -0.5,
                          ),
                        ),
                        const SizedBox(height: 12),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 10,
                          ),
                          decoration: BoxDecoration(
                            color: color.primaryContainer.withOpacity(0.3),
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(
                              color: color.primary.withOpacity(0.1),
                              width: 1,
                            ),
                          ),
                          child: Text(
                            'Akses cepat ke semua fitur',
                            style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w500,
                              color: color.primary,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),

            // Role Cards
            SliverPadding(
              padding: const EdgeInsets.fromLTRB(20, 8, 20, 24),
              sliver: SliverList(
                delegate: SliverChildBuilderDelegate((context, index) {
                  final name = roles.keys.elementAt(index);
                  final data = roles[name]!;
                  final isSelected = selectedRole == name;

                  return FadeTransition(
                    opacity: _fadeAnimation,
                    child: SlideTransition(
                      position:
                          Tween<Offset>(
                            begin: Offset(0, 0.1 * (index + 1)),
                            end: Offset.zero,
                          ).animate(
                            CurvedAnimation(
                              parent: _controller,
                              curve: Interval(
                                index * 0.1,
                                0.6 + (index * 0.1),
                                curve: Curves.easeOutCubic,
                              ),
                            ),
                          ),
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 16),
                        child: _buildRoleCard(
                          context,
                          name,
                          data,
                          isSelected,
                          color,
                          isDark,
                        ),
                      ),
                    ),
                  );
                }, childCount: roles.length),
              ),
            ),

            // Footer
            SliverToBoxAdapter(
              child: FadeTransition(
                opacity: _fadeAnimation,
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 24),
                  child: Column(
                    children: [
                      Container(
                        margin: const EdgeInsets.symmetric(horizontal: 60),
                        height: 4,
                        decoration: BoxDecoration(
                          color: color.outlineVariant.withOpacity(0.3),
                          borderRadius: BorderRadius.circular(2),
                        ),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        '© Rumaia Project',
                        style: TextStyle(
                          color: color.outline.withOpacity(0.6),
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          letterSpacing: 0.5,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Property Management System',
                        style: TextStyle(
                          color: color.outline.withOpacity(0.4),
                          fontSize: 11,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRoleCard(
    BuildContext context,
    String name,
    Map<String, dynamic> data,
    bool isSelected,
    ColorScheme color,
    bool isDark,
  ) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: isSelected
                ? data['color'].withOpacity(0.25)
                : Colors.black.withOpacity(isDark ? 0.2 : 0.06),
            blurRadius: isSelected ? 20 : 10,
            offset: const Offset(0, 4),
            spreadRadius: isSelected ? 2 : 0,
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {
            setState(() => selectedRole = name);
            HapticFeedback.lightImpact();
            Future.delayed(const Duration(milliseconds: 200), () {
              _navigateToLogin(
                context,
                name,
              ); // Navigasi ke LoginScreen dengan role
            });
          },
          borderRadius: BorderRadius.circular(20),
          splashColor: data['color'].withOpacity(0.1),
          highlightColor: data['color'].withOpacity(0.05),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeOutCubic,
            decoration: BoxDecoration(
              gradient: isSelected
                  ? LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: data['gradient'],
                    )
                  : LinearGradient(
                      colors: [
                        color.surfaceContainerHighest,
                        color.surfaceContainerHigh,
                      ],
                    ),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color: isSelected
                    ? Colors.white.withOpacity(0.3)
                    : color.outlineVariant.withOpacity(0.2),
                width: isSelected ? 2 : 1,
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Row(
                children: [
                  // Icon Container
                  AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    padding: const EdgeInsets.all(14),
                    decoration: BoxDecoration(
                      color: isSelected
                          ? Colors.white.withOpacity(0.25)
                          : data['color'].withOpacity(0.12),
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: isSelected
                          ? [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.1),
                                blurRadius: 8,
                                offset: const Offset(0, 2),
                              ),
                            ]
                          : [],
                    ),
                    child: Icon(
                      data['icon'],
                      color: isSelected ? Colors.white : data['color'],
                      size: 28,
                    ),
                  ),
                  const SizedBox(width: 16),
                  // Text Content
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          name,
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                            color: isSelected ? Colors.white : color.onSurface,
                            letterSpacing: -0.3,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          data['description'],
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w500,
                            color: isSelected
                                ? Colors.white.withOpacity(0.85)
                                : color.onSurface.withOpacity(0.6),
                            letterSpacing: 0.1,
                          ),
                        ),
                      ],
                    ),
                  ),
                  // Arrow Icon
                  AnimatedRotation(
                    duration: const Duration(milliseconds: 300),
                    turns: isSelected ? 0 : -0.125,
                    child: AnimatedOpacity(
                      duration: const Duration(milliseconds: 300),
                      opacity: isSelected ? 1 : 0.3,
                      child: Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: isSelected
                              ? Colors.white.withOpacity(0.2)
                              : data['color'].withOpacity(0.1),
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          Icons.arrow_forward_rounded,
                          color: isSelected ? Colors.white : data['color'],
                          size: 20,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
