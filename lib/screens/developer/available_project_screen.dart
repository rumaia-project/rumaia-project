// [file name]: available_project_screen.dart
// [file content begin]
import 'package:flutter/material.dart';
import 'package:rumaia_project/screens/developer/project_detail_screen.dart';
import 'package:rumaia_project/screens/developer/project_funding_screen.dart'; // NEW
import 'package:rumaia_project/utils/developer/app_color.dart';

class AvailableProjectsScreen extends StatelessWidget {
  const AvailableProjectsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> projects = [
      {
        'title': 'Rumaia Sky Tower',
        'location': 'Bandung, Indonesia',
        'category': 'High-rise Apartment',
        'totalFunding': 'Rp750M',
        'remaining': 'Rp120M left',
        'progress': 0.84,
        'tag': 'New',
        'description':
            'A luxurious high-rise apartment located in the heart of Bandung with modern facilities.',
        'fundingTarget': 750000000, // NEW: in IDR
        'fundingRaised': 630000000, // NEW: in IDR
        'developerCompany': 'Rumaia Developer Group',
        'estimatedROI': '18% per year',
        'duration': '24 months',
      },
      {
        'title': 'Serenity Park Villas',
        'location': 'Bogor, Indonesia',
        'category': 'Luxury Villa',
        'totalFunding': 'Rp560M',
        'remaining': 'Rp210M left',
        'progress': 0.62,
        'tag': 'Open',
        'description':
            'A peaceful villa area with a private lake and green surroundings for family living.',
        'fundingTarget': 560000000,
        'fundingRaised': 350000000,
        'developerCompany': 'Serenity Developers',
        'estimatedROI': '15% per year',
        'duration': '18 months',
      },
      {
        'title': 'Rumaia Lakeside Residences',
        'location': 'Yogyakarta, Indonesia',
        'category': 'Residential Complex',
        'totalFunding': 'Rp920M',
        'remaining': 'Rp80M left',
        'progress': 0.91,
        'tag': 'Closing Soon',
        'description':
            'A modern residential complex beside the lake with a sustainable living concept.',
        'fundingTarget': 920000000,
        'fundingRaised': 840000000,
        'developerCompany': 'Rumaia Developer Group',
        'estimatedROI': '20% per year',
        'duration': '30 months',
      },
    ];

    return Scaffold(
      backgroundColor: AppColor.backgroundColor,
      appBar: AppBar(
        title: const Text(
          "Available Projects",
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.white,
        actions: const [Icon(Icons.filter_list_rounded, color: Colors.black)],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Explore New Projects",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 4),
            const Text(
              "Find property projects to collaborate with and expand your portfolio.",
              style: TextStyle(color: Colors.grey),
            ),
            const SizedBox(height: 16),

            // Search bar
            TextField(
              decoration: InputDecoration(
                prefixIcon: const Icon(Icons.search),
                hintText: "Search available projects",
                fillColor: Colors.white,
                filled: true,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 0,
                ),
              ),
            ),
            const SizedBox(height: 20),

            // Project cards list
            for (var project in projects)
              _buildProjectCard(context, project: project),
          ],
        ),
      ),
    );
  }

  // ============================================================
  // Project Card Builder - UPDATED with Funding Button
  // ============================================================
  Widget _buildProjectCard(
    BuildContext context, {
    required Map<String, dynamic> project,
  }) {
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Image placeholder
              Container(
                height: 70,
                width: 70,
                decoration: BoxDecoration(
                  color: const Color(0xFFF2F2F2),
                  borderRadius: BorderRadius.circular(10),
                ),
                alignment: Alignment.center,
                child: const Text(
                  "Image",
                  style: TextStyle(fontSize: 10, color: Colors.grey),
                ),
              ),
              const SizedBox(width: 12),

              // Info section
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          project['category'],
                          style: const TextStyle(
                            color: AppColor.primaryColor,
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 2,
                          ),
                          decoration: BoxDecoration(
                            color: AppColor.primaryColor.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: Text(
                            project['tag'],
                            style: const TextStyle(
                              color: AppColor.primaryColor,
                              fontSize: 11,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),

                    Text(
                      project['title'],
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 4),

                    Text(
                      project['location'],
                      style: const TextStyle(fontSize: 12, color: Colors.grey),
                    ),
                    const SizedBox(height: 8),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _infoColumn("Total Funding", project['totalFunding']),
                        _infoColumn(
                          "Remaining",
                          project['remaining'],
                          isPrimary: true,
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),

                    ClipRRect(
                      borderRadius: BorderRadius.circular(6),
                      child: LinearProgressIndicator(
                        value: project['progress'],
                        color: AppColor.primaryColor,
                        backgroundColor: Colors.grey.shade200,
                        minHeight: 6,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),

          // NEW: Funding Action Buttons
          Row(
            children: [
              Expanded(
                child: TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => ProjectDetailScreen(project: project),
                      ),
                    );
                  },
                  style: TextButton.styleFrom(
                    foregroundColor: Colors.grey[700],
                    padding: const EdgeInsets.symmetric(vertical: 8),
                  ),
                  child: const Text(
                    "View Details",
                    style: TextStyle(fontWeight: FontWeight.w500),
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => ProjectFundingScreen(project: project),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColor.primaryColor,
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: const Text(
                    "Join Funding",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                      fontSize: 12,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // ============================================================
  // Helper for Info Columns
  // ============================================================
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
}
// [file content end]