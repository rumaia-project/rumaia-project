import 'package:flutter/material.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text(
          'Tentang Kami',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.w600),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0.5,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 40),

            // 🔹 Logo minimalis
            Container(
              width: 96,
              height: 96,
              decoration: BoxDecoration(
                color: Colors.grey.shade200,
                borderRadius: BorderRadius.circular(48),
                border: Border.all(color: Colors.grey.shade300),
              ),
              child: const Icon(
                Icons.home_work_outlined,
                color: Colors.black87,
                size: 42,
              ),
            ),

            const SizedBox(height: 24),
            const Text(
              "Rumaia Project",
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.black,
                letterSpacing: 0.3,
              ),
            ),
            const SizedBox(height: 4),
            const Text(
              "Versi 1.0.0",
              style: TextStyle(color: Colors.black54, fontSize: 14),
            ),

            const SizedBox(height: 28),
            const Text(
              "Rumaia Project adalah platform yang mempermudah Anda dalam mencari, "
              "mengajukan, dan berinvestasi pada properti terpercaya. "
              "Kami berkomitmen menghadirkan pengalaman yang aman, transparan, dan inovatif.",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.black87,
                height: 1.6,
                fontSize: 15,
              ),
            ),

            const SizedBox(height: 36),

            // 🔹 Info tim pengembang
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(14),
                border: Border.all(color: Colors.grey.shade300),
              ),
              child: Column(
                children: [
                  const Icon(
                    Icons.people_outline,
                    size: 40,
                    color: Colors.black87,
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    "Dikembangkan oleh Tim Rumaia",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 6),
                  const Text(
                    "Kami adalah tim pengembang muda yang berfokus pada "
                    "solusi digital di bidang properti dan investasi.",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.black54,
                      fontSize: 14,
                      height: 1.5,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 40),

            // 🔹 Tombol ke pusat bantuan
            OutlinedButton.icon(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text("Menuju halaman pusat bantuan..."),
                  ),
                );
              },
              icon: const Icon(Icons.help_outline, color: Colors.black),
              label: const Text(
                "Pusat Bantuan",
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w500,
                ),
              ),
              style: OutlinedButton.styleFrom(
                side: BorderSide(color: Colors.grey.shade400),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 14,
                ),
              ),
            ),

            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
}
