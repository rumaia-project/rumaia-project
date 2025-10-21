// [file name]: property_list.dart
import 'package:flutter/material.dart';

import 'detail_property_screen.dart';

class PropertyListScreen extends StatelessWidget {
  const PropertyListScreen({super.key});

  // Data property dari DashboardProperty dengan gambar network
  final List<Map<String, dynamic>> properties = const [
    {
      "name": "Cluster Bukit Asri",
      "price": "Rp 400.000.000",
      "location": "Bandung, Jawa Barat",
      "image":
          "https://images.unsplash.com/photo-1600585154340-be6161a56a0c?auto=format&fit=crop&w=800&q=60",
      "specs": "3 KT • 2 KM • 80 m²",
    },
    {
      "name": "Cluster Harmoni",
      "price": "Rp 600.000.000",
      "location": "Bogor, Jawa Barat",
      "image":
          "https://images.unsplash.com/photo-1570129477492-45c003edd2be?auto=format&fit=crop&w=800&q=60",
      "specs": "4 KT • 3 KM • 120 m²",
    },
    {
      "name": "Cluster Alam Hijau",
      "price": "Rp 750.000.000",
      "location": "Bekasi, Jawa Barat",
      "image":
          "https://images.unsplash.com/photo-1600607687939-ce8a6c25118c?auto=format&fit=crop&w=800&q=60",
      "specs": "4 KT • 3 KM • 150 m²",
    },
    {
      "name": "Rumah Modern Minimalis 2 Lantai",
      "price": "Rp 2.5 M",
      "location": "Jakarta Selatan, DKI Jakarta",
      "image":
          "https://images.unsplash.com/photo-1600047509807-ba8f99d2cdde?auto=format&fit=crop&w=800&q=60",
      "specs": "4 KT • 3 KM • 120 m²",
    },
    {
      "name": "Rumah Siap Huni Cluster Exclusive",
      "price": "Rp 1.8 M",
      "location": "BSD, Tangerang",
      "image":
          "https://images.unsplash.com/photo-1600596542815-ffad4c1539a9?auto=format&fit=crop&w=800&q=60",
      "specs": "3 KT • 2 KM • 90 m²",
    },
    {
      "name": "Villa Modern dengan Kolam Renang",
      "price": "Rp 3.2 M",
      "location": "Bogor, Jawa Barat",
      "image":
          "https://images.unsplash.com/photo-1600566753190-17f0baa2a6c3?auto=format&fit=crop&w=800&q=60",
      "specs": "5 KT • 4 KM • 200 m²",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [_buildLogo(), const SizedBox(width: 2)],
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.notifications_none, color: Colors.grey[700]),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Search Bar
            Container(
              decoration: BoxDecoration(
                color: Colors.grey[50],
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.grey[300]!),
              ),
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'Cari lokasi, tipe rumah...',
                  hintStyle: TextStyle(color: Colors.grey[500]),
                  prefixIcon: Icon(Icons.search, color: Colors.grey),
                  border: InputBorder.none,
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 14,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 20),

            // Filter Section
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  _buildFilterChip('Semua Tipe', true),
                  const SizedBox(width: 8),
                  _buildFilterChip('Rumah', false),
                  const SizedBox(width: 8),
                  _buildFilterChip('Apartemen', false),
                  const SizedBox(width: 8),
                  _buildFilterChip('Villa', false),
                  const SizedBox(width: 8),
                  _buildFilterChip('Cluster', false),
                ],
              ),
            ),

            const SizedBox(height: 24),

            // Property Count
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Properti Tersedia',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey[800],
                  ),
                ),
                Text(
                  '${properties.length} properti',
                  style: TextStyle(color: Colors.grey[600], fontSize: 14),
                ),
              ],
            ),

            const SizedBox(height: 16),

            // Property List - Dinamis dari data properties
            Column(
              children: properties.map((property) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 16),
                  child: _buildPropertyCard(
                    context: context,
                    property: property,
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            DetailPropertyScreen(property: property),
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLogo() {
    try {
      return Container(
        height: 200,
        width: 150,
        alignment: Alignment.center,
        child: Image.asset(
          'assets/images/logo_3.png',
          height: 150,
          width: 150,
          fit: BoxFit.contain,
          errorBuilder: (context, error, stackTrace) {
            return Container(
              height: 32,
              width: 32,
              decoration: BoxDecoration(
                color: Colors.blue[800],
                shape: BoxShape.circle,
              ),
              child: Center(
                child: Text(
                  'R',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
              ),
            );
          },
        ),
      );
    } catch (e) {
      return Container(
        height: 40,
        width: 40,
        alignment: Alignment.center,
        child: Container(
          height: 32,
          width: 32,
          decoration: BoxDecoration(
            color: Colors.blue[800],
            shape: BoxShape.circle,
          ),
          child: Center(
            child: Text(
              'R',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 14,
              ),
            ),
          ),
        ),
      );
    }
  }

  Widget _buildFilterChip(String text, bool isSelected) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      decoration: BoxDecoration(
        color: isSelected ? const Color(0xFF1565C0) : Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: isSelected ? const Color(0xFF1565C0) : Colors.grey[300]!,
        ),
      ),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 12,
          color: isSelected ? Colors.white : Colors.grey[700],
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  Widget _buildPropertyCard({
    required BuildContext context,
    required Map<String, dynamic> property,
    required VoidCallback onTap,
  }) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Colors.grey[300]!),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Material(
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(16),
          child: InkWell(
            onTap: onTap,
            borderRadius: BorderRadius.circular(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Property Image - Menggunakan AspectRatio seperti AvailablePropertyScreen
                AspectRatio(
                  aspectRatio: 16 / 9,
                  child: ClipRRect(
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(16),
                      topRight: Radius.circular(16),
                    ),
                    child: Image.network(
                      property['image'],
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Container(
                          color: Colors.grey[200],
                          child: const Center(
                            child: Icon(
                              Icons.home_work_outlined,
                              color: Colors.grey,
                              size: 50,
                            ),
                          ),
                        );
                      },
                      loadingBuilder: (context, child, loadingProgress) {
                        if (loadingProgress == null) return child;
                        return Container(
                          color: Colors.grey[200],
                          child: const Center(
                            child: CircularProgressIndicator(
                              valueColor: AlwaysStoppedAnimation<Color>(
                                Color(0xFF1565C0),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),

                // Property Details
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Price
                      Text(
                        property['price'],
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF1565C0),
                        ),
                      ),

                      const SizedBox(height: 8),

                      // Title
                      Text(
                        property['name'],
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Colors.blueGrey,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),

                      const SizedBox(height: 8),

                      // Location
                      Row(
                        children: [
                          Icon(
                            Icons.location_on_outlined,
                            size: 16,
                            color: Colors.grey[500],
                          ),
                          const SizedBox(width: 4),
                          Expanded(
                            child: Text(
                              property['location'],
                              style: TextStyle(
                                color: Colors.grey[600],
                                fontSize: 14,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 8),

                      // Specifications
                      Text(
                        property['specs'],
                        style: TextStyle(color: Colors.grey[600], fontSize: 14),
                      ),

                      const SizedBox(height: 16),

                      // Action Button
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: onTap,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF1565C0),
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          child: const Text(
                            'Lihat Detail',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
