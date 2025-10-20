import 'package:flutter/material.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool isDarkMode = false;
  bool isNotificationEnabled = true;
  bool isAutoUpdate = true;
  bool useFingerprint = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: const Text(
          "Pengaturan",
          style: TextStyle(fontWeight: FontWeight.w600, color: Colors.black),
        ),
        centerTitle: true,
        elevation: 0.5,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _buildSectionTitle("Preferensi Aplikasi"),
          _buildSwitchTile(
            icon: Icons.dark_mode_outlined,
            title: "Mode Gelap",
            subtitle: "Ubah tampilan ke mode gelap",
            value: isDarkMode,
            onChanged: (v) => setState(() => isDarkMode = v),
          ),
          _buildSwitchTile(
            icon: Icons.notifications_active_outlined,
            title: "Notifikasi",
            subtitle: "Aktifkan pemberitahuan aplikasi",
            value: isNotificationEnabled,
            onChanged: (v) => setState(() => isNotificationEnabled = v),
          ),
          _buildSwitchTile(
            icon: Icons.system_update_outlined,
            title: "Pembaruan Otomatis",
            subtitle: "Perbarui aplikasi secara otomatis",
            value: isAutoUpdate,
            onChanged: (v) => setState(() => isAutoUpdate = v),
          ),

          const SizedBox(height: 28),
          _buildSectionTitle("Keamanan"),
          _buildSwitchTile(
            icon: Icons.fingerprint_outlined,
            title: "Gunakan Sidik Jari",
            subtitle: "Gunakan biometrik untuk keamanan",
            value: useFingerprint,
            onChanged: (v) => setState(() => useFingerprint = v),
          ),
          _buildActionTile(
            icon: Icons.lock_outline,
            title: "Ubah Kata Sandi",
            subtitle: "Perbarui kata sandi akun Anda",
            onTap: () {
              _showSnack("Fitur ubah kata sandi belum tersedia");
            },
          ),

          const SizedBox(height: 28),
          _buildSectionTitle("Tampilan & Bahasa"),
          _buildActionTile(
            icon: Icons.language_outlined,
            title: "Bahasa",
            subtitle: "Ganti bahasa aplikasi",
            onTap: () => _showSnack("Fitur ubah bahasa belum tersedia"),
          ),
          _buildActionTile(
            icon: Icons.format_size_outlined,
            title: "Ukuran Font",
            subtitle: "Atur ukuran teks aplikasi",
            onTap: () => _showSnack("Fitur ukuran font belum tersedia"),
          ),

          const SizedBox(height: 28),
          _buildSectionTitle("Tentang Aplikasi"),
          _buildActionTile(
            icon: Icons.info_outline,
            title: "Versi Aplikasi",
            subtitle: "Lihat versi dan detail aplikasi",
            onTap: () {
              showAboutDialog(
                context: context,
                applicationName: "Rumaia App",
                applicationVersion: "v1.0.0",
                applicationIcon: const Icon(Icons.home, color: Colors.blue),
                children: const [
                  Text(
                    "Rumaia adalah platform kolaboratif antara Developer, Investor, dan Customer "
                    "untuk menciptakan solusi properti yang transparan dan berkelanjutan.",
                  ),
                ],
              );
            },
          ),
          _buildActionTile(
            icon: Icons.policy_outlined,
            title: "Kebijakan Privasi",
            subtitle: "Baca kebijakan privasi aplikasi",
            onTap: () => _showSnack("Kebijakan privasi belum tersedia"),
          ),
        ],
      ),
    );
  }

  void _showSnack(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message), behavior: SnackBarBehavior.floating),
    );
  }

  Widget _buildSectionTitle(String title) => Padding(
    padding: const EdgeInsets.only(bottom: 8, top: 16),
    child: Text(
      title,
      style: const TextStyle(
        fontWeight: FontWeight.w700,
        fontSize: 15,
        color: Colors.black87,
      ),
    ),
  );

  Widget _buildSwitchTile({
    required IconData icon,
    required String title,
    String? subtitle,
    required bool value,
    required ValueChanged<bool> onChanged,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 4),
        leading: Icon(icon, color: Colors.black87),
        title: Text(
          title,
          style: const TextStyle(
            fontWeight: FontWeight.w500,
            color: Colors.black87,
          ),
        ),
        subtitle: subtitle != null
            ? Text(
                subtitle,
                style: const TextStyle(color: Colors.black54, fontSize: 13),
              )
            : null,
        trailing: Switch(
          value: value,
          onChanged: onChanged,
          activeThumbColor: Colors.black,
        ),
      ),
    );
  }

  Widget _buildActionTile({
    required IconData icon,
    required String title,
    String? subtitle,
    required VoidCallback onTap,
  }) {
    return InkWell(
      borderRadius: BorderRadius.circular(12),
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.grey.shade300),
        ),
        child: ListTile(
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 14,
            vertical: 4,
          ),
          leading: Icon(icon, color: Colors.black87),
          title: Text(
            title,
            style: const TextStyle(
              fontWeight: FontWeight.w500,
              color: Colors.black87,
            ),
          ),
          subtitle: subtitle != null
              ? Text(
                  subtitle,
                  style: const TextStyle(color: Colors.black54, fontSize: 13),
                )
              : null,
          trailing: const Icon(
            Icons.arrow_forward_ios_rounded,
            size: 16,
            color: Colors.grey,
          ),
        ),
      ),
    );
  }
}
