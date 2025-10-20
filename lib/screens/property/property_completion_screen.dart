import 'package:flutter/material.dart';

/// 📊 Model Data Status Proyek
class ProjectStatus {
  final String id;
  final String projectName;
  final String propertyType;
  final double progressPercentage; // 0.0–1.0
  final String estimatedCompletion;
  final IconData icon;
  final Color progressColor;

  const ProjectStatus({
    required this.id,
    required this.projectName,
    required this.propertyType,
    required this.progressPercentage,
    required this.estimatedCompletion,
    required this.icon,
    required this.progressColor,
  });
}

class PropertyCompletionScreen extends StatelessWidget {
  const PropertyCompletionScreen({super.key});

  // 🎨 Warna dasar
  static const Color primaryTeal = Color(0xFF00AFA0);
  static const Color neutralBg = Color(0xFFF5F6F7);

  // Mock data
  final List<ProjectStatus> projects = const [
    ProjectStatus(
      id: 'P001',
      projectName: 'Cluster Bukit Asri - Unit B12',
      propertyType: 'Rumah Tinggal',
      progressPercentage: 0.75,
      estimatedCompletion: '2 bulan lagi (Des 2025)',
      icon: Icons.architecture,
      progressColor: Colors.orange,
    ),
    ProjectStatus(
      id: 'P002',
      projectName: 'The Grand Apartment - Tower C',
      propertyType: 'Apartemen',
      progressPercentage: 0.20,
      estimatedCompletion: '10 bulan lagi (Jun 2026)',
      icon: Icons.apartment,
      progressColor: Colors.blue,
    ),
    ProjectStatus(
      id: 'P003',
      projectName: 'Kavling Siap Bangun - Tahap 4',
      propertyType: 'Kavling',
      progressPercentage: 1.0,
      estimatedCompletion: 'Selesai (Siap Ditempati)',
      icon: Icons.check_circle_outline,
      progressColor: primaryTeal,
    ),
  ];

  /// 🔹 AppBar Minimalis
  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      centerTitle: true,
      title: const Text(
        'Status Proyek',
        style: TextStyle(color: Colors.black87, fontWeight: FontWeight.w600),
      ),
      leading: IconButton(
        icon: const Icon(Icons.arrow_back, color: Colors.black87),
        onPressed: () => Navigator.pop(context),
      ),
    );
  }

  /// 📋 Kartu Proyek
  Widget _buildProjectCard(BuildContext context, ProjectStatus project) {
    final bool isCompleted = project.progressPercentage >= 1.0;
    final double safeProgress = project.progressPercentage.clamp(0.0, 1.0);
    final String progressText = '${(safeProgress * 100).toStringAsFixed(0)}%';

    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      color: Colors.white,
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(
          color: isCompleted
              ? primaryTeal.withOpacity(0.3)
              : Colors.grey.shade300,
        ),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: () {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Melihat detail: ${project.projectName}'),
              behavior: SnackBarBehavior.floating,
            ),
          );
        },
        child: Padding(
          padding: const EdgeInsets.all(18.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      CircleAvatar(
                        radius: 18,
                        backgroundColor: project.progressColor.withOpacity(0.1),
                        child: Icon(
                          project.icon,
                          color: project.progressColor,
                          size: 20,
                        ),
                      ),
                      const SizedBox(width: 10),
                      Text(
                        project.propertyType,
                        style: const TextStyle(
                          fontSize: 13,
                          color: Colors.black54,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                  if (isCompleted)
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: primaryTeal.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: primaryTeal.withOpacity(0.3)),
                      ),
                      child: const Text(
                        'SELESAI',
                        style: TextStyle(
                          color: primaryTeal,
                          fontWeight: FontWeight.w600,
                          fontSize: 12,
                        ),
                      ),
                    ),
                ],
              ),
              const SizedBox(height: 12),

              // Nama proyek
              Text(
                project.projectName,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 12),

              // Progress bar
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Progress Fisik",
                    style: TextStyle(fontSize: 13, color: Colors.black54),
                  ),
                  Text(
                    progressText,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: project.progressColor,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 6),
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: LinearProgressIndicator(
                  value: safeProgress,
                  minHeight: 8,
                  backgroundColor: Colors.grey.shade200,
                  valueColor: AlwaysStoppedAnimation<Color>(
                    project.progressColor,
                  ),
                ),
              ),
              const SizedBox(height: 12),

              // Estimasi waktu
              Row(
                children: [
                  const Icon(Icons.schedule, size: 16, color: Colors.black45),
                  const SizedBox(width: 6),
                  Expanded(
                    child: Text(
                      'Estimasi: ${project.estimatedCompletion}',
                      style: const TextStyle(
                        fontSize: 13,
                        color: Colors.black54,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// 📄 Empty State
  Widget _buildEmptyState() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(40),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.home_repair_service_outlined,
              size: 80,
              color: Colors.grey,
            ),
            const SizedBox(height: 20),
            const Text(
              "Belum Ada Proyek",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w600,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              "Pantau kemajuan proyek Anda di sini setelah pembangunan dimulai.",
              style: TextStyle(color: Colors.black54),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            OutlinedButton.icon(
              onPressed: () {},
              icon: const Icon(Icons.add_task, color: primaryTeal),
              label: const Text("Mulai Proyek Baru"),
              style: OutlinedButton.styleFrom(
                side: const BorderSide(color: primaryTeal),
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 12,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: neutralBg,
      appBar: _buildAppBar(context),
      body: projects.isEmpty
          ? _buildEmptyState()
          : SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Pemantauan Proyek Anda',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 4),
                  const Text(
                    'Pantau perkembangan pembangunan properti Anda secara real-time.',
                    style: TextStyle(fontSize: 13, color: Colors.black54),
                  ),
                  const SizedBox(height: 20),
                  ...projects.map((e) => _buildProjectCard(context, e)),
                ],
              ),
            ),
    );
  }
}
