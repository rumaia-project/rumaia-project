import 'package:flutter/material.dart';
import 'package:rumaia_project/main.dart'; // Import AuthHelper

class AdminDashboardScreen extends StatefulWidget {
  const AdminDashboardScreen({super.key});

  @override
  State<AdminDashboardScreen> createState() => _AdminDashboardScreenState();
}

class _AdminDashboardScreenState extends State<AdminDashboardScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  final int _currentIndex = 0;

  final List<Map<String, dynamic>> _stats = [
    {
      'title': 'Total Users',
      'value': '1,248',
      'icon': Icons.people_alt_rounded,
      'color': Colors.blue,
      'change': '+12%',
    },
    {
      'title': 'Active Projects',
      'value': '56',
      'icon': Icons.assignment_rounded,
      'color': Colors.green,
      'change': '+5%',
    },
    {
      'title': 'Revenue',
      'value': 'Rp2.4B',
      'icon': Icons.attach_money_rounded,
      'color': Colors.orange,
      'change': '+18%',
    },
    {
      'title': 'Pending Requests',
      'value': '23',
      'icon': Icons.pending_actions_rounded,
      'color': Colors.red,
      'change': '-3%',
    },
  ];

  final List<Map<String, dynamic>> _quickActions = [
    {
      'title': 'User Management',
      'icon': Icons.people_outline_rounded,
      'color': Colors.blue,
      'route': '/users',
    },
    {
      'title': 'Project Approval',
      'icon': Icons.assignment_turned_in_rounded,
      'color': Colors.green,
    },
    {
      'title': 'Financial Reports',
      'icon': Icons.bar_chart_rounded,
      'color': Colors.orange,
    },
    {
      'title': 'System Settings',
      'icon': Icons.settings_rounded,
      'color': Colors.purple,
    },
    {
      'title': 'Content Moderation',
      'icon': Icons.shield_rounded,
      'color': Colors.red,
    },
    {
      'title': 'Analytics',
      'icon': Icons.analytics_rounded,
      'color': Colors.teal,
    },
  ];

  final List<Map<String, dynamic>> _recentActivities = [
    {
      'user': 'Sarah Johnson',
      'action': 'created new project',
      'time': '2 min ago',
      'type': 'project',
    },
    {
      'user': 'Mike Chen',
      'action': 'updated profile',
      'time': '5 min ago',
      'type': 'user',
    },
    {
      'user': 'Lisa Wang',
      'action': 'submitted property request',
      'time': '10 min ago',
      'type': 'request',
    },
    {
      'user': 'David Brown',
      'action': 'completed payment',
      'time': '15 min ago',
      'type': 'payment',
    },
    {
      'user': 'Emma Davis',
      'action': 'reported issue',
      'time': '20 min ago',
      'type': 'report',
    },
  ];

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeOut),
    );
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  Color _getActivityColor(String type) {
    switch (type) {
      case 'project':
        return Colors.blue;
      case 'user':
        return Colors.green;
      case 'request':
        return Colors.orange;
      case 'payment':
        return Colors.teal;
      case 'report':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }

  IconData _getActivityIcon(String type) {
    switch (type) {
      case 'project':
        return Icons.assignment_rounded;
      case 'user':
        return Icons.person_rounded;
      case 'request':
        return Icons.request_quote_rounded;
      case 'payment':
        return Icons.payment_rounded;
      case 'report':
        return Icons.report_rounded;
      default:
        return Icons.notifications_rounded;
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: isDark
          ? const Color(0xFF0A0E21)
          : const Color(0xFFF8FAFC),
      appBar: AppBar(
        title: const Text(
          'Admin Dashboard',
          style: TextStyle(fontWeight: FontWeight.w700, fontSize: 20),
        ),
        backgroundColor: isDark ? const Color(0xFF1A1F3A) : Colors.white,
        elevation: 0,
        actions: [
          // Notification Icon
          IconButton(
            onPressed: () {},
            icon: Stack(
              children: [
                Icon(
                  Icons.notifications_outlined,
                  color: isDark ? Colors.white70 : Colors.grey.shade700,
                ),
                Positioned(
                  right: 0,
                  top: 0,
                  child: Container(
                    width: 8,
                    height: 8,
                    decoration: const BoxDecoration(
                      color: Colors.red,
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
              ],
            ),
          ),
          // Logout Button
          IconButton(
            onPressed: () => AuthHelper.showLogoutDialog(context),
            icon: Icon(
              Icons.logout_rounded,
              color: isDark ? Colors.white70 : Colors.grey.shade700,
            ),
            tooltip: 'Keluar Akun',
          ),
        ],
      ),
      body: FadeTransition(
        opacity: _fadeAnimation,
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Welcome Section
              _buildWelcomeSection(isDark),
              const SizedBox(height: 24),

              // Stats Overview
              _buildStatsOverview(isDark),
              const SizedBox(height: 28),

              // Quick Actions
              _buildSectionTitle('Quick Actions', isDark),
              const SizedBox(height: 16),
              _buildQuickActionsGrid(isDark),
              const SizedBox(height: 28),

              // Recent Activities
              _buildSectionTitle('Recent Activities', isDark),
              const SizedBox(height: 16),
              _buildRecentActivities(isDark),
              const SizedBox(height: 28),

              // System Status
              _buildSectionTitle('System Status', isDark),
              const SizedBox(height: 16),
              _buildSystemStatus(isDark),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildWelcomeSection(bool isDark) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: isDark
              ? [const Color(0xFF6366F1), const Color(0xFF8B5CF6)]
              : [const Color(0xFF2196F3), const Color(0xFF1976D2)],
        ),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: (isDark ? const Color(0xFF6366F1) : const Color(0xFF2196F3))
                .withOpacity(0.3),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.2),
              borderRadius: BorderRadius.circular(16),
            ),
            child: const Icon(
              Icons.admin_panel_settings_rounded,
              color: Colors.white,
              size: 32,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Welcome back, Admin!',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'Manage your platform efficiently',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.white.withOpacity(0.8),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatsOverview(bool isDark) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
        childAspectRatio: 1.2,
      ),
      itemCount: _stats.length,
      itemBuilder: (context, index) {
        final stat = _stats[index];
        return _buildStatCard(stat, isDark);
      },
    );
  }

  Widget _buildStatCard(Map<String, dynamic> stat, bool isDark) {
    return Container(
      padding: const EdgeInsets.all(16),
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
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: stat['color'].withOpacity(0.15),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(stat['icon'], color: stat['color'], size: 20),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: (stat['change'] as String).contains('+')
                      ? Colors.green.withOpacity(0.15)
                      : Colors.red.withOpacity(0.15),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  stat['change'],
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: (stat['change'] as String).contains('+')
                        ? Colors.green
                        : Colors.red,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            stat['title'],
            style: TextStyle(
              fontSize: 12,
              color: isDark ? Colors.white60 : Colors.grey.shade600,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            stat['value'],
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w800,
              color: isDark ? Colors.white : Colors.black87,
              letterSpacing: -0.5,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title, bool isDark) {
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
        Text(
          'View All',
          style: TextStyle(
            fontSize: 14,
            color: isDark ? Colors.blue.shade300 : Colors.blue.shade600,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }

  Widget _buildQuickActionsGrid(bool isDark) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
        childAspectRatio: 0.9,
      ),
      itemCount: _quickActions.length,
      itemBuilder: (context, index) {
        final action = _quickActions[index];
        return _buildQuickActionCard(action, isDark);
      },
    );
  }

  Widget _buildQuickActionCard(Map<String, dynamic> action, bool isDark) {
    return Material(
      color: isDark ? const Color(0xFF1A1F3A) : Colors.white,
      borderRadius: BorderRadius.circular(16),
      child: InkWell(
        onTap: () {},
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
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: action['color'].withOpacity(0.15),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(action['icon'], color: action['color'], size: 24),
              ),
              const SizedBox(height: 8),
              Text(
                action['title'],
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: isDark ? Colors.white : Colors.black87,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildRecentActivities(bool isDark) {
    return Container(
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF1A1F3A) : Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: isDark ? Colors.white.withOpacity(0.05) : Colors.grey.shade200,
        ),
      ),
      child: Column(
        children: _recentActivities.map((activity) {
          return _buildActivityItem(activity, isDark);
        }).toList(),
      ),
    );
  }

  Widget _buildActivityItem(Map<String, dynamic> activity, bool isDark) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: isDark
                ? Colors.white.withOpacity(0.05)
                : Colors.grey.shade100,
          ),
        ),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: _getActivityColor(activity['type']).withOpacity(0.15),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(
              _getActivityIcon(activity['type']),
              color: _getActivityColor(activity['type']),
              size: 20,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  activity['user'],
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: isDark ? Colors.white : Colors.black87,
                  ),
                ),
                Text(
                  activity['action'],
                  style: TextStyle(
                    fontSize: 12,
                    color: isDark ? Colors.white60 : Colors.grey.shade600,
                  ),
                ),
              ],
            ),
          ),
          Text(
            activity['time'],
            style: TextStyle(
              fontSize: 11,
              color: isDark ? Colors.white38 : Colors.grey.shade500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSystemStatus(bool isDark) {
    final systemStatus = [
      {'service': 'API Server', 'status': 'Online', 'color': Colors.green},
      {'service': 'Database', 'status': 'Online', 'color': Colors.green},
      {'service': 'File Storage', 'status': 'Online', 'color': Colors.green},
      {'service': 'Email Service', 'status': 'Warning', 'color': Colors.orange},
      {'service': 'Payment Gateway', 'status': 'Online', 'color': Colors.green},
    ];

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF1A1F3A) : Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: isDark ? Colors.white.withOpacity(0.05) : Colors.grey.shade200,
        ),
      ),
      child: Column(
        children: systemStatus.map((status) {
          return _buildStatusItem(status, isDark);
        }).toList(),
      ),
    );
  }

  Widget _buildStatusItem(Map<String, dynamic> status, bool isDark) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: isDark
                ? Colors.white.withOpacity(0.05)
                : Colors.grey.shade100,
          ),
        ),
      ),
      child: Row(
        children: [
          Expanded(
            child: Text(
              status['service'],
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: isDark ? Colors.white : Colors.black87,
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: status['color'].withOpacity(0.15),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              status['status'],
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: status['color'],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
