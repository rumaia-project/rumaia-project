import 'package:flutter/material.dart';
import 'package:rumaia_project/utils/developer/app_color.dart';

class AddPortfolioScreen extends StatefulWidget {
  const AddPortfolioScreen({super.key});

  @override
  State<AddPortfolioScreen> createState() => _AddPortfolioScreenState();
}

class _AddPortfolioScreenState extends State<AddPortfolioScreen> {
  // === Controller ===
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _investmentController = TextEditingController();
  final TextEditingController _revenueController = TextEditingController();
  String _selectedType = "Apartment";

  // === List Type of Property ===
  final List<String> _propertyTypes = [
    "Apartment",
    "Villa",
    "Condo",
    "Office",
    "House",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.backgroundColor,

      // ============================================================
      // AppBar — simple top header with title & notification icon
      // ============================================================
      appBar: AppBar(
        title: Text(
          "Add Portfolio",
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.white,
      ),

      // === BODY: Berisi Form Input ===
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // === Header Section ===
            Text(
              "Add New Property",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 4),
            Text(
              "Fill out the details below to add a new property.",
              style: TextStyle(color: Colors.grey),
            ),
            SizedBox(height: 24),

            // === Property Name Input ===
            _buildTextField(
              controller: _nameController,
              label: "Property Name",
              hint: "e.g. Greenwood Residence, Tower A",
              icon: Icons.business_rounded,
            ),
            SizedBox(height: 16),

            // === Address Input ===
            _buildTextField(
              controller: _addressController,
              label: "Address",
              hint: "e.g Jl. M.H Thamrin, Jakarta",
              icon: Icons.location_on_rounded,
            ),
            SizedBox(height: 16),

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
            ),
            SizedBox(height: 16),

            // === Total Investment Input ===
            _buildTextField(
              controller: _investmentController,
              label: "Total Investment",
              hint: "e.g. Rp500.000.000",
              icon: Icons.attach_money_rounded,
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 16),

            // === Monthlu Revenue Input
            _buildTextField(
              controller: _revenueController,
              label: "Monthly Revenue",
              hint: "e.g. Rp5.200.000",
              icon: Icons.trending_up_rounded,
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 24),

            // === Upload Photo Button (Dummy Placeholder)
            Container(
              width: double.infinity,
              height: 150,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.grey.shade300),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.add_a_photo_rounded,
                    size: 40,
                    color: AppColor.primaryColor,
                  ),
                  SizedBox(height: 8),
                  Text(
                    "Upload Property Photo",
                    style: TextStyle(
                      color: AppColor.primaryColor,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 24),

            // === Save Button ===
            _buildPrimaryButton(
              title: "Saved Property",
              icon: Icons.save_rounded,
              onTap: () {
                // TODO: Action while saved
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text("Property saved successfully!")),
                );
              },
            ),
          ],
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
}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        label,
        style: const TextStyle(
          fontWeight: FontWeight.w600,
          color: Colors.black87,
        ),
      ),
      const SizedBox(height: 6),
      TextField(
        controller: controller,
        keyboardType: keyboardType,
        decoration: InputDecoration(
          prefixIcon: Icon(icon, color: AppColor.primaryColor),
          hintText: hint,
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
          contentPadding: const EdgeInsets.symmetric(
            vertical: 14,
            horizontal: 16,
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
}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        label,
        style: const TextStyle(
          fontWeight: FontWeight.w600,
          color: Colors.black87,
        ),
      ),
      const SizedBox(height: 6),
      Container(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
        ),
        child: DropdownButtonFormField<String>(
          initialValue: value,
          decoration: const InputDecoration(border: InputBorder.none),
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
}) {
  return Container(
    width: double.infinity,
    decoration: BoxDecoration(
      color: AppColor.primaryColor,
      borderRadius: BorderRadius.circular(10),
    ),
    child: TextButton.icon(
      onPressed: onTap,
      icon: Icon(icon, color: Colors.white),
      label: Text(
        title,
        style: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w600,
        ),
      ),
    ),
  );
}
