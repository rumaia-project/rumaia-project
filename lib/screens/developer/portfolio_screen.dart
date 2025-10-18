import 'package:flutter/material.dart';
import 'package:rumaia_project/models/developer/portfolio_property_model.dart';
import 'package:rumaia_project/screens/developer/add_portfolio_screen.dart';
import 'package:rumaia_project/screens/developer/property_detail_screen.dart';
import 'package:rumaia_project/utils/developer/app_color.dart';

// ===============================================================
// SCREEN: Portfolio Management
// ===============================================================
// Tampilan daftar portfolio milik developer.
// Berisi informasi investasi dan tombol menuju detail properti.
// ===============================================================

class PortfolioScreen extends StatelessWidget {
  const PortfolioScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // === Dummy Data List ===
    final List<PortfolioPropertyModel> portfolioList = [
      PortfolioPropertyModel(
        title: "Greenwood Residences, Tower A",
        address: "Jl. MH. Thamrin, Jakarta Pusat",
        totalInvestment: "Rp500M",
        monthlyRevenue: "Rp5.2M",
        maturity: 0.75,
        propertyType: "Apartment",
        image: "Image",
      ),
      PortfolioPropertyModel(
        title: "Rumaia Lakeview Villas",
        address: "Bali, Indonesia",
        totalInvestment: "Rp850M",
        monthlyRevenue: "Rp9.7M",
        maturity: 0.64,
        propertyType: "Villa",
        image: "Image",
      ),
      PortfolioPropertyModel(
        title: "Oceanfront Luxury Tower",
        address: "Surabaya, Indonesia",
        totalInvestment: "Rp1.2B",
        monthlyRevenue: "Rp12.4M",
        maturity: 0.82,
        propertyType: "Condo",
        image: "Image",
      ),
    ];

    return Scaffold(
      backgroundColor: AppColor.backgroundColor,

      // ============================================================
      // AppBar — simple top header with title & notification icon
      // ============================================================
      appBar: AppBar(
        title: const Text(
          "Portfolio",
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.white,
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.notifications_none_rounded),
            color: Colors.black,
          ),
        ],
      ),

      // ============================================================
      // Main Content — scrollable section containing all components
      // ============================================================
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ------------------------------------------------------------
            // Section: Header (introductory text about user's portfolio)
            // ------------------------------------------------------------
            const Text(
              "Your Portfolio",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 4),
            const Text(
              "You currently have 12 properties.",
              style: TextStyle(color: Colors.grey),
            ),
            const SizedBox(height: 16),

            // ------------------------------------------------------------
            // Section: Add Portfolio Button
            // ------------------------------------------------------------
            _buildPrimaryButton(
              context,
              title: "Add New Portfolio",
              icon: Icons.add_box_rounded,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const AddPortfolioScreen(),
                  ),
                );
              },
            ),
            const SizedBox(height: 20),

            // ------------------------------------------------------------
            // Section: Search Bar
            // ------------------------------------------------------------
            TextField(
              decoration: InputDecoration(
                prefixIcon: const Icon(Icons.search),
                suffixIcon: const Icon(Icons.filter_list_rounded),
                hintText: "Search portfolio items",
                fillColor: Colors.white,
                filled: true,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
                contentPadding: const EdgeInsets.symmetric(horizontal: 16),
              ),
            ),
            const SizedBox(height: 20),

            // ------------------------------------------------------------
            // Section: Portfolio Property Cards
            // ------------------------------------------------------------
            for (final property in portfolioList)
              _buildPropertyCard(context, property),
          ],
        ),
      ),
    );
  }
}

// ===============================================================
// () COMPONENTS
// ===============================================================

/// Build a single primary button
Widget _buildPrimaryButton(
  BuildContext context, {
  required String title,
  required IconData icon,
  required VoidCallback onTap,
}) {
  return Container(
    width: double.infinity,
    decoration: BoxDecoration(
      color: AppColor.primaryColor,
      borderRadius: BorderRadius.circular(10),
    ),
    child: TextButton.icon(
      onPressed: onTap,
      label: Text(
        title,
        style: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w600,
        ),
      ),
      icon: Icon(icon, color: Colors.white),
    ),
  );
}

/// ----------------------------------------------------------------
/// Property Card — reusable layout for each portfolio item
/// ----------------------------------------------------------------
Widget _buildPropertyCard(
  BuildContext context,
  PortfolioPropertyModel property,
) {
  return Container(
    margin: const EdgeInsets.only(bottom: 14),
    padding: const EdgeInsets.all(14),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: Colors.grey.shade200),
      boxShadow: [
        BoxShadow(
          color: Colors.black12.withOpacity(0.03),
          blurRadius: 4,
          offset: const Offset(0, 2),
        ),
      ],
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // ------------------------------------------------------------
        // Thumbnail — placeholder for property image
        // ------------------------------------------------------------
        Container(
          height: 70,
          width: 70,
          decoration: BoxDecoration(
            color: const Color(0xFFF2F2F2),
            borderRadius: BorderRadius.circular(10),
          ),
          alignment: Alignment.center,
          child: Text(
            property.image,
            style: const TextStyle(fontSize: 10, color: Colors.grey),
          ),
        ),
        const SizedBox(width: 12),

        // ------------------------------------------------------------
        // Property Info — property detail information
        // ------------------------------------------------------------
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                property.propertyType,
                style: TextStyle(
                  color: AppColor.primaryColor,
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                property.title,
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                property.address,
                style: const TextStyle(fontSize: 12, color: Colors.grey),
              ),
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _infoColumn("Total Investment", property.totalInvestment),
                  _infoColumn(
                    "Monthly Revenue",
                    property.monthlyRevenue,
                    isPrimary: true,
                  ),
                ],
              ),
              const SizedBox(height: 8),
              const Text(
                "Investment Maturity",
                style: TextStyle(fontSize: 12, color: Colors.grey),
              ),
              const SizedBox(height: 4),
              ClipRRect(
                borderRadius: BorderRadius.circular(6),
                child: LinearProgressIndicator(
                  value: property.maturity,
                  color: AppColor.primaryColor,
                  backgroundColor: Colors.grey.shade200,
                  minHeight: 6,
                ),
              ),
              const SizedBox(height: 10),

              // ------------------------------------------------------------
              // View Details Button — navigates to Property Detail screen
              // ------------------------------------------------------------
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            PropertyDetailScreen(property: property),
                      ),
                    );
                  },
                  style: TextButton.styleFrom(
                    foregroundColor: AppColor.primaryColor,
                    padding: EdgeInsets.zero,
                  ),
                  child: const Text(
                    "View Details",
                    style: TextStyle(fontWeight: FontWeight.w600),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

/// ----------------------------------------------------------------
/// Small helper: column for displaying investment info values
/// ----------------------------------------------------------------
Widget _infoColumn(String label, String value, {bool isPrimary = false}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(label, style: const TextStyle(fontSize: 11, color: Colors.grey)),
      const SizedBox(height: 2),
      Text(
        value,
        style: TextStyle(
          fontWeight: FontWeight.bold,
          color: isPrimary ? AppColor.primaryColor : AppColor.textColor,
        ),
      ),
    ],
  );
}
