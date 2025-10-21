// [file name]: detail_property_screen.dart
import 'package:flutter/material.dart';

import 'property_purchase_screen.dart';

class DetailPropertyScreen extends StatelessWidget {
  final Map<String, dynamic> property;

  const DetailPropertyScreen({super.key, required this.property});

  // Data spesifikasi berdasarkan tipe properti
  Map<String, dynamic> get _propertyDetails {
    final name = property["name"].toLowerCase();
    if (name.contains("cluster bukit asri")) {
      return {
        "buildingArea": "80 m²",
        "landArea": "100 m²",
        "bedrooms": "3",
        "bathrooms": "2",
        "garage": "1 mobil",
        "floors": "1",
        "yearBuilt": "2023",
        "certificate": "SHM",
        "orientation": "Timur",
        "electricity": "2200 VA",
        "description":
            "Cluster perumahan dengan lingkungan asri dan nyaman. "
            "Dilengkapi dengan area bermain anak, jogging track, dan keamanan 24 jam. "
            "Cocok untuk keluarga muda yang menginginkan hunian terjangkau dengan fasilitas lengkap.",
        "facilities": ["Taman", "Playground", "Security 24/7", "Jogging Track"],
      };
    } else if (name.contains("cluster harmoni")) {
      return {
        "buildingArea": "120 m²",
        "landArea": "150 m²",
        "bedrooms": "4",
        "bathrooms": "3",
        "garage": "2 mobil",
        "floors": "2",
        "yearBuilt": "2024",
        "certificate": "SHM",
        "orientation": "Selatan",
        "electricity": "4400 VA",
        "description":
            "Rumah mewah dengan desain modern dan fasilitas premium. "
            "Lokasi strategis dekat dengan pusat kota dan akses transportasi yang mudah. "
            "Dilengkapi dengan smart home system dan material bangunan berkualitas tinggi.",
        "facilities": ["Smart Home", "Garden", "Carport", "Security System"],
      };
    } else if (name.contains("cluster alam hijau")) {
      return {
        "buildingArea": "150 m²",
        "landArea": "200 m²",
        "bedrooms": "4",
        "bathrooms": "3",
        "garage": "2 mobil",
        "floors": "1",
        "yearBuilt": "2023",
        "certificate": "SHM",
        "orientation": "Barat",
        "electricity": "3300 VA",
        "description":
            "Villa modern dengan konsep green living dan lingkungan yang hijau. "
            "Desain arsitektur tropis yang nyaman dengan ventilasi alami. "
            "Cocok untuk Anda yang menginginkan ketenangan dan kenyamanan hidup.",
        "facilities": ["Swimming Pool", "Garden", "Parking Area", "Green Area"],
      };
    } else {
      return {
        "buildingArea": "120 m²",
        "landArea": "180 m²",
        "bedrooms": "4",
        "bathrooms": "3",
        "garage": "2 mobil",
        "floors": "2",
        "yearBuilt": "2024",
        "certificate": "SHM",
        "orientation": "Utara",
        "electricity": "4400 VA",
        "description":
            "Rumah modern dengan desain elegan dan fasilitas lengkap. "
            "Terletak di lokasi strategis dengan akses mudah ke pusat kota. "
            "Dilengkapi dengan taman, garasi, dan keamanan 24 jam.",
        "facilities": ["Security 24/7", "Garden", "Garage", "Modern Design"],
      };
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          'Detail Properti',
          style: TextStyle(
            color: Colors.grey[800],
            fontWeight: FontWeight.bold,
          ),
        ),
        iconTheme: IconThemeData(color: Colors.grey[700]),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Property Image
            Container(
              height: 250,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16),
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
                          size: 60,
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

            const SizedBox(height: 20),

            // Price
            Text(
              property['price'],
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Colors.grey[800],
              ),
            ),

            const SizedBox(height: 12),

            // Title
            Text(
              property['name'],
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: Colors.grey[800],
              ),
            ),

            const SizedBox(height: 8),

            // Location
            Row(
              children: [
                Icon(
                  Icons.location_on_outlined,
                  size: 18,
                  color: Colors.grey[600],
                ),
                const SizedBox(width: 6),
                Text(
                  property['location'],
                  style: TextStyle(fontSize: 16, color: Colors.grey[600]),
                ),
              ],
            ),

            const SizedBox(height: 8),

            // Quick Specs
            Text(
              property['specs'],
              style: TextStyle(fontSize: 16, color: Colors.grey[600]),
            ),

            const SizedBox(height: 20),

            // Description Section
            _buildDescriptionSection(),

            const SizedBox(height: 24),

            // Detailed Specifications - FIXED: Changed title and fixed overflow
            _buildPropertySpecifications(),

            const SizedBox(height: 24),

            // Facilities Section
            _buildFacilitiesSection(),

            const SizedBox(height: 30),

            // Action Buttons - FIXED: Better icon color
            _buildActionButtons(context),
          ],
        ),
      ),
    );
  }

  Widget _buildDescriptionSection() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey[300]!),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.description_outlined,
                color: Colors.grey[700],
                size: 20,
              ),
              const SizedBox(width: 8),
              Text(
                'Deskripsi Properti',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey[800],
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            _propertyDetails["description"],
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey[600],
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPropertySpecifications() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey[300]!),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.architecture_outlined,
                color: Colors.grey[700],
                size: 20,
              ),
              const SizedBox(width: 8),
              Text(
                'Spesifikasi Properti', // Changed from 'Spesifikasi Teknis'
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey[800],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),

          // Grid Layout untuk spesifikasi - FIXED: Better layout to prevent overflow
          GridView.count(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            crossAxisCount: 2,
            crossAxisSpacing: 8, // Reduced spacing
            mainAxisSpacing: 8, // Reduced spacing
            childAspectRatio: 2.8, // Adjusted aspect ratio
            children: [
              _buildSpecCard(
                'Luas Bangunan',
                _propertyDetails["buildingArea"],
                Icons.square_foot,
              ),
              _buildSpecCard(
                'Luas Tanah',
                _propertyDetails["landArea"],
                Icons.landscape,
              ),
              _buildSpecCard(
                'Kamar Tidur',
                _propertyDetails["bedrooms"],
                Icons.bed,
              ),
              _buildSpecCard(
                'Kamar Mandi',
                _propertyDetails["bathrooms"],
                Icons.bathtub,
              ),
              _buildSpecCard(
                'Garasi',
                _propertyDetails["garage"],
                Icons.local_parking,
              ),
              _buildSpecCard(
                'Lantai',
                _propertyDetails["floors"],
                Icons.layers,
              ),
              _buildSpecCard(
                'Tahun Bangun',
                _propertyDetails["yearBuilt"],
                Icons.calendar_today,
              ),
              _buildSpecCard(
                'Sertifikat',
                _propertyDetails["certificate"],
                Icons.description,
              ),
            ],
          ),

          const SizedBox(height: 12), // Reduced spacing
          // Additional Specifications - FIXED: Removed Row to prevent overflow
          GridView.count(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            crossAxisCount: 2,
            crossAxisSpacing: 8,
            mainAxisSpacing: 8,
            childAspectRatio: 2.8,
            children: [
              _buildSpecCard(
                'Orientasi',
                _propertyDetails["orientation"],
                Icons.explore,
              ),
              _buildSpecCard(
                'Daya Listrik',
                _propertyDetails["electricity"],
                Icons.bolt,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSpecCard(String title, String value, IconData icon) {
    return Container(
      padding: const EdgeInsets.all(10), // Reduced padding
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey[300]!),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(5), // Reduced padding
            decoration: BoxDecoration(
              color: const Color(0xFF1565C0).withOpacity(0.1),
              borderRadius: BorderRadius.circular(6),
            ),
            child: Icon(
              icon,
              size: 14,
              color: const Color(0xFF1565C0),
            ), // Smaller icon
          ),
          const SizedBox(width: 6), // Reduced spacing
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 11, // Smaller font
                    color: Colors.grey[600],
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 2),
                Text(
                  value,
                  style: TextStyle(
                    fontSize: 12, // Smaller font
                    fontWeight: FontWeight.w600,
                    color: Colors.grey[800],
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFacilitiesSection() {
    final facilities = _propertyDetails["facilities"] as List<String>;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey[300]!),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.emoji_objects_outlined,
                color: Colors.grey[700],
                size: 20,
              ),
              const SizedBox(width: 8),
              Text(
                'Fasilitas',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey[800],
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: facilities.map((facility) {
              return Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: const Color(0xFF1565C0).withOpacity(0.3),
                  ),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.check_circle,
                      size: 14,
                      color: const Color(0xFF1565C0),
                    ),
                    const SizedBox(width: 4),
                    Text(
                      facility,
                      style: const TextStyle(
                        fontSize: 12,
                        color: Color(0xFF1565C0),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildActionButtons(BuildContext context) {
    return Column(
      children: [
        // Tombol Pesan Properti - FIXED: Better icon color
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      PropertyPurchaseScreen(property: property),
                ),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF1565C0),
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              elevation: 2,
            ),
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.shopping_cart_checkout,
                  size: 20,
                  color: Colors.white, // FIXED: White icon to match button
                ),
                SizedBox(width: 8),
                Text(
                  'Pesan Properti',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        ),

        const SizedBox(height: 12),

        // Tombol Tambahan
        Row(
          children: [
            Expanded(
              child: OutlinedButton.icon(
                onPressed: () {
                  _showContactInfo(context);
                },
                style: OutlinedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  side: BorderSide(color: Colors.grey[300]!),
                ),
                icon: Icon(Icons.phone, color: Colors.grey[700], size: 18),
                label: Text(
                  'Hubungi Agen',
                  style: TextStyle(
                    color: Colors.grey[700],
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: OutlinedButton.icon(
                onPressed: () {
                  _showLocationInfo(context);
                },
                style: OutlinedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  side: BorderSide(color: Colors.grey[300]!),
                ),
                icon: Icon(
                  Icons.location_on,
                  color: Colors.grey[700],
                  size: 18,
                ),
                label: Text(
                  'Lihat Lokasi',
                  style: TextStyle(
                    color: Colors.grey[700],
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  void _showContactInfo(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Row(
          children: [
            Icon(Icons.phone, color: Color(0xFF1565C0)),
            SizedBox(width: 8),
            Text('Informasi Kontak'),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Agen Properti Terkait:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            _buildContactItem('Nama', 'Budi Santoso'),
            _buildContactItem('Telepon', '+62 812-3456-7890'),
            _buildContactItem('Email', 'budi@rumaia.com'),
            _buildContactItem('Pengalaman', '5 Tahun'),
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.grey[50],
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                'Properti: ${property['name']}',
                style: const TextStyle(fontStyle: FontStyle.italic),
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Tutup'),
          ),
          FilledButton(
            onPressed: () {
              // Aksi telepon
              Navigator.pop(context);
            },
            child: const Text('Telepon Sekarang'),
          ),
        ],
      ),
    );
  }

  Widget _buildContactItem(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 80,
            child: Text(
              '$label:',
              style: TextStyle(
                fontWeight: FontWeight.w500,
                color: Colors.grey[600],
              ),
            ),
          ),
          Expanded(child: Text(value)),
        ],
      ),
    );
  }

  void _showLocationInfo(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Row(
          children: [
            Icon(Icons.location_on, color: Color(0xFF1565C0)),
            SizedBox(width: 8),
            Text('Lokasi Properti'),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              property['location'],
              style: const TextStyle(fontWeight: FontWeight.w500),
            ),
            const SizedBox(height: 12),
            Container(
              height: 150,
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(8),
                image: const DecorationImage(
                  image: NetworkImage(
                    'https://via.placeholder.com/300x150?text=Peta+Lokasi',
                  ),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(height: 12),
            const Text(
              'Lokasi strategis dengan akses mudah ke:',
              style: TextStyle(fontSize: 12, color: Colors.grey),
            ),
            const SizedBox(height: 4),
            _buildLocationFacility('🏪 Pusat Perbelanjaan', '5 menit'),
            _buildLocationFacility('🏥 Rumah Sakit', '10 menit'),
            _buildLocationFacility('🚉 Stasiun', '8 menit'),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Tutup'),
          ),
          FilledButton(
            onPressed: () {
              // Aksi untuk membuka Google Maps
              Navigator.pop(context);
            },
            child: const Text('Buka di Maps'),
          ),
        ],
      ),
    );
  }

  Widget _buildLocationFacility(String facility, String distance) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        children: [
          Expanded(child: Text(facility, style: const TextStyle(fontSize: 12))),
          Text(
            distance,
            style: TextStyle(fontSize: 12, color: Colors.grey[600]),
          ),
        ],
      ),
    );
  }
}
