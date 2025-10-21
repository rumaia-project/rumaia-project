import 'package:animate_do/animate_do.dart';
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
// Desain modern, aesthetic, responsive, dengan UI/UX yang nyaman dan menarik.
// ===============================================================

class PortfolioScreen extends StatefulWidget {
  const PortfolioScreen({super.key});

  @override
  State<PortfolioScreen> createState() => _PortfolioScreenState();
}

class _PortfolioScreenState extends State<PortfolioScreen> {
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isSmallScreen = screenWidth < 600;

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
      // AppBar — modern top header with gradient and subtle shadow
      // ============================================================
      appBar: AppBar(
        title: const Text(
          "Portfolio",
          style: TextStyle(
            fontWeight: FontWeight.w700,
            fontSize: 24,
            letterSpacing: 0.5,
          ),
        ),
        centerTitle: true,
        elevation: 2,
        shadowColor: Colors.black26,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        actions: [
          Container(
            margin: const EdgeInsets.only(right: 16),
            decoration: BoxDecoration(
              color: AppColor.primaryColor.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: IconButton(
              onPressed: () {},
              icon: const Icon(Icons.notifications_none_rounded),
              color: AppColor.primaryColor,
            ),
          ),
        ],
      ),

      // ============================================================
      // Main Content — scrollable section
      // ============================================================
      // [FIXED] Menghapus widget `FadeIn` yang membungkus `SingleChildScrollView`.
      // Ini menyelesaikan error layout 'hasSize' karena `SingleChildScrollView`
      // tidak boleh dibungkus oleh widget yang memerlukan ukuran pasti dari anaknya.
      // Animasi sudah ditangani oleh `FadeInUp` dan `FadeInDown` di dalam Column.
      // ============================================================
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(
          horizontal: isSmallScreen ? 16 : 24,
          vertical: 20,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ------------------------------------------------------------
            // Section: Header (introductory text with modern styling)
            // ------------------------------------------------------------
            FadeInDown(
              duration: const Duration(milliseconds: 600),
              child: Text(
                "Your Portfolio",
                style: TextStyle(
                  fontSize: isSmallScreen ? 24 : 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                  letterSpacing: 0.5,
                ),
              ),
            ),
            const SizedBox(height: 8),
            FadeInDown(
              delay: const Duration(milliseconds: 200),
              duration: const Duration(milliseconds: 600),
              child: Text(
                "You currently have 12 properties.",
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey[600],
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
            const SizedBox(height: 24),

            // ------------------------------------------------------------
            // Section: Add Portfolio Button (modern gradient button)
            // ------------------------------------------------------------
            FadeInUp(
              delay: const Duration(milliseconds: 400),
              duration: const Duration(milliseconds: 600),
              child: _buildPrimaryButton(
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
                isSmallScreen: isSmallScreen,
              ),
            ),
            const SizedBox(height: 24),

            // ------------------------------------------------------------
            // Section: Search Bar (stylish with shadow and rounded corners)
            // ------------------------------------------------------------
            FadeInUp(
              delay: const Duration(milliseconds: 600),
              duration: const Duration(milliseconds: 600),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: TextField(
                  decoration: InputDecoration(
                    prefixIcon: Icon(
                      Icons.search,
                      color: AppColor.primaryColor,
                    ),
                    suffixIcon: Icon(
                      Icons.filter_list_rounded,
                      color: AppColor.primaryColor,
                    ),
                    hintText: "Search portfolio items",
                    hintStyle: TextStyle(color: Colors.grey[500]),
                    fillColor: Colors.white,
                    filled: true,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                      borderSide: BorderSide.none,
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 16,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 24),

            // ------------------------------------------------------------
            // Section: Portfolio Property Cards (with staggered animation using animate_do)
            // ------------------------------------------------------------
            ...portfolioList.asMap().entries.map(
              (entry) => FadeInUp(
                delay: Duration(milliseconds: 800 + (entry.key * 200)),
                duration: const Duration(milliseconds: 600),
                child: _buildPropertyCard(context, entry.value, isSmallScreen),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ===============================================================
// () COMPONENTS
// ===============================================================

/// Build a modern primary button with gradient
Widget _buildPrimaryButton(
  BuildContext context, {
  required String title,
  required IconData icon,
  required VoidCallback onTap,
  required bool isSmallScreen,
}) {
  return Container(
    width: double.infinity,
    height: isSmallScreen ? 56 : 64,
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [AppColor.primaryColor, AppColor.primaryColor.withOpacity(0.8)],
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
    child: TextButton.icon(
      onPressed: onTap,
      label: Text(
        title,
        style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w600,
          fontSize: isSmallScreen ? 16 : 18,
        ),
      ),
      icon: Icon(icon, color: Colors.white),
      style: TextButton.styleFrom(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      ),
    ),
  );
}

/// ----------------------------------------------------------------
/// Property Card — modern reusable layout with enhanced aesthetics
/// ----------------------------------------------------------------
Widget _buildPropertyCard(
  BuildContext context,
  PortfolioPropertyModel property,
  bool isSmallScreen,
) {
  return Container(
    margin: const EdgeInsets.only(bottom: 16),
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(16),
      border: Border.all(color: Colors.grey.shade100),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.04),
          blurRadius: 12,
          offset: const Offset(0, 6),
        ),
      ],
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // ------------------------------------------------------------
        // Thumbnail — modern placeholder with subtle gradient
        // ------------------------------------------------------------
        Container(
          height: isSmallScreen ? 60 : 70,
          width: isSmallScreen ? 60 : 70,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.grey.shade100, Colors.grey.shade200],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(12),
          ),
          alignment: Alignment.center,
          child: Text(
            property.image,
            style: TextStyle(
              fontSize: 10,
              color: Colors.grey[600],
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        const SizedBox(width: 16),

        // ------------------------------------------------------------
        // Property Info — enhanced layout with better spacing
        // ------------------------------------------------------------
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: AppColor.primaryColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  property.propertyType,
                  style: TextStyle(
                    color: AppColor.primaryColor,
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              const SizedBox(height: 6),
              Text(
                property.title,
                style: TextStyle(
                  fontSize: isSmallScreen ? 14 : 16,
                  fontWeight: FontWeight.w700,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                property.address,
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey[600],
                  fontWeight: FontWeight.w400,
                ),
              ),
              const SizedBox(height: 12),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _infoColumn(
                    "Total Investment",
                    property.totalInvestment,
                    isSmallScreen,
                  ),
                  _infoColumn(
                    "Monthly Revenue",
                    property.monthlyRevenue,
                    isSmallScreen,
                    isPrimary: true,
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Text(
                "Investment Maturity",
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey[600],
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 6),
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: LinearProgressIndicator(
                  value: property.maturity,
                  color: AppColor.primaryColor,
                  backgroundColor: Colors.grey.shade200,
                  minHeight: 8,
                ),
              ),
              const SizedBox(height: 12),

              // ------------------------------------------------------------
              // View Details Button — modern styled button
              // ------------------------------------------------------------
              Align(
                alignment: Alignment.centerRight,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            PropertyDetailScreen(property: property),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColor.primaryColor.withOpacity(0.1),
                    foregroundColor: AppColor.primaryColor,
                    elevation: 0,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 8,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: Text(
                    "View Details",
                    style: TextStyle(fontWeight: FontWeight.w600, fontSize: 12),
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
Widget _infoColumn(
  String label,
  String value,
  bool isSmallScreen, {
  bool isPrimary = false,
}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        label,
        style: TextStyle(
          fontSize: 11,
          color: Colors.grey[600],
          fontWeight: FontWeight.w500,
        ),
      ),
      const SizedBox(height: 4),
      Text(
        value,
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: isSmallScreen ? 14 : 16,
          color: isPrimary ? AppColor.primaryColor : Colors.black87,
        ),
      ),
    ],
  );
}
