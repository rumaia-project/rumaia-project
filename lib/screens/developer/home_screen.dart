import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:rumaia_project/utils/developer/app_color.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeOut),
    );
    _slideAnimation =
        Tween<Offset>(begin: const Offset(0, 0.05), end: Offset.zero).animate(
          CurvedAnimation(
            parent: _animationController,
            curve: Curves.easeOutCubic,
          ),
        );
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark
          ? const Color(0xFF0A0E21)
          : const Color(0xFFF8FAFC),

      // === Modern AppBar with Blur Effect ===
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          // Animated App Bar
          SliverAppBar(
            expandedHeight: 120,
            floating: true,
            pinned: true,
            elevation: 0,
            backgroundColor: isDark ? const Color(0xFF1A1F3A) : Colors.white,
            flexibleSpace: FlexibleSpaceBar(
              background: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: isDark
                        ? [const Color(0xFF1A1F3A), const Color(0xFF0A0E21)]
                        : [Colors.white, const Color(0xFFF8FAFC)],
                  ),
                ),
                child: SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(20, 16, 20, 0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Dashboard',
                                  style: TextStyle(
                                    fontSize: 28,
                                    fontWeight: FontWeight.w800,
                                    color: isDark
                                        ? Colors.white
                                        : Colors.black87,
                                    letterSpacing: -0.5,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  'Kelola properti Anda',
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: isDark
                                        ? Colors.white60
                                        : Colors.black54,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                            // Notification Bell with Badge
                            Stack(
                              children: [
                                Container(
                                  padding: const EdgeInsets.all(12),
                                  decoration: BoxDecoration(
                                    color: isDark
                                        ? Colors.white.withOpacity(0.1)
                                        : AppColor.primaryColor.withOpacity(
                                            0.1,
                                          ),
                                    borderRadius: BorderRadius.circular(14),
                                  ),
                                  child: Icon(
                                    Icons.notifications_rounded,
                                    color: isDark
                                        ? Colors.white
                                        : AppColor.primaryColor,
                                    size: 24,
                                  ),
                                ),
                                Positioned(
                                  right: 8,
                                  top: 8,
                                  child: Container(
                                    width: 8,
                                    height: 8,
                                    decoration: BoxDecoration(
                                      color: Colors.red,
                                      shape: BoxShape.circle,
                                      border: Border.all(
                                        color: isDark
                                            ? const Color(0xFF1A1F3A)
                                            : Colors.white,
                                        width: 2,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),

          // Main Content
          SliverToBoxAdapter(
            child: FadeTransition(
              opacity: _fadeAnimation,
              child: SlideTransition(
                position: _slideAnimation,
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Greeting Card with Gradient
                      _buildGreetingCard(context, isDark),
                      const SizedBox(height: 24),

                      // Stats Overview
                      _buildStatsOverview(isDark),
                      const SizedBox(height: 28),

                      // Quick Actions Grid
                      _buildSectionTitle('Aksi Cepat', isDark),
                      const SizedBox(height: 12),
                      _buildQuickActions(context, isDark),
                      const SizedBox(height: 28),

                      // Financial Insights
                      _buildSectionTitle('Insight Keuangan', isDark),
                      const SizedBox(height: 12),
                      _buildFinancialInsights(isDark),
                      const SizedBox(height: 28),

                      // Performance Chart
                      _buildSectionTitle('Performa Bulanan', isDark),
                      const SizedBox(height: 12),
                      _buildPerformanceChart(isDark),
                      const SizedBox(height: 28),

                      // Active Projects
                      _buildSectionTitle(
                        'Proyek Aktif',
                        isDark,
                        hasFilter: true,
                      ),
                      const SizedBox(height: 12),
                      _buildProjectsList(isDark),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // === Greeting Card ===
  Widget _buildGreetingCard(BuildContext context, bool isDark) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: isDark
              ? [const Color(0xFF6366F1), const Color(0xFF8B5CF6)]
              : [AppColor.primaryColor, const Color(0xFF5B73E8)],
        ),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: (isDark ? const Color(0xFF6366F1) : AppColor.primaryColor)
                .withOpacity(0.3),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(
                  Icons.waving_hand_rounded,
                  color: Colors.white,
                  size: 24,
                ),
              ),
              const SizedBox(width: 12),
              const Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Halo, Christ Bow',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                        letterSpacing: -0.3,
                      ),
                    ),
                    SizedBox(height: 2),
                    Text(
                      'Selamat datang kembali! 🚀',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.white70,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // === Stats Overview ===
  Widget _buildStatsOverview(bool isDark) {
    return Row(
      children: [
        Expanded(
          child: _buildStatCard(
            title: 'Proyek Aktif',
            value: '12',
            icon: Icons.folder_open_rounded,
            color: const Color(0xFF10B981),
            isDark: isDark,
            trend: '+2',
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: _buildStatCard(
            title: 'Total Investasi',
            value: '\$1.2M',
            icon: Icons.trending_up_rounded,
            color: const Color(0xFFF59E0B),
            isDark: isDark,
            trend: '+15%',
          ),
        ),
      ],
    );
  }

  Widget _buildStatCard({
    required String title,
    required String value,
    required IconData icon,
    required Color color,
    required bool isDark,
    String? trend,
  }) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF1A1F3A) : Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: isDark ? Colors.white.withOpacity(0.05) : Colors.grey.shade200,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(isDark ? 0.2 : 0.04),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: color.withOpacity(0.15),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(icon, color: color, size: 20),
              ),
              if (trend != null)
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: const Color(0xFF10B981).withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    trend,
                    style: const TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF10B981),
                    ),
                  ),
                ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            title,
            style: TextStyle(
              fontSize: 12,
              color: isDark ? Colors.white60 : Colors.grey.shade600,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            value,
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w800,
              color: isDark ? Colors.white : Colors.black87,
              letterSpacing: -0.5,
            ),
          ),
        ],
      ),
    );
  }

  // === Section Title ===
  Widget _buildSectionTitle(
    String title,
    bool isDark, {
    bool hasFilter = false,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w700,
            color: isDark ? Colors.white : Colors.black87,
            letterSpacing: -0.3,
          ),
        ),
        if (hasFilter)
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: isDark
                  ? Colors.white.withOpacity(0.05)
                  : Colors.grey.shade100,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(
              Icons.tune_rounded,
              size: 18,
              color: isDark ? Colors.white70 : Colors.black54,
            ),
          ),
      ],
    );
  }

  // === Quick Actions Grid ===
  Widget _buildQuickActions(BuildContext context, bool isDark) {
    final actions = [
      {
        'title': 'Tambah Proyek',
        'icon': Icons.add_box_rounded,
        'color': const Color(0xFF6366F1),
      },
      {
        'title': 'Portfolio',
        'icon': Icons.work_outline_rounded,
        'color': const Color(0xFF8B5CF6),
      },
      {
        'title': 'Progress',
        'icon': Icons.timeline_rounded,
        'color': const Color(0xFF10B981),
      },
      {
        'title': 'Laporan',
        'icon': Icons.assessment_rounded,
        'color': const Color(0xFFF59E0B),
      },
    ];

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
        childAspectRatio: 1.5,
      ),
      itemCount: actions.length,
      itemBuilder: (context, index) {
        final action = actions[index];
        return _buildActionCard(
          title: action['title'] as String,
          icon: action['icon'] as IconData,
          color: action['color'] as Color,
          isDark: isDark,
        );
      },
    );
  }

  Widget _buildActionCard({
    required String title,
    required IconData icon,
    required Color color,
    required bool isDark,
  }) {
    return Material(
      color: isDark ? const Color(0xFF1A1F3A) : Colors.white,
      borderRadius: BorderRadius.circular(16),
      child: InkWell(
        onTap: () => HapticFeedback.lightImpact(),
        borderRadius: BorderRadius.circular(16),
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: isDark
                  ? Colors.white.withOpacity(0.05)
                  : Colors.grey.shade200,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: color.withOpacity(0.15),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(icon, color: color, size: 24),
              ),
              const SizedBox(height: 12),
              Text(
                title,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: isDark ? Colors.white : Colors.black87,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // === Financial Insights ===
  Widget _buildFinancialInsights(bool isDark) {
    return Row(
      children: [
        Expanded(
          child: _buildInsightCard(
            title: 'Total Nilai',
            value: 'Rp2.5B',
            icon: Icons.account_balance_wallet_rounded,
            color: const Color(0xFF6366F1),
            isDark: isDark,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: _buildInsightCard(
            title: 'Dana Terkumpul',
            value: 'Rp1.8B',
            icon: Icons.payments_rounded,
            color: const Color(0xFF10B981),
            isDark: isDark,
          ),
        ),
      ],
    );
  }

  Widget _buildInsightCard({
    required String title,
    required String value,
    required IconData icon,
    required Color color,
    required bool isDark,
  }) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF1A1F3A) : Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: isDark ? Colors.white.withOpacity(0.05) : Colors.grey.shade200,
        ),
      ),
      child: Column(
        children: [
          Icon(icon, color: color, size: 32),
          const SizedBox(height: 12),
          Text(
            title,
            style: TextStyle(
              fontSize: 12,
              color: isDark ? Colors.white60 : Colors.grey.shade600,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            value,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w800,
              color: isDark ? Colors.white : Colors.black87,
              letterSpacing: -0.3,
            ),
          ),
        ],
      ),
    );
  }

  // === Performance Chart Placeholder ===
  Widget _buildPerformanceChart(bool isDark) {
    return Container(
      height: 180,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: isDark
              ? [const Color(0xFF1A1F3A), const Color(0xFF252A48)]
              : [Colors.white, const Color(0xFFF8FAFC)],
        ),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: isDark ? Colors.white.withOpacity(0.05) : Colors.grey.shade200,
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.show_chart_rounded,
            size: 48,
            color: isDark ? Colors.white24 : Colors.grey.shade300,
          ),
          const SizedBox(height: 12),
          Text(
            'Grafik performa akan ditampilkan di sini',
            style: TextStyle(
              fontSize: 13,
              color: isDark ? Colors.white38 : Colors.grey.shade500,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  // === Projects List ===
  Widget _buildProjectsList(bool isDark) {
    final projects = [
      {
        'title': 'Luxury Apartment Complex',
        'status': 'Funding',
        'target': 'Rp500M',
        'raised': 'Rp350M',
        'progress': 0.7,
        'color': const Color(0xFF6366F1),
      },
      {
        'title': 'Commercial Plaza',
        'status': 'In Progress',
        'target': 'Rp800M',
        'raised': 'Rp720M',
        'progress': 0.9,
        'color': const Color(0xFF10B981),
      },
      {
        'title': 'Residential Tower',
        'status': 'Funding',
        'target': 'Rp1.2B',
        'raised': 'Rp480M',
        'progress': 0.4,
        'color': const Color(0xFFF59E0B),
      },
    ];

    return Column(
      children: projects.map((project) {
        return _buildProjectCard(
          title: project['title'] as String,
          status: project['status'] as String,
          target: project['target'] as String,
          raised: project['raised'] as String,
          progress: project['progress'] as double,
          color: project['color'] as Color,
          isDark: isDark,
        );
      }).toList(),
    );
  }

  Widget _buildProjectCard({
    required String title,
    required String status,
    required String target,
    required String raised,
    required double progress,
    required Color color,
    required bool isDark,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF1A1F3A) : Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: isDark ? Colors.white.withOpacity(0.05) : Colors.grey.shade200,
        ),
      ),
      child: Row(
        children: [
          // Project Image
          Container(
            width: 70,
            height: 70,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [color.withOpacity(0.2), color.withOpacity(0.1)],
              ),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(Icons.apartment_rounded, color: color, size: 32),
          ),
          const SizedBox(width: 14),

          // Project Details
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                    color: isDark ? Colors.white : Colors.black87,
                    letterSpacing: -0.2,
                  ),
                ),
                const SizedBox(height: 6),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: color.withOpacity(0.15),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    status,
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                      color: color,
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Target: $target',
                            style: TextStyle(
                              fontSize: 11,
                              color: isDark
                                  ? Colors.white54
                                  : Colors.grey.shade600,
                            ),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            'Terkumpul: $raised',
                            style: TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.w600,
                              color: isDark ? Colors.white70 : Colors.black87,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Text(
                      '${(progress * 100).toInt()}%',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                        color: color,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: LinearProgressIndicator(
                    value: progress,
                    backgroundColor: isDark
                        ? Colors.white.withOpacity(0.1)
                        : Colors.grey.shade200,
                    valueColor: AlwaysStoppedAnimation<Color>(color),
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
}
