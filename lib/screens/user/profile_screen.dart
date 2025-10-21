import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          'Profil',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.grey[800],
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.grey[700]),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            // Profile Header
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.1),
                    blurRadius: 10,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              child: Column(
                children: [
                  CircleAvatar(
                    radius: 40,
                    backgroundColor: Color(0xFF1565C0),
                    child: Text(
                      'BW',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  SizedBox(height: 16),
                  Text(
                    'Budi Wirawan',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey[800],
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    'budiwirawan@email.com',
                    style: TextStyle(color: Colors.grey[600]),
                  ),
                  SizedBox(height: 4),
                  Text(
                    '+62 812 3456 7890',
                    style: TextStyle(color: Colors.grey[600]),
                  ),
                  SizedBox(height: 20),

                  // Stats Row
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 16),
                    decoration: BoxDecoration(
                      border: Border(
                        top: BorderSide(color: Colors.grey[300]!),
                        bottom: BorderSide(color: Colors.grey[300]!),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        _buildStatItem('5', 'Pengajuan'),
                        _buildStatItem('3', 'Favorit'),
                        _buildStatItem('12', 'Dilihat'),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: 24),

            // Account Section
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.1),
                    blurRadius: 10,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.only(bottom: 12),
                    child: Text(
                      'Akun Saya',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey[800],
                      ),
                    ),
                  ),
                  _buildMenuItem(
                    icon: Icons.edit_outlined,
                    title: 'Edit Profil',
                    subtitle: 'Ubah informasi pribadi',
                    hasSwitch: false,
                    isSwitched: false,
                  ),
                  _buildMenuItem(
                    icon: Icons.people_outline,
                    title: 'Manajemen Keluarga',
                    subtitle: 'Kelola anggota keluarga',
                    hasSwitch: false,
                    isSwitched: false,
                  ),
                  _buildMenuItem(
                    icon: Icons.notifications_outlined,
                    title: 'Notifikasi',
                    subtitle: 'Pengaturan pemberitahuan',
                    hasSwitch: false,
                    isSwitched: false,
                  ),
                  _buildMenuItem(
                    icon: Icons.security_outlined,
                    title: 'Privasi & Keamanan',
                    subtitle: 'Kelola data dan keamanan',
                    hasSwitch: false,
                    isSwitched: false,
                  ),
                ],
              ),
            ),

            SizedBox(height: 16),

            // Support Section
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.1),
                    blurRadius: 10,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.only(bottom: 12),
                    child: Text(
                      'Dukungan',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey[800],
                      ),
                    ),
                  ),
                  _buildMenuItem(
                    icon: Icons.settings_outlined,
                    title: 'Pengaturan',
                    subtitle: '',
                    hasSwitch: false,
                    isSwitched: false,
                  ),
                  _buildMenuItem(
                    icon: Icons.help_outline,
                    title: 'Pusat Bantuan',
                    subtitle: '',
                    hasSwitch: false,
                    isSwitched: false,
                  ),
                ],
              ),
            ),

            SizedBox(height: 24),

            // App Version
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(16),
              child: Column(
                children: [
                  Text(
                    'Rumala v1.0.0',
                    style: TextStyle(color: Colors.grey[600], fontSize: 14),
                  ),
                  SizedBox(height: 4),
                  Text(
                    '© 2025 Rumala. All rights reserved.',
                    style: TextStyle(color: Colors.grey[500], fontSize: 12),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatItem(String value, String label) {
    return Column(
      children: [
        Text(
          value,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.grey[800],
          ),
        ),
        SizedBox(height: 4),
        Text(label, style: TextStyle(fontSize: 12, color: Colors.grey[600])),
      ],
    );
  }

  Widget _buildMenuItem({
    required IconData icon,
    required String title,
    required String subtitle,
    required bool hasSwitch,
    required bool isSwitched,
  }) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 12),
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(color: Colors.grey[100]!)),
      ),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: Colors.grey[50],
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: Colors.grey[600], size: 20),
          ),
          SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: Colors.grey[800],
                  ),
                ),
                if (subtitle.isNotEmpty)
                  Text(
                    subtitle,
                    style: TextStyle(fontSize: 12, color: Colors.grey[500]),
                  ),
              ],
            ),
          ),
          if (hasSwitch)
            Switch(
              value: isSwitched,
              onChanged: (value) {},
              activeColor: Color(0xFF1565C0),
            )
          else
            Icon(Icons.arrow_forward_ios, color: Colors.grey[400], size: 16),
        ],
      ),
    );
  }
}
