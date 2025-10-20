import 'package:flutter/material.dart';

// Import screens
import 'available_property_screen.dart';
import 'my_properties_screen.dart';
import 'property_completion_screen.dart';
import 'rent_property_screen.dart';
import 'sale_property_screen.dart';

class PropertyHomeScreen extends StatelessWidget {
  const PropertyHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> menuItems = [
      {
        "title": "Properti Tersedia",
        "subtitle": "Lihat daftar properti, unit, dan proyek terbaru",
        "icon": Icons.home_work_outlined,
        "page": const AvailablePropertyScreen(),
      },
      {
        "title": "Properti Saya",
        "subtitle": "Kelola listing properti yang Anda miliki atau sewa",
        "icon": Icons.folder_shared_outlined,
        "page": const MyPropertiesScreen(),
      },
      {
        "title": "Jual Properti",
        "subtitle": "Ajukan listing properti untuk dijual",
        "icon": Icons.sell_outlined,
        "page": const SalePropertyScreen(),
      },
      {
        "title": "Sewa Properti",
        "subtitle": "Cari properti untuk disewa jangka pendek atau panjang",
        "icon": Icons.apartment_outlined,
        "page": const RentPropertyScreen(),
      },
      {
        "title": "Progres Proyek",
        "subtitle": "Pantau status penyelesaian proyek pembangunan Anda",
        "icon": Icons.check_circle_outline,
        "page": const PropertyCompletionScreen(),
      },
    ];

    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text(
          "Pusat Properti",
          style: TextStyle(
            fontWeight: FontWeight.w600,
            color: Colors.black,
            letterSpacing: 0.3,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0.5,
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.fromLTRB(20, 12, 20, 24),
          children: [
            const SizedBox(height: 12),
            const Text(
              "Manajemen Properti",
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 6),
            const Text(
              "Pilih salah satu modul di bawah ini untuk memulai pengelolaan atau transaksi properti Anda.",
              style: TextStyle(
                color: Colors.black54,
                fontSize: 14.5,
                height: 1.5,
              ),
            ),
            const SizedBox(height: 28),

            // 🔹 Menu list
            ...menuItems.map((item) => _buildMenuCard(context, item)),
          ],
        ),
      ),
    );
  }

  Widget _buildMenuCard(BuildContext context, Map<String, dynamic> item) {
    return Container(
      margin: const EdgeInsets.only(bottom: 14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(14),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => item["page"]),
          );
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          child: Row(
            children: [
              // Icon Box
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.grey.shade200,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(item["icon"], size: 24, color: Colors.black87),
              ),
              const SizedBox(width: 16),

              // Texts
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      item["title"],
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(height: 3),
                    Text(
                      item["subtitle"],
                      style: const TextStyle(
                        fontSize: 13.5,
                        color: Colors.black54,
                        height: 1.4,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),

              const SizedBox(width: 10),
              const Icon(
                Icons.arrow_forward_ios_rounded,
                size: 16,
                color: Colors.black45,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
