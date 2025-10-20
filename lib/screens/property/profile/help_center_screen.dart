import 'package:flutter/material.dart';

class HelpCenterScreen extends StatelessWidget {
  const HelpCenterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text(
          "Pusat Bantuan",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.w600),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0.5,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const Text(
            "FAQ (Pertanyaan Umum)",
            style: TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.w600,
              color: Colors.black,
            ),
          ),
          const SizedBox(height: 16),
          ..._faqs.map((faq) => _faqItem(faq["question"]!, faq["answer"]!)),
          const SizedBox(height: 28),
          const Divider(height: 32, color: Colors.black12),
          const SizedBox(height: 12),
          const Text(
            "Masih butuh bantuan?",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 16,
              color: Colors.black,
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            "Tim dukungan kami siap membantu Anda setiap hari kerja pukul 08.00 - 17.00 WIB.",
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.black54, fontSize: 13.5),
          ),
          const SizedBox(height: 20),
          _contactButtons(context),
        ],
      ),
    );
  }

  Widget _faqItem(String question, String answer) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(12),
      ),
      child: ExpansionTile(
        tilePadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
        childrenPadding: const EdgeInsets.fromLTRB(16, 0, 16, 12),
        iconColor: Colors.black87,
        collapsedIconColor: Colors.black54,
        title: Text(
          question,
          style: const TextStyle(
            fontWeight: FontWeight.w500,
            color: Colors.black87,
            fontSize: 15,
          ),
        ),
        children: [
          Text(
            answer,
            style: const TextStyle(
              color: Colors.black54,
              height: 1.5,
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }

  Widget _contactButtons(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _outlinedBtn(
          icon: Icons.email_outlined,
          label: "Email Kami",
          color: Colors.black,
          onTap: () {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text("Membuka email bantuan...")),
            );
          },
        ),
        const SizedBox(width: 12),
        _outlinedBtn(
          icon: Icons.chat_outlined,
          label: "Chat WhatsApp",
          color: Colors.green,
          onTap: () {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text("Menghubungkan ke WhatsApp...")),
            );
          },
        ),
      ],
    );
  }

  Widget _outlinedBtn({
    required IconData icon,
    required String label,
    required Color color,
    required VoidCallback onTap,
  }) {
    return OutlinedButton.icon(
      onPressed: onTap,
      icon: Icon(icon, color: color, size: 20),
      label: Text(
        label,
        style: TextStyle(color: color, fontWeight: FontWeight.w500),
      ),
      style: OutlinedButton.styleFrom(
        side: BorderSide(color: color.withOpacity(0.8)),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
      ),
    );
  }

  static final List<Map<String, String>> _faqs = [
    {
      "question": "Bagaimana cara mengajukan permintaan properti?",
      "answer":
          "Masuk ke menu Properti > Ajukan Properti. Isi formulir permintaan dengan detail lokasi, ukuran, dan budget. Tim kami akan menghubungi Anda dalam 2x24 jam.",
    },
    {
      "question": "Bagaimana cara berinvestasi di proyek?",
      "answer":
          "Masuk sebagai Investor, lalu buka menu Investasi. Pilih proyek yang Anda minati dan lakukan simulasi investasi sebelum melakukan komitmen.",
    },
    {
      "question": "Bagaimana cara memverifikasi proyek developer?",
      "answer":
          "Proyek diverifikasi oleh tim Admin internal Rumaia berdasarkan dokumen legal dan progres konstruksi dari developer.",
    },
    {
      "question": "Apakah data pribadi saya aman?",
      "answer":
          "Ya, semua data pengguna disimpan secara terenkripsi dan hanya digunakan untuk keperluan verifikasi dan transaksi di dalam aplikasi.",
    },
  ];
}
