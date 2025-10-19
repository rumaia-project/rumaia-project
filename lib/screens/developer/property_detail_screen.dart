// lib/screens/developer/property_detail_screen.dart
import 'package:flutter/material.dart';
import 'package:rumaia_project/models/developer/portfolio_property_model.dart';
import 'package:rumaia_project/utils/developer/app_color.dart';

class PropertyDetailScreen extends StatelessWidget {
  final PortfolioPropertyModel property;

  const PropertyDetailScreen({super.key, required this.property});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(property.title),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
      ),
      backgroundColor: AppColor.backgroundColor,
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image placeholder
            Container(
              height: 180,
              width: double.infinity,
              decoration: BoxDecoration(
                color: const Color(0xFFF2F2F2),
                borderRadius: BorderRadius.circular(12),
              ),
              alignment: Alignment.center,
              child: const Text("Image", style: TextStyle(color: Colors.grey)),
            ),
            const SizedBox(height: 16),

            Text(
              property.propertyType,
              style: TextStyle(
                color: AppColor.primaryColor,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 8),

            Text(
              property.title,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),

            Text(property.address, style: const TextStyle(color: Colors.grey)),
            const SizedBox(height: 16),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _detailInfo("Total Investment", property.totalInvestment),
                _detailInfo(
                  "Monthly Revenue",
                  property.monthlyRevenue,
                  isPrimary: true,
                ),
              ],
            ),
            const SizedBox(height: 20),

            const Text(
              "Investment Maturity",
              style: TextStyle(fontSize: 13, color: Colors.grey),
            ),
            const SizedBox(height: 6),
            ClipRRect(
              borderRadius: BorderRadius.circular(6),
              child: LinearProgressIndicator(
                value: property.maturity,
                color: AppColor.primaryColor,
                backgroundColor: Colors.grey.shade300,
                minHeight: 8,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _detailInfo(String label, String value, {bool isPrimary = false}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(color: Colors.grey)),
        const SizedBox(height: 4),
        Text(
          value,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: isPrimary ? AppColor.primaryColor : Colors.black,
          ),
        ),
      ],
    );
  }
}
