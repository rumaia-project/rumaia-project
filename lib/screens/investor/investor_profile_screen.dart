import 'package:flutter/material.dart';
import 'package:rumaia_project/utils/investor/investor_color.dart';

class InvestorProfileScreen extends StatelessWidget {
  const InvestorProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: InvestorColor.backgroundColor,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          'Investor Profile',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w700,
            // fontSize: 18,
          ),
        ),
        centerTitle: true,
      ),

      // Use SingleChildScrollView to allow full page scroll (design is one long page)
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ===== Profile Header Card =====
            _buildProfileHeader(context),

            const SizedBox(height: 18),

            // ===== Summary Cards (Total Investments, ROI) =====
            Row(
              children: [
                Expanded(
                  child: _summaryCard(
                    title: 'Total Investments',
                    value: '\$2.5M',
                    subtitle: '+2.5% today',
                    valueColor: InvestorColor.primaryColor,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _summaryCard(
                    title: 'ROI',
                    value: '15%',
                    subtitle: '+0.85% this mo',
                    valueColor: Colors.green,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 20),

            // ===== Personal Information Section Title =====
            const Text(
              'Personal Information',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
            ),

            const SizedBox(height: 12),

            // ===== Personal Information Card =====
            _personalInfoCard(),

            const SizedBox(height: 20),

            // ===== Account Settings Title =====
            const Text(
              'Account Settings',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
            ),

            const SizedBox(height: 12),

            // ===== Account Settings Card =====
            _accountSettingsCard(context),

            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }

  // --------------------------
  // PROFILE HEADER
  // --------------------------
  Widget _buildProfileHeader(BuildContext context) {
    return Center(
      child: Container(
        width: double.infinity,
        // keep width constrained similar to design: centered card with padding
        constraints: const BoxConstraints(maxWidth: 520),
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 18),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.06),
              blurRadius: 10,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        child: Column(
          children: [
            // avatar
            Container(
              width: 86,
              height: 86,
              decoration: BoxDecoration(
                color: InvestorColor.primaryColor,
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.person, color: Colors.white, size: 44),
            ),
            const SizedBox(height: 12),

            // name
            const Text(
              'Robert Anderson',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w700,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 6),

            // email
            Text(
              'robert.anderson@email.com',
              style: TextStyle(
                fontSize: 13,
                color: InvestorColor.textColor.withOpacity(0.8),
              ),
            ),

            const SizedBox(height: 12),

            // Edit profile button (outlined with icon) — tappable but stateless for now
            OutlinedButton.icon(
              onPressed: () {
                // ready to be connected to navigation or edit sheet
              },
              style: OutlinedButton.styleFrom(
                backgroundColor: Colors.white,
                side: BorderSide(
                  color: InvestorColor.primaryColor.withOpacity(0.18),
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(22),
                ),
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 6,
                ),
                elevation: 2,
              ),
              icon: Icon(
                Icons.edit,
                color: InvestorColor.primaryColor,
                size: 18,
              ),
              label: Text(
                'Edit Profile',
                style: TextStyle(
                  color: InvestorColor.primaryColor,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // --------------------------
  // SUMMARY CARD (small) - re-usable
  // --------------------------
  Widget _summaryCard({
    required String title,
    required String value,
    required String subtitle,
    required Color valueColor,
  }) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // title and action
          Row(
            children: [
              Expanded(
                child: Text(
                  title,
                  style: TextStyle(
                    color: InvestorColor.textColor.withOpacity(0.8),
                    fontWeight: FontWeight.w600,
                    fontSize: 13,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Text(
                'Details',
                style: TextStyle(
                  color: InvestorColor.textColor.withOpacity(0.5),
                  fontSize: 12,
                ),
              ),
            ],
          ),

          const SizedBox(height: 12),
          Text(
            value,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w800,
              color: valueColor,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            subtitle,
            style: TextStyle(
              color: InvestorColor.textColor.withOpacity(0.6),
              fontSize: 12,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  // --------------------------
  // PERSONAL INFORMATION CARD
  // --------------------------
  Widget _personalInfoCard() {
    // small helper to build each row with icon + label + value
    Widget rowItem({
      required IconData icon,
      required String label,
      required String value,
    }) {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // circular icon
            Container(
              width: 34,
              height: 34,
              decoration: BoxDecoration(
                color: InvestorColor.primaryColor.withOpacity(0.08),
                shape: BoxShape.circle,
              ),
              child: Icon(icon, color: InvestorColor.primaryColor, size: 18),
            ),
            const SizedBox(width: 12),
            // label + value
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    label,
                    style: TextStyle(
                      color: InvestorColor.textColor.withOpacity(0.7),
                      fontSize: 12,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    value,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                      color: Colors.black87,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    }

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.035),
            blurRadius: 8,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        children: [
          rowItem(
            icon: Icons.person,
            label: 'Full Name',
            value: 'Robert Anderson',
          ),
          rowItem(
            icon: Icons.email_outlined,
            label: 'Email',
            value: 'robert.anderson@email.com',
          ),
          rowItem(
            icon: Icons.phone,
            label: 'Phone',
            value: '+62 812 3456 7890',
          ),
          rowItem(
            icon: Icons.location_on_outlined,
            label: 'Address',
            value: 'Jakarta, Indonesia',
          ),
        ],
      ),
    );
  }

  // --------------------------
  // ACCOUNT SETTINGS CARD
  // --------------------------
  Widget _accountSettingsCard(BuildContext context) {
    // ListTile builder so each row is tappable and ready for navigation
    Widget tile({
      required IconData icon,
      required String title,
      required VoidCallback onTap,
      Color? trailingColor,
      Widget? trailing,
    }) {
      return ListTile(
        onTap: onTap,
        leading: Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: InvestorColor.primaryColor.withOpacity(0.06),
            shape: BoxShape.circle,
          ),
          child: Icon(icon, color: InvestorColor.primaryColor),
        ),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.w600)),
        trailing:
            trailing ?? Icon(Icons.chevron_right, color: Colors.grey[400]),
      );
    }

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 6),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 6,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          tile(
            icon: Icons.lock_outline,
            title: 'Change Password',
            onTap: () {
              // navigate to change password page
            },
          ),
          const Divider(height: 1),
          tile(
            icon: Icons.security,
            title: 'Two-Factor Authentication',
            onTap: () {
              // toggle / navigate to 2FA settings
            },
          ),
          const Divider(height: 1),
          // logout row visually distinct (red text + icon). still tappable.
          ListTile(
            onTap: () {
              // handle logout
            },
            leading: Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: Colors.red.withOpacity(0.06),
                shape: BoxShape.circle,
              ),
              child: Icon(Icons.logout, color: Colors.red),
            ),
            title: Text(
              'Logout',
              style: TextStyle(
                fontWeight: FontWeight.w700,
                color: Colors.red.shade700,
              ),
            ),
            trailing: Icon(Icons.chevron_right, color: Colors.red.shade200),
          ),
        ],
      ),
    );
  }
}
