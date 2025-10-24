// screens/developer/admin_verification_screen.dart
// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:rumaia_project/widgets/developer/botnavbar.dart';

class AdminVerificationScreen extends StatefulWidget {
  const AdminVerificationScreen({super.key});

  @override
  State<AdminVerificationScreen> createState() =>
      _AdminVerificationScreenState();
}

class _AdminVerificationScreenState extends State<AdminVerificationScreen> {
  VerificationStatus _status = VerificationStatus.pending;
  String _statusMessage = 'Menunggu verifikasi admin...';
  bool _canRetry = false;

  // Data untuk styling seperti screen sebelumnya
  final Map<String, dynamic> _developerData = {
    'icon': Icons.admin_panel_settings_rounded,
    'color': const Color(0xFF9B59B6),
    'gradient': const [Color(0xFF9B59B6), Color(0xFF8E44AD)],
  };

  @override
  void initState() {
    super.initState();
    _simulateAdminVerification();
  }

  Future<void> _simulateAdminVerification() async {
    // Simulate admin verification process
    await Future.delayed(const Duration(seconds: 5));

    // For demo purposes, let's assume it's always successful
    setState(() {
      _status = VerificationStatus.approved;
      _statusMessage = 'Verifikasi berhasil! Akun Anda telah aktif.';
    });
  }

  void _navigateToDashboard() {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => const BotnavbarScreen()),
      (route) => false,
    );
  }

  void _retryVerification() {
    setState(() {
      _status = VerificationStatus.pending;
      _statusMessage = 'Mengulangi proses verifikasi...';
      _canRetry = false;
    });
    _simulateAdminVerification();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final color = _developerData['color'] as Color;
    final gradient = _developerData['gradient'] as List<Color>;

    return Scaffold(
      body: Container(
        width: size.width,
        height: size.height,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: gradient,
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                children: [
                  SizedBox(height: size.height * 0.03),

                  // Back Button
                  Align(
                    alignment: Alignment.centerLeft,
                    child: IconButton(
                      onPressed: () => Navigator.pop(context),
                      icon: const Icon(Icons.arrow_back_rounded),
                      color: Colors.white,
                      iconSize: 28,
                    ),
                  ),

                  SizedBox(height: size.height * 0.02),

                  // Logo & Title
                  Column(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.2),
                              blurRadius: 30,
                              spreadRadius: 5,
                            ),
                          ],
                        ),
                        child: Icon(
                          _developerData['icon'],
                          size: 56,
                          color: color,
                        ),
                      ),
                      const SizedBox(height: 24),
                      const Text(
                        'Verifikasi Admin',
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.w900,
                          color: Colors.white,
                          letterSpacing: -0.5,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        _statusMessage,
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: Colors.white70,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),

                  SizedBox(height: size.height * 0.04),

                  // Progress Card
                  Container(
                    padding: const EdgeInsets.all(24),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(24),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 30,
                          spreadRadius: 5,
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        // Progress Info
                        Text(
                          'Langkah 4 dari 4',
                          style: TextStyle(
                            fontSize: 14,
                            color: color,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 8),
                        const Text(
                          'Final Verification',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.black87,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 16),

                        // Status Icon
                        AnimatedContainer(
                          duration: const Duration(milliseconds: 500),
                          width: 80,
                          height: 80,
                          decoration: BoxDecoration(
                            color: _getStatusColor().withOpacity(0.1),
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            _getStatusIcon(),
                            size: 40,
                            color: _getStatusColor(),
                          ),
                        ),
                        const SizedBox(height: 16),

                        Text(
                          _getStatusTitle(),
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                            color: _getStatusColor(),
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 8),
                        Text(
                          _statusMessage,
                          style: const TextStyle(
                            fontSize: 14,
                            color: Colors.black54,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),

                  SizedBox(height: size.height * 0.04),

                  // Verification Steps
                  Container(
                    padding: const EdgeInsets.all(24),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(24),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 30,
                          spreadRadius: 5,
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Proses Verifikasi',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                            color: Colors.black87,
                          ),
                        ),
                        const SizedBox(height: 4),
                        const Text(
                          'Status lengkap verifikasi akun Anda',
                          style: TextStyle(fontSize: 14, color: Colors.black54),
                        ),
                        const SizedBox(height: 20),

                        _buildStatusItem(
                          'Dokumen Perusahaan',
                          _status.index >= 1,
                        ),
                        _buildDivider(),
                        _buildStatusItem(
                          'Wallet Connection',
                          _status.index >= 2,
                        ),
                        _buildDivider(),
                        _buildStatusItem(
                          'KYC Verification',
                          _status.index >= 3,
                        ),
                        _buildDivider(),
                        _buildStatusItem(
                          'Admin Approval',
                          _status == VerificationStatus.approved,
                        ),
                      ],
                    ),
                  ),

                  SizedBox(height: size.height * 0.04),

                  // Additional Info
                  if (_status == VerificationStatus.pending) ...[
                    Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(24),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            blurRadius: 30,
                            spreadRadius: 5,
                          ),
                        ],
                      ),
                      child: Column(
                        children: [
                          Icon(
                            Icons.info_outline_rounded,
                            color: color,
                            size: 32,
                          ),
                          const SizedBox(height: 12),
                          const Text(
                            'Proses verifikasi biasanya memakan waktu 1-2 hari kerja. '
                            'Anda akan mendapatkan notifikasi ketika verifikasi selesai.',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.black54,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 24),
                  ],

                  // Action Buttons
                  Row(
                    children: [
                      // Back Button
                      Expanded(
                        child: SizedBox(
                          height: 56,
                          child: OutlinedButton(
                            onPressed: () => Navigator.pop(context),
                            style: OutlinedButton.styleFrom(
                              foregroundColor: Colors.white,
                              side: const BorderSide(color: Colors.white),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16),
                              ),
                            ),
                            child: const Text(
                              'Kembali',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 16),
                      // Continue Button
                      Expanded(
                        child: SizedBox(
                          height: 56,
                          child: ElevatedButton(
                            onPressed: _status == VerificationStatus.approved
                                ? _navigateToDashboard
                                : null,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: color,
                              foregroundColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16),
                              ),
                              elevation: 8,
                              shadowColor: color.withOpacity(0.4),
                            ),
                            child: Text(
                              _status == VerificationStatus.approved
                                  ? 'Masuk Dashboard'
                                  : 'Menunggu...',
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w700,
                                letterSpacing: 0.5,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),

                  // Retry Button for rejected status
                  if (_status == VerificationStatus.rejected) ...[
                    const SizedBox(height: 16),
                    SizedBox(
                      width: double.infinity,
                      height: 56,
                      child: OutlinedButton(
                        onPressed: _canRetry ? _retryVerification : null,
                        style: OutlinedButton.styleFrom(
                          foregroundColor: Colors.red,
                          side: const BorderSide(color: Colors.red),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                        ),
                        child: const Text(
                          'Coba Lagi',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ),
                  ],

                  const SizedBox(height: 30),

                  // Footer
                  Text(
                    _status == VerificationStatus.approved
                        ? 'Selamat! Akun Anda sudah aktif\nMulai jelajahi fitur developer'
                        : 'Tim admin akan memverifikasi data Anda\ndalam 1-2 hari kerja',
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: Colors.white70,
                      height: 1.5,
                    ),
                  ),

                  const SizedBox(height: 30),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildStatusItem(String text, bool isCompleted) {
    return Row(
      children: [
        Icon(
          isCompleted ? Icons.check_circle : Icons.radio_button_unchecked,
          color: isCompleted ? Colors.green[600] : Colors.grey[400],
          size: 24,
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Text(
            text,
            style: TextStyle(
              fontSize: 16,
              fontWeight: isCompleted ? FontWeight.w600 : FontWeight.w400,
              color: isCompleted ? Colors.black87 : Colors.grey[600],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildDivider() {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 12),
      height: 1,
      color: Colors.grey[200],
    );
  }

  Color _getStatusColor() {
    switch (_status) {
      case VerificationStatus.pending:
        return Colors.orange;
      case VerificationStatus.approved:
        return Colors.green;
      case VerificationStatus.rejected:
        return Colors.red;
    }
  }

  IconData _getStatusIcon() {
    switch (_status) {
      case VerificationStatus.pending:
        return Icons.pending_actions_rounded;
      case VerificationStatus.approved:
        return Icons.verified_user_rounded;
      case VerificationStatus.rejected:
        return Icons.error_outline_rounded;
    }
  }

  String _getStatusTitle() {
    switch (_status) {
      case VerificationStatus.pending:
        return 'Sedang Diproses';
      case VerificationStatus.approved:
        return 'Verifikasi Berhasil';
      case VerificationStatus.rejected:
        return 'Verifikasi Ditolak';
    }
  }

  void _showRejectionDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Alasan Penolakan'),
        content: const Text(
          'Dokumen yang diupload tidak memenuhi syarat:\n'
          '- Foto KTP tidak jelas\n'
          '- NPWP tidak valid\n'
          '- Dokumen perusahaan sudah expired',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Tutup'),
          ),
        ],
      ),
    );
  }
}

enum VerificationStatus { pending, approved, rejected }
