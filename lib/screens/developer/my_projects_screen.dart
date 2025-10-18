import 'package:flutter/material.dart';
import 'package:rumaia_project/models/developer/my_project_model.dart';
import 'package:rumaia_project/utils/developer/app_color.dart';

class MyProjectsScreen extends StatefulWidget {
  const MyProjectsScreen({super.key});

  @override
  State<MyProjectsScreen> createState() => _MyProjectsScreenState();
}

class _MyProjectsScreenState extends State<MyProjectsScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  /// === Dummy data untuk tiga status proyek ===
  final List<ProjectModel> fundingProjects = [
    ProjectModel(
      title: "Greenview Residence",
      location: "Jakarta, Indonesia",
      progress: 0.48,
      status: "Funding",
      fundingStatus: "Funding",
      currentFund: 1.2,
      targetFund: 2.5,
      estimation: "",
      imagePlaceholder: "Modern Villa",
    ),
  ];

  final List<ProjectModel> inProgressProjects = [
    ProjectModel(
      title: "Skyline Tower",
      location: "Surabaya, Indonesia",
      progress: 0.75,
      status: "In Progress",
      fundingStatus: "In Progress",
      currentFund: 0,
      targetFund: 0,
      estimation: "Est. Q4 2025",
      imagePlaceholder: "Urban Loft Apartment",
    ),
  ];

  final List<ProjectModel> completedProjects = [
    ProjectModel(
      title: "Ocean Breeze Estate",
      location: "Bali, Indonesia",
      progress: 1.0,
      status: "Completed",
      fundingStatus: "Completed",
      currentFund: 0,
      targetFund: 0,
      estimation: "Fully Funded & Built",
      imagePlaceholder: "Seaside Bungalow",
    ),
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  /// ===============================================================
  /// 🧭 BUILD UI
  /// ===============================================================
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.backgroundColor,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        centerTitle: true,
        title: const Text(
          "My Projects",
          style: TextStyle(fontWeight: FontWeight.w700),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_none_rounded),
            onPressed: () {},
          ),
        ],
      ),

      /// === Body ===
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ===============================================================
            // 🧾 HEADER STATISTICS CARD
            // ===============================================================
            _buildHeaderStatistics(),

            const SizedBox(height: 16),

            // ===============================================================
            // 🗂️ TAB BAR
            // ===============================================================
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.grey.shade300),
              ),
              child: TabBar(
                controller: _tabController,
                labelColor: AppColor.primaryColor,
                unselectedLabelColor: Colors.grey,
                indicatorColor: AppColor.primaryColor,
                indicatorWeight: 3,
                tabs: const [
                  Tab(text: "Funding"),
                  Tab(text: "In Progress"),
                  Tab(text: "Completed"),
                ],
              ),
            ),

            const SizedBox(height: 16),

            // ===============================================================
            // 📋 TAB VIEW CONTENT
            // ===============================================================
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: [
                  _buildProjectList(fundingProjects),
                  _buildProjectList(inProgressProjects),
                  _buildProjectList(completedProjects),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// ===============================================================
  /// 📊 HEADER STATISTICS CARD
  /// ===============================================================
  Widget _buildHeaderStatistics() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Total Projects",
            style: TextStyle(color: Colors.grey, fontWeight: FontWeight.w500),
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "12",
                style: TextStyle(fontSize: 32, fontWeight: FontWeight.w700),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: const [
                  _StatLabel(label: "Funding", count: 5, color: Colors.blue),
                  _StatLabel(
                    label: "In Progress",
                    count: 4,
                    color: Colors.teal,
                  ),
                  _StatLabel(label: "Completed", count: 3, color: Colors.green),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  /// ===============================================================
  /// 📦 PROJECT CARD LIST BUILDER
  /// ===============================================================
  Widget _buildProjectList(List<ProjectModel> projects) {
    return ListView.builder(
      itemCount: projects.length,
      itemBuilder: (context, index) {
        final p = projects[index];
        return Container(
          margin: const EdgeInsets.only(bottom: 16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(14),
            boxShadow: [
              BoxShadow(
                color: Colors.black12.withOpacity(0.05),
                blurRadius: 4,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // === Placeholder Image ===
                Container(
                  height: 120,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: const Color(0xFFEAEAEA),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    p.imagePlaceholder,
                    style: const TextStyle(
                      fontWeight: FontWeight.w600,
                      color: Colors.black54,
                    ),
                  ),
                ),
                const SizedBox(height: 12),

                // === Project Info ===
                Text(
                  p.title,
                  style: const TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    const Icon(Icons.location_on_outlined, size: 16),
                    const SizedBox(width: 4),
                    Text(
                      p.location,
                      style: TextStyle(
                        color: Colors.grey.shade600,
                        fontSize: 13,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),

                // === Status Tag ===
                Align(
                  alignment: Alignment.centerRight,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: p.status == "Funding"
                          ? Colors.blue.shade50
                          : p.status == "In Progress"
                          ? Colors.teal.shade50
                          : Colors.green.shade50,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      p.status,
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: p.status == "Funding"
                            ? Colors.blue
                            : p.status == "In Progress"
                            ? Colors.teal
                            : Colors.green,
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 8),

                // === Progress Bar + Label ===
                if (p.status == "Funding") ...[
                  Text(
                    "Rp ${p.currentFund}B of Rp ${p.targetFund}B",
                    style: const TextStyle(fontSize: 13),
                  ),
                  const SizedBox(height: 4),
                  LinearProgressIndicator(
                    value: p.currentFund / p.targetFund,
                    minHeight: 8,
                    backgroundColor: Colors.grey.shade200,
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(10),
                  ),
                ] else if (p.status == "In Progress") ...[
                  Text(
                    "${(p.progress * 100).toInt()}% Complete   ${p.estimation}",
                    style: const TextStyle(fontSize: 13),
                  ),
                  const SizedBox(height: 4),
                  LinearProgressIndicator(
                    value: p.progress,
                    minHeight: 8,
                    backgroundColor: Colors.grey.shade200,
                    color: Colors.teal,
                    borderRadius: BorderRadius.circular(10),
                  ),
                ] else ...[
                  Text(p.estimation, style: const TextStyle(fontSize: 13)),
                  const SizedBox(height: 4),
                  LinearProgressIndicator(
                    value: 1,
                    minHeight: 8,
                    backgroundColor: Colors.grey.shade200,
                    color: Colors.green,
                    borderRadius: BorderRadius.circular(10),
                  ),
                ],

                const SizedBox(height: 12),

                // === Action Buttons ===
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      onPressed: () {},
                      child: const Text(
                        "View",
                        style: TextStyle(fontWeight: FontWeight.w600),
                      ),
                    ),
                    if (p.status != "Completed")
                      ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColor.primaryColor,
                          padding: const EdgeInsets.symmetric(horizontal: 18),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: const Text(
                          "Update",
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                        ),
                      ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

/// ===============================================================
/// 🔹 Small Widget: Statistic Label
/// ===============================================================
class _StatLabel extends StatelessWidget {
  final String label;
  final int count;
  final Color color;

  const _StatLabel({
    required this.label,
    required this.count,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 6,
          height: 6,
          decoration: BoxDecoration(color: color, shape: BoxShape.circle),
        ),
        const SizedBox(width: 6),
        Text(
          "$label  $count",
          style: TextStyle(
            fontSize: 12,
            color: color,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}
