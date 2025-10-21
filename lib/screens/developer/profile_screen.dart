import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:rumaia_project/screens/developer/wallet_manage_screen.dart';
import 'package:rumaia_project/utils/developer/app_color.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isSmallScreen = screenWidth < 600;

    return Scaffold(
      backgroundColor: AppColor.backgroundColor,
      appBar: AppBar(
        elevation: 2,
        shadowColor: Colors.black26,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        title: Text(
          'Profile',
          style: TextStyle(
            color: AppColor.primaryColor,
            fontWeight: FontWeight.w700,
            fontSize: 24,
            letterSpacing: 0.5,
          ),
        ),
        centerTitle: true,
        actions: [
          Container(
            margin: const EdgeInsets.only(right: 16),
            decoration: BoxDecoration(
              color: AppColor.primaryColor.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: IconButton(
              onPressed: () {},
              icon: const Icon(Icons.settings_outlined),
              color: AppColor.primaryColor,
            ),
          ),
        ],
      ),

      // === BODY ===
      body: FadeIn(
        duration: const Duration(milliseconds: 800),
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(
            horizontal: isSmallScreen ? 16 : 24,
            vertical: 20,
          ),
          child: Column(
            children: [
              // === PROFILE HEADER ===
              FadeInDown(
                duration: const Duration(milliseconds: 600),
                child: Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.05),
                        blurRadius: 12,
                        offset: const Offset(0, 6),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      // Avatar Circle
                      Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          gradient: LinearGradient(
                            colors: [
                              AppColor.primaryColor.withOpacity(0.2),
                              AppColor.primaryColor.withOpacity(0.1),
                            ],
                          ),
                        ),
                        child: const CircleAvatar(
                          radius: 50,
                          backgroundColor: Colors.transparent,
                          child: Text(
                            'Avatar',
                            style: TextStyle(color: Colors.grey, fontSize: 12),
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        'Christ Bow',
                        style: TextStyle(
                          fontSize: isSmallScreen ? 20 : 24,
                          fontWeight: FontWeight.w700,
                          color: Colors.black87,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Innovate Inc.',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey[600],
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      const SizedBox(height: 16),

                      // Edit Profile Button
                      Container(
                        width: double.infinity,
                        height: isSmallScreen ? 48 : 56,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              AppColor.primaryColor,
                              AppColor.primaryColor.withOpacity(0.8),
                            ],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                          borderRadius: BorderRadius.circular(16),
                          boxShadow: [
                            BoxShadow(
                              color: AppColor.primaryColor.withOpacity(0.3),
                              blurRadius: 12,
                              offset: const Offset(0, 6),
                            ),
                          ],
                        ),
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.transparent,
                            shadowColor: Colors.transparent,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                          ),
                          onPressed: () {},
                          child: Text(
                            'Edit Profile',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                              fontSize: isSmallScreen ? 16 : 18,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 24),

              // === STATS GRID ===
              FadeInUp(
                delay: const Duration(milliseconds: 200),
                duration: const Duration(milliseconds: 600),
                child: GridView.count(
                  crossAxisCount: 2,
                  shrinkWrap: true,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                  physics: const NeverScrollableScrollPhysics(),
                  children: [
                    _buildStatCard(
                      'Projects Completed',
                      '12',
                      Icons.task_alt,
                      isSmallScreen,
                    ),
                    _buildStatCard(
                      'Impact Score',
                      '9.29',
                      Icons.star_rate,
                      isSmallScreen,
                    ),
                    _buildStatCard(
                      'Active Investments',
                      '5',
                      Icons.account_balance,
                      isSmallScreen,
                    ),
                    _buildStatCard(
                      'Contributions',
                      '543',
                      Icons.handshake,
                      isSmallScreen,
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 24),

              // === ACCOUNT INFO SECTION ===
              FadeInUp(
                delay: const Duration(milliseconds: 400),
                duration: const Duration(milliseconds: 600),
                child: _buildListSection(
                  title: 'Account Information',
                  onTap: () {},
                  isSmallScreen: isSmallScreen,
                ),
              ),
              const SizedBox(height: 12),
              FadeInUp(
                delay: const Duration(milliseconds: 500),
                duration: const Duration(milliseconds: 600),
                child: _buildListSection(
                  title: 'Company Details',
                  onTap: () {},
                  isSmallScreen: isSmallScreen,
                ),
              ),
              const SizedBox(height: 12),
              FadeInUp(
                delay: const Duration(milliseconds: 600),
                duration: const Duration(milliseconds: 600),
                child: _buildListSection(
                  title: 'Wallet Management',
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const WalletManagementScreen(),
                      ),
                    );
                  },
                  isSmallScreen: isSmallScreen,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // === STAT CARD COMPONENT ===
  Widget _buildStatCard(
    String title,
    String value,
    IconData icon,
    bool isSmallScreen,
  ) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 12,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: AppColor.primaryColor.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: AppColor.primaryColor, size: 28),
          ),
          const SizedBox(height: 12),
          Text(
            value,
            style: TextStyle(
              fontSize: isSmallScreen ? 18 : 20,
              fontWeight: FontWeight.bold,
              color: AppColor.primaryColor,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 12,
              color: Colors.grey[600],
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  // === LIST SECTION COMPONENT ===
  Widget _buildListSection({
    required String title,
    required VoidCallback onTap,
    required bool isSmallScreen,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 12,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: ListTile(
        onTap: onTap,
        contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
        title: Text(
          title,
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: isSmallScreen ? 16 : 18,
            color: Colors.black87,
          ),
        ),
        trailing: Icon(
          Icons.arrow_forward_ios_rounded,
          size: 18,
          color: AppColor.primaryColor,
        ),
      ),
    );
  }
}
