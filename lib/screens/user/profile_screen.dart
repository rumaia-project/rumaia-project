// [file name]: profile_screen.dart
// [file content begin]
import 'package:flutter/material.dart';
import 'package:rumaia_project/screens/property/profile/help_center_screen.dart';
import 'package:rumaia_project/screens/user/wallet_screen.dart';

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

            // Wallet Section - NEW: Added Wallet Card
            _buildWalletCard(context),

            SizedBox(height: 16),

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
                    icon: Icons.account_balance_wallet_outlined,
                    title: 'Dompet Blockchain',
                    subtitle: 'Kelola aset crypto Anda',
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => WalletScreen()),
                      );
                    },
                    hasSwitch: false,
                    isSwitched: false,
                  ),
                  _buildMenuItem(
                    icon: Icons.edit_outlined,
                    title: 'Edit Profil',
                    subtitle: 'Ubah informasi pribadi',
                    onTap: () {},
                    hasSwitch: false,
                    isSwitched: false,
                  ),
                  _buildMenuItem(
                    icon: Icons.people_outline,
                    title: 'Manajemen Keluarga',
                    subtitle: 'Kelola anggota keluarga',
                    onTap: () {},
                    hasSwitch: false,
                    isSwitched: false,
                  ),
                  _buildMenuItem(
                    icon: Icons.notifications_outlined,
                    title: 'Notifikasi',
                    subtitle: 'Pengaturan pemberitahuan',
                    onTap: () {},
                    hasSwitch: false,
                    isSwitched: false,
                  ),
                  _buildMenuItem(
                    icon: Icons.security_outlined,
                    title: 'Privasi & Keamanan',
                    subtitle: 'Kelola data dan keamanan',
                    onTap: () {},
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
                    onTap: () {},
                    hasSwitch: false,
                    isSwitched: false,
                  ),
                  _buildMenuItem(
                    icon: Icons.help_outline,
                    title: 'Pusat Bantuan',
                    subtitle: '',
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => HelpCenterScreen(),
                        ),
                      );
                    },
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

  // NEW: Wallet Card Widget
  Widget _buildWalletCard(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => WalletScreen()),
        );
      },
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.all(20),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Color(0xFF1565C0), Color(0xFF42A5F5)],
          ),
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.blue.withOpacity(0.3),
              blurRadius: 10,
              offset: Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Dompet Anda',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    'IDRT',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 16),
            Text(
              'Total Saldo',
              style: TextStyle(
                color: Colors.white.withOpacity(0.8),
                fontSize: 14,
              ),
            ),
            SizedBox(height: 4),
            Text(
              'Rp 5.000.000.000',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8),
            Text(
              '5.000.000 IDRT',
              style: TextStyle(
                color: Colors.white.withOpacity(0.8),
                fontSize: 14,
              ),
            ),
            SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 8),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Center(
                      child: Text(
                        'Deposit',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                          fontSize: 12,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 8),
                Expanded(
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 8),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Center(
                      child: Text(
                        'Withdraw',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                          fontSize: 12,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 8),
                Expanded(
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 8),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Center(
                      child: Text(
                        'Transfer',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                          fontSize: 12,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
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
    required VoidCallback onTap,
    required bool hasSwitch,
    required bool isSwitched,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
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
                activeThumbColor: Color(0xFF1565C0),
              )
            else
              Icon(Icons.arrow_forward_ios, color: Colors.grey[400], size: 16),
          ],
        ),
      ),
    );
  }
}
// [file content end]