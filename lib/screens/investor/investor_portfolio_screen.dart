import 'package:flutter/material.dart';
import 'package:rumaia_project/utils/investor/investor_color.dart';

class InvestorPortfolioScreen extends StatefulWidget {
  const InvestorPortfolioScreen({super.key});

  @override
  State<InvestorPortfolioScreen> createState() =>
      _InvestorPortfolioScreenState();
}

class _InvestorPortfolioScreenState extends State<InvestorPortfolioScreen> {
  // -------------------------
  //  Dummy Data Model
  // -------------------------
  final List<Map<String, dynamic>> investments = [
    {
      'title': 'Luxury Apartments Downtown',
      'location': 'New York City',
      'amount': '\$25,000',
      'roi': '12.5%',
      'progress': 0.68,
      'status': 'active',
    },
    {
      'title': 'Commercial Plaza West',
      'location': 'Los Angeles',
      'amount': '\$50,000',
      'roi': '15.2%',
      'progress': 0.42,
      'status': 'active',
    },
    {
      'title': 'Greenview Residences',
      'location': 'Miami, FL',
      'amount': '\$40,000',
      'roi': '14.8%',
      'progress': 1.0,
      'status': 'completed',
    },
  ];

  String selectedTab = "active";

  @override
  Widget build(BuildContext context) {
    final filteredInvestments = investments
        .where((inv) => inv['status'] == selectedTab)
        .toList();

    return Scaffold(
      backgroundColor: InvestorColor.backgroundColor,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          "My Investments",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.w700),
        ),
      ),

      // -------------------------
      //  Scrollable Content
      // -------------------------
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // -------------------------
            // 📈 Portfolio Summary Section (TOP)
            // -------------------------
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.1),
                    blurRadius: 6,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: Column(
                children: [
                  const Text(
                    "Total Portfolio Value",
                    style: TextStyle(
                      color: InvestorColor.textColor,
                      fontWeight: FontWeight.w600,
                      fontSize: 15,
                    ),
                  ),
                  const SizedBox(height: 4),
                  const Text(
                    "\$125,750",
                    style: TextStyle(
                      color: InvestorColor.primaryColor,
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 6),
                  const Text(
                    "+\$8,250 (+7.0%) this month",
                    style: TextStyle(color: Colors.green, fontSize: 13),
                  ),
                  const SizedBox(height: 16),

                  // Placeholder Donut Chart
                  Container(
                    height: 150,
                    width: 150,
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(100),
                    ),
                    alignment: Alignment.center,
                    child: const Text(
                      "Donut Chart",
                      style: TextStyle(color: Colors.black45),
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Breakdown Text
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Stocks (45%)",
                        style: TextStyle(color: InvestorColor.textColor),
                      ),
                      Text(
                        "Real Estate (30%)",
                        style: TextStyle(color: InvestorColor.textColor),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Bonds (15%)",
                        style: TextStyle(color: InvestorColor.textColor),
                      ),
                      Text(
                        "Cash (10%)",
                        style: TextStyle(color: InvestorColor.textColor),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),

                  // Profit + Active Projects
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [
                      Column(
                        children: [
                          Text(
                            "Total Profit",
                            style: TextStyle(color: InvestorColor.textColor),
                          ),
                          SizedBox(height: 4),
                          Text(
                            "+\$18,420",
                            style: TextStyle(
                              color: Colors.green,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          Text(
                            "Active Projects",
                            style: TextStyle(color: InvestorColor.textColor),
                          ),
                          SizedBox(height: 4),
                          Text(
                            "12",
                            style: TextStyle(
                              color: InvestorColor.primaryColor,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            // -------------------------
            //  Tab Controller Section
            // -------------------------
            Container(
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(12),
              ),
              padding: const EdgeInsets.all(4),
              child: Row(
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () => setState(() => selectedTab = "active"),
                      child: Container(
                        decoration: BoxDecoration(
                          color: selectedTab == "active"
                              ? InvestorColor.primaryColor
                              : Colors.transparent,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        alignment: Alignment.center,
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: Text(
                          "Active",
                          style: TextStyle(
                            color: selectedTab == "active"
                                ? Colors.white
                                : Colors.grey[700],
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: GestureDetector(
                      onTap: () => setState(() => selectedTab = "completed"),
                      child: Container(
                        decoration: BoxDecoration(
                          color: selectedTab == "completed"
                              ? InvestorColor.primaryColor
                              : Colors.transparent,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        alignment: Alignment.center,
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: Text(
                          "Completed",
                          style: TextStyle(
                            color: selectedTab == "completed"
                                ? Colors.white
                                : Colors.grey[700],
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),

            // -------------------------
            //  Investment List (Filtered)
            // -------------------------
            Column(
              children: filteredInvestments.map((investment) {
                return Container(
                  margin: const EdgeInsets.only(bottom: 16),
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.1),
                        blurRadius: 6,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Placeholder Image
                      Container(
                        height: 120,
                        decoration: BoxDecoration(
                          color: Colors.grey[300],
                          borderRadius: BorderRadius.circular(12),
                        ),
                        alignment: Alignment.center,
                        child: const Text(
                          "Project Image",
                          style: TextStyle(color: Colors.black45, fontSize: 14),
                        ),
                      ),
                      const SizedBox(height: 12),

                      Text(
                        investment['title'],
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: InvestorColor.textColor,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        investment['location'],
                        style: const TextStyle(
                          fontSize: 13,
                          color: InvestorColor.textColor,
                        ),
                      ),
                      const SizedBox(height: 10),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Invested Amount: ${investment['amount']}",
                            style: const TextStyle(
                              fontSize: 13,
                              color: InvestorColor.textColor,
                            ),
                          ),
                          Text(
                            "Expected ROI: ${investment['roi']}",
                            style: const TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w600,
                              color: Colors.green,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),

                      ClipRRect(
                        borderRadius: BorderRadius.circular(6),
                        child: LinearProgressIndicator(
                          value: investment['progress'],
                          backgroundColor: Colors.grey[300],
                          color: InvestorColor.primaryColor,
                          minHeight: 6,
                        ),
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }
}
