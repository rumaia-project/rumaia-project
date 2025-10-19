import 'package:flutter/material.dart';
import 'package:rumaia_project/models/investor/investor_opportunities_model.dart';
import 'package:rumaia_project/screens/investor/investor_create_invest_screen.dart';
import 'package:rumaia_project/utils/investor/investor_color.dart';

class InvestorDetailScreen extends StatelessWidget {
  final InvestorOpportunitiesModel investment;

  const InvestorDetailScreen({super.key, required this.investment});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: InvestorColor.backgroundColor,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          "Detail Property",
          style: const TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        // iconTheme: const IconThemeData(color: primaryColor),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //  Placeholder for project image
            Container(
              height: 220,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Color(0xFFF2F2F2),
                borderRadius: BorderRadius.circular(16),
              ),
              child: const Center(
                child: Text(
                  "Image",
                  style: TextStyle(
                    color: Colors.grey,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),

            //  Title & Location
            Text(
              investment.title,
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: InvestorColor.textColor,
              ),
            ),
            const SizedBox(height: 4),
            Row(
              children: [
                const Icon(
                  Icons.location_on_outlined,
                  size: 16,
                  color: Colors.grey,
                ),
                const SizedBox(width: 4),
                Text(
                  investment.location,
                  style: TextStyle(color: Colors.grey[600], fontSize: 13),
                ),
              ],
            ),
            const SizedBox(height: 16),

            //  Investment Stats
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _infoBox("Min Investment", "\$${investment.minInvestment}"),
                _infoBox("Est. ROI", "${investment.roi}%"),
                _infoBox(
                  "Funded",
                  "${(investment.fundingProgress * 100).toStringAsFixed(0)}%",
                ),
              ],
            ),
            const SizedBox(height: 20),

            //  Description Section
            const Text(
              "Overview",
              style: TextStyle(
                color: InvestorColor.primaryColor,
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              investment.description,
              style: const TextStyle(
                fontSize: 14,
                color: InvestorColor.textColor,
                height: 1.5,
              ),
            ),
            const SizedBox(height: 24),

            //  Tabs Simulation Section (Overview / Documents / Updates)
            Container(
              padding: const EdgeInsets.symmetric(vertical: 12),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.1),
                    blurRadius: 6,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: const [
                  Text(
                    "Overview",
                    style: TextStyle(
                      color: InvestorColor.primaryColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    "Documents",
                    style: TextStyle(color: Colors.grey, fontSize: 13),
                  ),
                  Text(
                    "Updates",
                    style: TextStyle(color: Colors.grey, fontSize: 13),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            //  Invest Now Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: InvestorColor.primaryColor,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                onPressed: () {
                  //  Navigate to create investment form
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const InvestorCreateInvestScreen(),
                    ),
                  );
                },
                child: const Text(
                  "Invest Now",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  //  Custom Info Box Widget
  Widget _infoBox(String label, String value) {
    return Column(
      children: [
        Text(label, style: const TextStyle(color: Colors.grey, fontSize: 12)),
        const SizedBox(height: 4),
        Text(
          value,
          style: const TextStyle(
            color: InvestorColor.textColor,
            fontWeight: FontWeight.bold,
            fontSize: 14,
          ),
        ),
      ],
    );
  }
}
