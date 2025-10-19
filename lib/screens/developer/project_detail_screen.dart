import 'package:flutter/material.dart';
import 'package:rumaia_project/utils/developer/app_color.dart';

class ProjectDetailScreen extends StatelessWidget {
  final Map<String, dynamic> project;

  const ProjectDetailScreen({super.key, required this.project});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.backgroundColor,
      appBar: AppBar(
        backgroundColor: AppColor.primaryColor,
        elevation: 0,
        title: Text(
          project['title'] ?? 'Project Detail',
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w600,
          ),
        ),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeaderImage(),
            const SizedBox(height: 20),
            _buildProjectInfo(),
            const SizedBox(height: 20),
            _buildProgressSection(),
            const SizedBox(height: 20),
            _buildDescriptionSection(),
            const SizedBox(height: 20),
            _buildDeveloperInfo(),
            const SizedBox(height: 30),
            _buildCommitButton(context),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  // ============================================================
  // Header Image (Placeholder)
  // ============================================================

  Widget _buildHeaderImage() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(16),
      child: Container(
        height: 200,
        width: double.infinity,
        color: AppColor.textColor.withOpacity(0.1),
        child: const Center(
          child: Text(
            'Image',
            style: TextStyle(
              color: AppColor.textColor,
              fontWeight: FontWeight.w500,
              fontSize: 16,
            ),
          ),
        ),
      ),
    );
  }

  // ============================================================
  // Project Info
  // ============================================================

  Widget _buildProjectInfo() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          project['title'] ?? 'Project Title',
          style: const TextStyle(
            color: AppColor.textColor,
            fontSize: 20,
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(height: 6),
        Row(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              decoration: BoxDecoration(
                color: AppColor.accentColor.withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                project['category'] ?? 'Residential',
                style: const TextStyle(
                  color: AppColor.accentColor,
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            const SizedBox(width: 8),
            Text(
              project['location'] ?? 'Jakarta, Indonesia',
              style: const TextStyle(color: AppColor.textColor, fontSize: 13),
            ),
          ],
        ),
      ],
    );
  }

  // ============================================================
  // Progress Section
  // ============================================================

  Widget _buildProgressSection() {
    double progress = project['progress'] ?? 0.65;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Project Progress',
          style: TextStyle(
            color: AppColor.textColor,
            fontWeight: FontWeight.w600,
            fontSize: 16,
          ),
        ),
        const SizedBox(height: 8),
        Stack(
          children: [
            Container(
              height: 10,
              decoration: BoxDecoration(
                color: AppColor.textColor.withOpacity(0.2),
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            Container(
              height: 10,
              width: progress * 300,
              decoration: BoxDecoration(
                color: AppColor.primaryColor,
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          ],
        ),
        const SizedBox(height: 6),
        Text(
          '${(progress * 100).toStringAsFixed(0)}% Completed',
          style: const TextStyle(color: AppColor.textColor, fontSize: 13),
        ),
      ],
    );
  }

  // ============================================================
  // Description Section
  // ============================================================

  Widget _buildDescriptionSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Description',
          style: TextStyle(
            color: AppColor.textColor,
            fontWeight: FontWeight.w600,
            fontSize: 16,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          project['description'] ??
              'This project focuses on building a modern housing complex '
                  'with an emphasis on sustainable design and smart features.',
          style: const TextStyle(
            color: AppColor.textColor,
            height: 1.5,
            fontSize: 14,
          ),
        ),
      ],
    );
  }

  // ============================================================
  // Developer Info Section
  // ============================================================

  Widget _buildDeveloperInfo() {
    return Row(
      children: [
        Container(
          height: 50,
          width: 50,
          decoration: BoxDecoration(
            color: AppColor.textColor.withOpacity(0.1),
            shape: BoxShape.circle,
          ),
          child: const Center(
            child: Text(
              'Logo',
              style: TextStyle(
                color: AppColor.textColor,
                fontSize: 12,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ),
        const SizedBox(width: 12),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text(
              'Rumaia Developer Group',
              style: TextStyle(
                color: AppColor.textColor,
                fontSize: 15,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(height: 4),
            Text(
              'Lead Developer',
              style: TextStyle(color: AppColor.textColor, fontSize: 13),
            ),
          ],
        ),
      ],
    );
  }

  // ============================================================
  // Commit Button
  // ============================================================

  Widget _buildCommitButton(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text('Committed to project!')));
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColor.primaryColor,
        minimumSize: const Size(double.infinity, 55),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      ),
      child: const Text(
        'Commit to Project',
        style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w600,
          fontSize: 16,
        ),
      ),
    );
  }
}
