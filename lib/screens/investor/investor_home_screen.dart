import 'package:flutter/material.dart';
import 'package:rumaia_project/main.dart';
import 'package:rumaia_project/utils/investor/investor_color.dart';

class InvestorHomeScreen extends StatefulWidget {
  const InvestorHomeScreen({super.key});

  @override
  State<InvestorHomeScreen> createState() => _InvestorHomeScreenState();
}

class _InvestorHomeScreenState extends State<InvestorHomeScreen> {
  String selectedPeriod = "Monthly";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: InvestorColor.backgroundColor,

      // ======== APP BAR SECTION ========
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          "Home",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.w700),
        ),
        centerTitle: true,
        actions: [
          // Logout Button
          IconButton(
            onPressed: () => AuthHelper.showLogoutDialog(context),
            icon: const Icon(
              Icons.logout_rounded,
              color: Colors.grey,
              size: 22,
            ),
            tooltip: 'Keluar Akun',
          ),
        ],
      ),

      // ======== MAIN BODY ========
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ===== GREETING SECTION =====
            const Text(
              "Hello, Robert!",
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w700,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 4),
            const Text(
              "Welcome Back!",
              style: TextStyle(fontSize: 14, color: Colors.grey),
            ),
            const SizedBox(height: 16),

            // ===== INVESTMENT SUMMARY SECTION =====
            Row(
              children: [
                Expanded(
                  child: _buildSummaryCard(
                    title: "Total Investments",
                    value: "\$2.5M",
                    change: "+2% today",
                    icon: Icons.stacked_bar_chart_rounded,
                    color: InvestorColor.primaryColor,
                    changeColor: Colors.green,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _buildSummaryCard(
                    title: "ROI",
                    value: "15%",
                    change: "-0.5% this mo",
                    icon: Icons.show_chart_rounded,
                    color: InvestorColor.accentColor,
                    changeColor: Colors.red,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 16),

            // ===== QUICK ACTIONS SECTION =====
            const Text(
              "Quick Actions",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w700,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 12),

            GridView.count(
              crossAxisCount: 2,
              shrinkWrap: true,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
              physics: const NeverScrollableScrollPhysics(),
              children: [
                _buildActionButton(
                  icon: Icons.account_balance_wallet_outlined,
                  label: "Deposit Funds",
                  color: InvestorColor.primaryColor,
                ),
                _buildActionButton(
                  icon: Icons.arrow_circle_up_outlined,
                  label: "Withdraw Funds",
                  color: InvestorColor.primaryColor,
                ),
                _buildActionButton(
                  icon: Icons.headset_mic_outlined,
                  label: "Support",
                  color: InvestorColor.primaryColor,
                ),
                _buildActionButton(
                  icon: Icons.person_add_alt_1_outlined,
                  label: "Refer a Friend",
                  color: InvestorColor.primaryColor,
                ),
              ],
            ),

            const SizedBox(height: 20),

            // ===== INVESTMENT CATEGORIES SECTION =====
            const Text(
              "Investment Categories",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w700,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 12),

            _buildCategoryCard(
              title: "Residential Properties",
              description: "Invest in residential real estate projects",
            ),
            const SizedBox(height: 12),
            _buildCategoryCard(
              title: "Commercial Ventures",
              description: "Explore commercial & industrial projects",
            ),

            const SizedBox(height: 30),

            // ===== DASHBOARD TAB (Monthly, Quarterly, Yearly) =====
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: ["Monthly", "Quarterly", "Yearly"]
                  .map(
                    (period) => Expanded(
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            selectedPeriod = period;
                          });
                        },
                        child: Container(
                          margin: const EdgeInsets.symmetric(horizontal: 4),
                          padding: const EdgeInsets.symmetric(
                            vertical: 10,
                            horizontal: 8,
                          ),
                          decoration: BoxDecoration(
                            color: selectedPeriod == period
                                ? InvestorColor.primaryColor
                                : Colors.white,
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(
                              color: InvestorColor.primaryColor,
                              width: 1,
                            ),
                          ),
                          child: Center(
                            child: Text(
                              period,
                              style: TextStyle(
                                color: selectedPeriod == period
                                    ? Colors.white
                                    : InvestorColor.primaryColor,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  )
                  .toList(),
            ),

            const SizedBox(height: 20),

            // ===== DASHBOARD METRICS SECTION =====
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildMetricCard(
                  "\$24,580",
                  "Total Profit",
                  Icons.trending_up_rounded,
                ),
                _buildMetricCard("8.4%", "Avg Yield", Icons.bar_chart_rounded),
                _buildMetricCard("12", "Active", Icons.check_circle_outline),
              ],
            ),

            const SizedBox(height: 24),

            // ===== OVERALL GROWTH CHART PLACEHOLDER =====
            _buildChartPlaceholder("Overall Growth"),

            const SizedBox(height: 16),

            // ===== ROI HISTORY CHART PLACEHOLDER =====
            _buildChartPlaceholder("ROI History"),

            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }

  // ==============================================================
  // =============== REUSABLE COMPONENTS SECTION ==================
  // ==============================================================

  /// Summary Card (Total Investments, ROI)
  Widget _buildSummaryCard({
    required String title,
    required String value,
    required String change,
    required IconData icon,
    required Color color,
    required Color changeColor,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: color, size: 22),
              const Spacer(),
              Text(
                "View More",
                style: TextStyle(color: Colors.grey[500], fontSize: 12),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            value,
            style: const TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: Color(0xFF1A6AC5),
            ),
          ),
          const SizedBox(height: 4),
          Row(
            children: [
              Text(
                change,
                style: TextStyle(
                  fontSize: 12,
                  color: changeColor,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  /// Quick Action Button (Deposit, Withdraw, etc.)
  Widget _buildActionButton({
    required IconData icon,
    required String label,
    required Color color,
  }) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.white,
        elevation: 1,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(14),
          side: BorderSide(color: color.withOpacity(0.2)),
        ),
        padding: const EdgeInsets.symmetric(vertical: 14),
      ),
      onPressed: () {},
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: color, size: 26),
          const SizedBox(height: 8),
          Text(
            label,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: InvestorColor.textColor,
              fontWeight: FontWeight.w600,
              fontSize: 13,
            ),
          ),
        ],
      ),
    );
  }

  /// Category Card (Residential / Commercial)
  Widget _buildCategoryCard({
    required String title,
    required String description,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
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
      child: Row(
        children: [
          Icon(Icons.domain_rounded, color: const Color(0xFF1A6AC5), size: 28),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 15,
                    color: Colors.black,
                  ),
                ),
                Text(
                  description,
                  style: const TextStyle(color: Colors.grey, fontSize: 12),
                ),
              ],
            ),
          ),
          const Icon(
            Icons.arrow_forward_ios_rounded,
            color: Colors.grey,
            size: 16,
          ),
        ],
      ),
    );
  }

  /// Metric Card (Dashboard Small Cards)
  Widget _buildMetricCard(String value, String label, IconData icon) {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 4),
        padding: const EdgeInsets.all(14),
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
        child: Column(
          children: [
            Icon(icon, color: const Color(0xFF1A6AC5)),
            const SizedBox(height: 8),
            Text(
              value,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                color: Color(0xFF1A6AC5),
              ),
            ),
            const SizedBox(height: 2),
            Text(
              label,
              style: const TextStyle(color: Colors.grey, fontSize: 12),
            ),
          ],
        ),
      ),
    );
  }

  /// Placeholder for Chart Widgets (Overall Growth & ROI History)
  Widget _buildChartPlaceholder(String title) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 16,
              color: Colors.black,
            ),
          ),
          const SizedBox(height: 60),
          const Center(
            child: Text(
              "Chart placeholder",
              style: TextStyle(color: Colors.grey),
            ),
          ),
        ],
      ),
    );
  }
}
