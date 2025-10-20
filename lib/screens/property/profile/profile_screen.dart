import 'package:flutter/material.dart';

import 'about_screen.dart';
import 'edit_profile_screen.dart';
import 'help_center_screen.dart';
import 'settings_screen.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
          children: [
            // Header
            const Text(
              "Profil Saya",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
            ),
            const SizedBox(height: 24),

            // Avatar + Info
            Column(
              children: [
                const CircleAvatar(
                  radius: 48,
                  backgroundImage: AssetImage(
                    'assets/images/logo_rumaia_1.png',
                  ),
                ),
                const SizedBox(height: 14),
                const Text(
                  "John Wick",
                  style: TextStyle(fontWeight: FontWeight.w700, fontSize: 19),
                ),
                Text(
                  "johnwick@example.com",
                  style: TextStyle(color: Colors.grey[600], fontSize: 14),
                ),
              ],
            ),

            const SizedBox(height: 36),

            // Menu List
            _profileMenu(
              context,
              icon: Icons.edit,
              title: "Edit Profil",
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const EditProfileScreen()),
              ),
            ),
            _profileMenu(
              context,
              icon: Icons.settings,
              title: "Pengaturan",
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const SettingsScreen()),
              ),
            ),
            _profileMenu(
              context,
              icon: Icons.help_outline,
              title: "Pusat Bantuan",
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const HelpCenterScreen()),
              ),
            ),
            _profileMenu(
              context,
              icon: Icons.info_outline,
              title: "Tentang Aplikasi",
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const AboutScreen()),
              ),
            ),

            const SizedBox(height: 40),

            // Tombol Keluar
            InkWell(
              borderRadius: BorderRadius.circular(14),
              onTap: () {},
              child: Container(
                height: 52,
                decoration: BoxDecoration(
                  color: Colors.red[50],
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(color: Colors.red.shade200),
                ),
                alignment: Alignment.center,
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.logout, color: Colors.redAccent),
                    SizedBox(width: 8),
                    Text(
                      "Keluar",
                      style: TextStyle(
                        color: Colors.redAccent,
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _profileMenu(
    BuildContext context, {
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return InkWell(
      borderRadius: BorderRadius.circular(12),
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.grey.shade300),
        ),
        child: Row(
          children: [
            Icon(icon, color: Colors.black87),
            const SizedBox(width: 14),
            Expanded(
              child: Text(
                title,
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            Icon(
              Icons.arrow_forward_ios_rounded,
              size: 16,
              color: Colors.grey.shade400,
            ),
          ],
        ),
      ),
    );
  }
}
