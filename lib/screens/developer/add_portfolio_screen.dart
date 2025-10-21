import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart'; // Tambahkan package ini untuk animasi staggered
import 'package:rumaia_project/utils/developer/app_color.dart';

class AddPortfolioScreen extends StatefulWidget {
  const AddPortfolioScreen({super.key});

  @override
  State<AddPortfolioScreen> createState() => _AddPortfolioScreenState();
}

class _AddPortfolioScreenState extends State<AddPortfolioScreen>
    with TickerProviderStateMixin {
  // === Controller ===
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _investmentController = TextEditingController();
  final TextEditingController _revenueController = TextEditingController();
  String _selectedType = "Apartment";

  // === Animation Controllers ===
  late AnimationController _fadeController;
  late Animation<double> _fadeAnimation;

  // === List Type of Property ===
  final List<String> _propertyTypes = [
    "Apartment",
    "Villa",
    "Condo",
    "Office",
    "House",
  ];

  @override
  void initState() {
    super.initState();
    _fadeController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _fadeController, curve: Curves.easeInOut),
    );
    _fadeController.forward();
  }

  @override
  void dispose() {
    _fadeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isSmallScreen = screenWidth < 600;

    return Scaffold(
      backgroundColor: AppColor.backgroundColor,

      // ============================================================
      // AppBar — modern top header with gradient and subtle shadow
      // ============================================================
      appBar: AppBar(
        title: Text(
          "Add Portfolio",
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
      ),

      // === BODY: Berisi Form Input dengan animasi ===
      body: FadeTransition(
        opacity: _fadeAnimation,
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(
            horizontal: isSmallScreen ? 20 : 32,
            vertical: 24,
          ),
          child: AnimationLimiter(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: AnimationConfiguration.toStaggeredList(
                duration: const Duration(milliseconds: 600),
                childAnimationBuilder: (widget) => SlideAnimation(
                  verticalOffset: 50.0,
                  child: FadeInAnimation(child: widget),
                ),
                children: [
                  // === Header Section ===
                  Text(
                    "Add New Property",
                    style: TextStyle(
                      fontSize: isSmallScreen ? 24 : 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                      letterSpacing: 0.5,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    "Fill out the details below to add a new property.",
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey[600],
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  SizedBox(height: 32),

                  // === Property Name Input ===
                  _buildTextField(
                    controller: _nameController,
                    label: "Property Name",
                    hint: "e.g. Greenwood Residence, Tower A",
                    icon: Icons.business_rounded,
                    isSmallScreen: isSmallScreen,
                  ),
                  SizedBox(height: 20),

                  // === Address Input ===
                  _buildTextField(
                    controller: _addressController,
                    label: "Address",
                    hint: "e.g Jl. M.H Thamrin, Jakarta",
                    icon: Icons.location_on_rounded,
                    isSmallScreen: isSmallScreen,
                  ),
                  SizedBox(height: 20),

                  // === Property Type Dropdown ===
                  _buildDropdownField(
                    label: "Property Type",
                    value: _selectedType,
                    items: _propertyTypes,
                    onChanged: (value) {
                      setState(() {
                        _selectedType = value!;
                      });
                    },
                    isSmallScreen: isSmallScreen,
                  ),
                  SizedBox(height: 20),

                  // === Total Investment Input ===
                  _buildTextField(
                    controller: _investmentController,
                    label: "Total Investment",
                    hint: "e.g. Rp500.000.000",
                    icon: Icons.attach_money_rounded,
                    keyboardType: TextInputType.number,
                    isSmallScreen: isSmallScreen,
                  ),
                  SizedBox(height: 20),

                  // === Monthly Revenue Input ===
                  _buildTextField(
                    controller: _revenueController,
                    label: "Monthly Revenue",
                    hint: "e.g. Rp5.200.000",
                    icon: Icons.trending_up_rounded,
                    keyboardType: TextInputType.number,
                    isSmallScreen: isSmallScreen,
                  ),
                  SizedBox(height: 32),

                  // === Upload Photo Button (Modern Placeholder) ===
                  Container(
                    width: double.infinity,
                    height: isSmallScreen ? 140 : 160,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: Colors.grey.shade200),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.05),
                          blurRadius: 12,
                          offset: const Offset(0, 6),
                        ),
                      ],
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: AppColor.primaryColor.withOpacity(0.1),
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            Icons.add_a_photo_rounded,
                            size: 32,
                            color: AppColor.primaryColor,
                          ),
                        ),
                        SizedBox(height: 12),
                        Text(
                          "Upload Property Photo",
                          style: TextStyle(
                            color: AppColor.primaryColor,
                            fontWeight: FontWeight.w600,
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 32),

                  // === Save Button ===
                  _buildPrimaryButton(
                    title: "Save Property",
                    icon: Icons.save_rounded,
                    onTap: () {
                      // TODO: Action while saved
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text("Property saved successfully!"),
                          backgroundColor: AppColor.primaryColor,
                          behavior: SnackBarBehavior.floating,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                      );
                    },
                    isSmallScreen: isSmallScreen,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// ===============================================================
// () Reusable Widgets
// ===============================================================

/// === Text Field Builder ===
Widget _buildTextField({
  required TextEditingController controller,
  required String label,
  required String hint,
  required IconData icon,
  TextInputType keyboardType = TextInputType.text,
  required bool isSmallScreen,
}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        label,
        style: TextStyle(
          fontWeight: FontWeight.w600,
          color: Colors.black87,
          fontSize: 14,
        ),
      ),
      const SizedBox(height: 8),
      Container(
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
        child: TextField(
          controller: controller,
          keyboardType: keyboardType,
          decoration: InputDecoration(
            prefixIcon: Icon(icon, color: AppColor.primaryColor),
            hintText: hint,
            hintStyle: TextStyle(color: Colors.grey[500]),
            filled: true,
            fillColor: Colors.white,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: BorderSide.none,
            ),
            contentPadding: const EdgeInsets.symmetric(
              vertical: 16,
              horizontal: 20,
            ),
          ),
        ),
      ),
    ],
  );
}

/// === Dropdown Builder ===
Widget _buildDropdownField({
  required String label,
  required String value,
  required List<String> items,
  required void Function(String?) onChanged,
  required bool isSmallScreen,
}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        label,
        style: TextStyle(
          fontWeight: FontWeight.w600,
          color: Colors.black87,
          fontSize: 14,
        ),
      ),
      const SizedBox(height: 8),
      Container(
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
        child: DropdownButtonFormField<String>(
          value: value,
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: BorderSide.none,
            ),
            contentPadding: const EdgeInsets.symmetric(
              vertical: 16,
              horizontal: 20,
            ),
          ),
          items: items
              .map((e) => DropdownMenuItem<String>(value: e, child: Text(e)))
              .toList(),
          onChanged: onChanged,
        ),
      ),
    ],
  );
}

/// === Primary Button Builder ===
Widget _buildPrimaryButton({
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
      icon: Icon(icon, color: Colors.white),
      label: Text(
        title,
        style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w600,
          fontSize: isSmallScreen ? 16 : 18,
        ),
      ),
      style: TextButton.styleFrom(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      ),
    ),
  );
}
