import 'package:flutter/material.dart';
import 'package:rumaia_project/utils/developer/app_color.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.backgroundColor,

      // === AppBar : Simple top header with title and notification icon ===
      appBar: AppBar(
        title: Text("Home", style: TextStyle(fontWeight: FontWeight.w600)),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.white,
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.notifications_none_rounded),
            color: Colors.black,
          ),
        ],
      ),

      // === Main Content Area ===
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ----------------------------------------------------------
            // Greeting Section - shows personalized welcome message
            // and quick project/investment summary.
            // ----------------------------------------------------------
            Container(
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12.withOpacity(0.05),
                    blurRadius: 6,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Hello, Christ Bow",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 4),
                  Text(
                    "Welcome back to your Rumaia account.",
                    style: TextStyle(color: AppColor.textColor),
                  ),
                  SizedBox(height: 16),

                  // === Summary Insight Cards (Active Projects / Investment) ===
                  Row(
                    children: [
                      _buildStatsCard(
                        title: "Active Projects",
                        value: "12",
                        color: AppColor.primaryColor,
                        icon: Icons.folder_open_rounded,
                      ),
                      SizedBox(width: 12),
                      _buildStatsCard(
                        title: "Total Investment",
                        value: "\$1.2M",
                        color: AppColor.accentColor,
                        icon: Icons.show_chart_rounded,
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),

            // ----------------------------------------------------------
            // Quick Actions — shortcut buttons to frequent tasks.
            // e.g. add project, view portfolio, view progress.
            // ----------------------------------------------------------
            Text(
              "Quick Actions",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
            SizedBox(height: 12),
            _buildActionButton(
              context,
              title: "Add New Project",
              icon: Icons.add_box_rounded,
              filled: true,
              color: AppColor.primaryColor,
            ),
            SizedBox(height: 10),
            _buildActionButton(
              context,
              title: "View Portfolio",
              icon: Icons.work_outline_rounded,
              filled: false,
            ),
            SizedBox(height: 10),
            _buildActionButton(
              context,
              title: "View Project Progress",
              icon: Icons.trending_up_rounded,
              filled: false,
            ),
            SizedBox(height: 30),

            // ----------------------------------------------------------
            // Quick Insights — compact financial overview cards.
            // ----------------------------------------------------------
            Text(
              "Quick Insights",
              style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
            ),
            SizedBox(height: 12),
            Row(
              children: [
                _buildInsightsCard(
                  "Total Value",
                  "Rp2.5B",
                  Icons.account_balance_wallet_rounded,
                ),
                SizedBox(width: 12),
                _buildInsightsCard(
                  "Funds Raised",
                  "Rp1.8B",
                  Icons.attach_money_rounded,
                ),
              ],
            ),
            SizedBox(height: 24),

            // ----------------------------------------------------------
            // Monthly Performance Section — placeholder for chart widget.
            // Future upgrade: integrate with analytics/graph package.
            // ----------------------------------------------------------
            Text(
              "Monthly Performance",
              style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
            ),
            SizedBox(height: 12),
            Container(
              height: 140,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
              ),
              alignment: Alignment.center,
              child: Text(
                "Interactive chart will load here",
                style: TextStyle(color: Colors.grey),
              ),
            ),
            SizedBox(height: 24),

            // ----------------------------------------------------------
            // Active Projects — list of ongoing or funded developments.
            // Includes title, funding status, and progress indicator.
            // ----------------------------------------------------------
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Active Projects",
                  style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
                ),
                Icon(Icons.filter_list_rounded, size: 20),
              ],
            ),
            SizedBox(height: 12),
            _buildProjectCard(
              title: "Luxury Apartment Complex",
              status: "Funding",
              target: "Rp500M",
              raised: "Rp350M",
              progress: 0.7,
              color: AppColor.primaryColor,
            ),
            _buildProjectCard(
              title: "Commercial Plaza",
              status: "In Progress",
              target: "Rp800M",
              raised: "Rp720M",
              progress: 0.9,
              color: Colors.green,
            ),
            _buildProjectCard(
              title: "Residential Tower",
              status: "Funding",
              target: "Rp1.2B",
              raised: "Rp480M",
              progress: 0.4,
              color: AppColor.primaryColor,
            ),
          ],
        ),
      ),
    );
  }
}

// === Private Builders ===
// Each widget builder encapsulates a small reusable component.

/// Build a single stats summary card
Widget _buildStatsCard({
  required String title,
  required String value,
  required Color color,
  required IconData icon,
}) {
  return Expanded(
    child: Container(
      padding: EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: AppColor.backgroundColor,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: color),
          SizedBox(height: 8),
          Text(title, style: TextStyle(fontSize: 12, color: Colors.grey)),
          SizedBox(height: 4),
          Text(
            value,
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    ),
  );
}

/// Build a custom button used for quick actions.
/// Supports filled and outlined styles for flexibility.
Widget _buildActionButton(
  BuildContext context, {
  required String title,
  required IconData icon,
  bool filled = false,
  Color? color,
}) {
  return Container(
    width: double.infinity,
    decoration: BoxDecoration(
      color: filled ? color ?? Colors.blue : Colors.transparent,
      border: Border.all(
        color: filled ? Colors.transparent : Colors.grey.shade300,
      ),
      borderRadius: BorderRadius.circular(8),
    ),
    child: TextButton.icon(
      onPressed: () {}, // TODO: connect to route or function
      label: Text(
        title,
        style: TextStyle(
          color: filled ? Colors.white : Colors.black,
          fontWeight: FontWeight.w500,
        ),
      ),
      icon: Icon(icon, color: filled ? Colors.white : Colors.black),
    ),
  );
}

/// Build an insight card — compact representation of a financial metric.
Widget _buildInsightsCard(String title, String value, IconData icon) {
  return Expanded(
    child: Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Column(
        children: [
          Icon(icon, color: Colors.blue),
          SizedBox(height: 8),
          Text(title, style: TextStyle(fontSize: 12, color: Colors.grey)),
          SizedBox(height: 4),
          Text(
            value,
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    ),
  );
}

/// Build a single project card displaying funding status and progress.
Widget _buildProjectCard({
  required String title,
  required String status,
  required String target,
  required String raised,
  required double progress,
  required Color color,
}) {
  return Container(
    margin: EdgeInsets.only(bottom: 12),
    padding: EdgeInsets.all(14),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: Colors.grey.shade200),
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Thumbnail Placeholder (future: replace with network image)
        Container(
          height: 60,
          width: 60,
          decoration: BoxDecoration(
            color: Color(0xFFF2F2F2),
            borderRadius: BorderRadius.circular(8),
          ),
          alignment: Alignment.center,
          child: Text(
            "Image",
            style: TextStyle(fontSize: 10, color: Colors.grey),
          ),
        ),
        SizedBox(width: 12),

        // === Project Metadata and Progress ===
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Project Title
              Text(
                title,
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
              ),
              SizedBox(height: 4),

              //Status Badge
              Row(
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                    decoration: BoxDecoration(
                      color: color.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Text(
                      status,
                      style: TextStyle(
                        fontSize: 12,
                        color: color,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 6),

              // Target vs Raised Info
              Text(
                "Target: $target    Raised: $raised",
                style: TextStyle(fontSize: 12, color: Colors.grey),
              ),
              SizedBox(height: 6),

              // Funding Progress Bar
              ClipRRect(
                borderRadius: BorderRadiusGeometry.circular(6),
                child: LinearProgressIndicator(
                  value: progress,
                  color: color,
                  backgroundColor: Colors.grey.shade200,
                  minHeight: 6,
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}
