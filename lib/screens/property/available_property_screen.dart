import 'package:flutter/material.dart';

import 'property_detail_screen.dart';

class AvailablePropertyScreen extends StatelessWidget {
  const AvailablePropertyScreen({super.key});

  static const Color primaryTeal = Color(0xFF00BFA5);
  static const Color accentBlue = Color(0xFF007AFF);

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    final List<Map<String, dynamic>> properties = [
      {
        "name": "Cluster Bukit Asri",
        "price": "Rp 400.000.000",
        "location": "Depok, Jawa Barat",
        "image":
            "https://images.unsplash.com/photo-1600585154340-be6161a56a0c?auto=format&fit=crop&w=800&q=60",
      },
      {
        "name": "Cluster Harmoni",
        "price": "Rp 600.000.000",
        "location": "Bogor, Jawa Barat",
        "image":
            "https://images.unsplash.com/photo-1570129477492-45c003edd2be?auto=format&fit=crop&w=800&q=60",
      },
      {
        "name": "Cluster Alam Hijau",
        "price": "Rp 750.000.000",
        "location": "Bekasi, Jawa Barat",
        "image":
            "https://images.unsplash.com/photo-1600607687939-ce8a6c25118c?auto=format&fit=crop&w=800&q=60",
      },
    ];

    return Scaffold(
      backgroundColor: colorScheme.surfaceContainerLowest,
      appBar: AppBar(
        title: const Text('Properti Tersedia'),
        centerTitle: true,
        backgroundColor: colorScheme.surfaceContainer,
        elevation: 0,
      ),
      body: SafeArea(
        child: ListView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: properties.length,
          itemBuilder: (context, index) {
            final item = properties[index];
            return _buildPropertyCard(
              context,
              item,
              properties,
              index,
              colorScheme,
            );
          },
        ),
      ),
    );
  }

  // Widget Card Properti versi clean Material You
  Widget _buildPropertyCard(
    BuildContext context,
    Map<String, dynamic> item,
    List<Map<String, dynamic>> properties,
    int index,
    ColorScheme colorScheme,
  ) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      elevation: 1.5,
      color: colorScheme.surface,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => PropertyDetailScreen(
                properties: properties,
                initialIndex: index,
              ),
            ),
          );
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Gambar Properti
            AspectRatio(
              aspectRatio: 16 / 9,
              child: Image.network(
                item["image"],
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) => Container(
                  color: Colors.grey.shade200,
                  child: const Icon(
                    Icons.image_not_supported,
                    size: 40,
                    color: Colors.grey,
                  ),
                ),
              ),
            ),

            // Informasi Properti
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item["name"],
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.w600,
                      color: colorScheme.onSurface,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Row(
                    children: [
                      Icon(
                        Icons.location_on_outlined,
                        color: colorScheme.outline,
                        size: 18,
                      ),
                      const SizedBox(width: 4),
                      Expanded(
                        child: Text(
                          item["location"],
                          style: TextStyle(
                            color: colorScheme.onSurfaceVariant,
                            fontSize: 13.5,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(
                    item["price"],
                    style: TextStyle(
                      color: colorScheme.primary,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
