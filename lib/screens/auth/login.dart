import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:rumaia_project/main.dart';
import 'package:rumaia_project/screens/admin/admin_dashboard.dart';
import 'package:rumaia_project/screens/property/dashboard_property.dart';
import 'package:rumaia_project/widgets/developer/botnavbar.dart';
import 'package:rumaia_project/widgets/investor/bot_nav_bar.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatefulWidget {
  final String selectedRole;

  const LoginScreen({super.key, required this.selectedRole});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _obscurePassword = true;
  bool _isLoading = false;

  // Dummy credentials untuk setiap role
  final Map<String, Map<String, String>> _dummyCredentials = {
    'Admin': {'username': 'admin', 'password': 'admin123'},
    'Customer': {'username': 'customer', 'password': 'customer123'},
    'Developer': {'username': 'developer', 'password': 'developer123'},
    'Property': {'username': 'property', 'password': 'property123'},
    'Investor': {'username': 'investor', 'password': 'investor123'},
  };

  final Map<String, Map<String, dynamic>> _roleData = {
    'Admin': {
      'icon': Icons.admin_panel_settings_rounded,
      'color': const Color(0xFFFF6B6B),
      'gradient': const [Color(0xFFFF6B6B), Color(0xFFFF8E8E)],
    },
    'Customer': {
      'icon': Icons.person_outline_rounded,
      'color': const Color(0xFF4ECDC4),
      'gradient': const [Color(0xFF4ECDC4), Color(0xFF44A8A0)],
    },
    'Developer': {
      'icon': Icons.developer_board,
      'color': const Color(0xFF9B59B6),
      'gradient': const [Color(0xFF9B59B6), Color(0xFF8E44AD)],
    },
    'Property': {
      'icon': Icons.apartment_rounded,
      'color': const Color(0xFF5C6BC0),
      'gradient': const [Color(0xFF5C6BC0), Color(0xFF3F51B5)],
    },
    'Investor': {
      'icon': Icons.trending_up_rounded,
      'color': const Color(0xFFFF9800),
      'gradient': const [Color(0xFFFF9800), Color(0xFFF57C00)],
    },
  };

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _login() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);

    // Simulasi loading
    await Future.delayed(const Duration(seconds: 1));

    final username = _usernameController.text.trim();
    final password = _passwordController.text.trim();
    final correctCredentials = _dummyCredentials[widget.selectedRole]!;

    if (username == correctCredentials['username'] &&
        password == correctCredentials['password']) {
      // Login berhasil - simpan status login
      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool('isLoggedIn', true);
      await prefs.setString('userRole', widget.selectedRole);
      await prefs.setString('username', username);

      if (!mounted) return;

      // Navigate ke dashboard sesuai role
      _navigateToDashboard();
    } else {
      setState(() => _isLoading = false);

      if (!mounted) return;

      // Login gagal
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('Username atau password salah!'),
          backgroundColor: Colors.red,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      );
    }
  }

  void _navigateToDashboard() {
    // Import dashboard sesuai role dari file asli
    Widget destination;
    switch (widget.selectedRole) {
      case 'Admin':
        destination = const AdminDashboardScreen(); // Import dari file asli
        break;
      case 'Customer':
        destination = const MainNavigation(); // Import dari file asli
        break;
      case 'Developer':
        destination = const BotnavbarScreen(); // Import dari file asli
        break;
      case 'Property':
        destination = const DashboardProperty(); // Import dari file asli
        break;
      case 'Investor':
        destination = const InvestorBotNavBarScreen(); // Import dari file asli
        break;
      default:
        return;
    }

    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (_) => destination),
      (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final roleData = _roleData[widget.selectedRole]!;

    return Scaffold(
      body: Container(
        width: size.width,
        height: size.height,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: roleData['gradient'],
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                children: [
                  SizedBox(height: size.height * 0.05),

                  // Back Button
                  FadeInDown(
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: IconButton(
                        onPressed: () => Navigator.pop(context),
                        icon: const Icon(Icons.arrow_back_rounded),
                        color: Colors.white,
                        iconSize: 28,
                      ),
                    ),
                  ),

                  SizedBox(height: size.height * 0.02),

                  // Logo & Title
                  FadeInDown(
                    delay: const Duration(milliseconds: 200),
                    child: Column(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(20),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.2),
                                blurRadius: 30,
                                spreadRadius: 5,
                              ),
                            ],
                          ),
                          child: Icon(
                            roleData['icon'],
                            size: 56,
                            color: roleData['color'],
                          ),
                        ),
                        const SizedBox(height: 24),
                        Text(
                          'Login ${widget.selectedRole}',
                          style: const TextStyle(
                            fontSize: 32,
                            fontWeight: FontWeight.w900,
                            color: Colors.white,
                            letterSpacing: -0.5,
                          ),
                        ),
                        const SizedBox(height: 8),
                        const Text(
                          'Masuk untuk melanjutkan',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: Colors.white70,
                          ),
                        ),
                      ],
                    ),
                  ),

                  SizedBox(height: size.height * 0.05),

                  // Login Form Card
                  FadeInUp(
                    delay: const Duration(milliseconds: 400),
                    child: Container(
                      padding: const EdgeInsets.all(24),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(24),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            blurRadius: 30,
                            spreadRadius: 5,
                          ),
                        ],
                      ),
                      child: Form(
                        key: _formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Info Dummy Credentials
                            Container(
                              padding: const EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                color: roleData['color'].withOpacity(0.1),
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(
                                  color: roleData['color'].withOpacity(0.3),
                                ),
                              ),
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.info_outline_rounded,
                                    color: roleData['color'],
                                    size: 20,
                                  ),
                                  const SizedBox(width: 12),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Demo Account',
                                          style: TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w700,
                                            color: roleData['color'],
                                          ),
                                        ),
                                        const SizedBox(height: 2),
                                        Text(
                                          'User: ${_dummyCredentials[widget.selectedRole]!['username']}\nPass: ${_dummyCredentials[widget.selectedRole]!['password']}',
                                          style: TextStyle(
                                            fontSize: 11,
                                            fontWeight: FontWeight.w500,
                                            color: Colors.grey[700],
                                            height: 1.4,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),

                            const SizedBox(height: 24),

                            // Username Field
                            Text(
                              'Username',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: Colors.grey[800],
                              ),
                            ),
                            const SizedBox(height: 8),
                            TextFormField(
                              controller: _usernameController,
                              decoration: InputDecoration(
                                hintText: 'Masukkan username',
                                prefixIcon: Icon(
                                  Icons.person_outline_rounded,
                                  color: roleData['color'],
                                ),
                                filled: true,
                                fillColor: Colors.grey[100],
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                  borderSide: BorderSide.none,
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                  borderSide: BorderSide(
                                    color: Colors.grey[300]!,
                                    width: 1,
                                  ),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                  borderSide: BorderSide(
                                    color: roleData['color'],
                                    width: 2,
                                  ),
                                ),
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Username tidak boleh kosong';
                                }
                                return null;
                              },
                            ),

                            const SizedBox(height: 20),

                            // Password Field
                            Text(
                              'Password',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: Colors.grey[800],
                              ),
                            ),
                            const SizedBox(height: 8),
                            TextFormField(
                              controller: _passwordController,
                              obscureText: _obscurePassword,
                              decoration: InputDecoration(
                                hintText: 'Masukkan password',
                                prefixIcon: Icon(
                                  Icons.lock_outline_rounded,
                                  color: roleData['color'],
                                ),
                                suffixIcon: IconButton(
                                  onPressed: () {
                                    setState(() {
                                      _obscurePassword = !_obscurePassword;
                                    });
                                  },
                                  icon: Icon(
                                    _obscurePassword
                                        ? Icons.visibility_off_outlined
                                        : Icons.visibility_outlined,
                                    color: Colors.grey[600],
                                  ),
                                ),
                                filled: true,
                                fillColor: Colors.grey[100],
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                  borderSide: BorderSide.none,
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                  borderSide: BorderSide(
                                    color: Colors.grey[300]!,
                                    width: 1,
                                  ),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                  borderSide: BorderSide(
                                    color: roleData['color'],
                                    width: 2,
                                  ),
                                ),
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Password tidak boleh kosong';
                                }
                                return null;
                              },
                            ),

                            const SizedBox(height: 32),

                            // Login Button
                            SizedBox(
                              width: double.infinity,
                              height: 56,
                              child: ElevatedButton(
                                onPressed: _isLoading ? null : _login,
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: roleData['color'],
                                  foregroundColor: Colors.white,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(16),
                                  ),
                                  elevation: 8,
                                  shadowColor: roleData['color'].withOpacity(
                                    0.4,
                                  ),
                                ),
                                child: _isLoading
                                    ? const SizedBox(
                                        width: 24,
                                        height: 24,
                                        child: CircularProgressIndicator(
                                          strokeWidth: 2.5,
                                          valueColor:
                                              AlwaysStoppedAnimation<Color>(
                                                Colors.white,
                                              ),
                                        ),
                                      )
                                    : const Text(
                                        'Masuk',
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w700,
                                          letterSpacing: 0.5,
                                        ),
                                      ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 24),

                  // Footer
                  FadeInUp(
                    delay: const Duration(milliseconds: 600),
                    child: Text(
                      'Dengan masuk, Anda menyetujui\nSyarat & Ketentuan kami',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color: Colors.white.withOpacity(0.8),
                        height: 1.5,
                      ),
                    ),
                  ),

                  const SizedBox(height: 30),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
