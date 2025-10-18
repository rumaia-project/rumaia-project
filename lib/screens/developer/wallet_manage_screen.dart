import 'package:flutter/material.dart';
import 'package:rumaia_project/utils/developer/app_color.dart';

class WalletManagementScreen extends StatelessWidget {
  const WalletManagementScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.backgroundColor,

      // === APP BAR ===
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: const Icon(Icons.arrow_back_ios_new, color: Colors.grey),
        title: const Text(
          'Wallet Management',
          style: TextStyle(
            color: Color(0xFF1A6AC5),
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
      ),

      // === BODY ===
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Column(
          children: [
            // === ADD NEW WALLET BUTTON ===
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColor.primaryColor,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text(
                  'Add New Wallet',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 20),

            // === WALLET CARD LIST ===
            Column(
              children: [
                _buildWalletCard(
                  title: 'BNB Chain',
                  address: '0x71C7...AB03',
                  verified: true,
                  color: Colors.blue.shade50,
                ),
                const SizedBox(height: 12),
                _buildWalletCard(
                  title: 'IDRT Wallet',
                  address: '0x9522...cF41',
                  verified: false,
                  color: Colors.purple.shade50,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // === WALLET CARD COMPONENT ===
  Widget _buildWalletCard({
    required String title,
    required String address,
    required bool verified,
    required Color color,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      padding: const EdgeInsets.all(16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // === ICON / CIRCLE WALLET ===
          CircleAvatar(
            radius: 24,
            backgroundColor: color,
            child: const Icon(
              Icons.account_balance_wallet_outlined,
              color: Colors.grey,
            ),
          ),
          const SizedBox(width: 12),

          // === WALLET INFO ===
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Wallet title & verified badge
                Row(
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(width: 8),
                    if (verified)
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 3,
                        ),
                        decoration: BoxDecoration(
                          color: AppColor.accentColor,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: const Text(
                          'Verified',
                          style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.w600,
                            color: Colors.black,
                          ),
                        ),
                      ),
                  ],
                ),

                const SizedBox(height: 4),

                Text(
                  address,
                  style: const TextStyle(fontSize: 12, color: Colors.grey),
                ),
              ],
            ),
          ),

          // === ACTION BUTTONS (Remove + Icon) ===
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                icon: const Icon(Icons.delete_outline, color: Colors.redAccent),
                onPressed: () {},
              ),
              IconButton(
                icon: const Icon(Icons.more_vert, color: Colors.grey),
                onPressed: () {},
              ),
            ],
          ),
        ],
      ),
    );
  }
}
