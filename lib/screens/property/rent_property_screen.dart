import 'package:flutter/material.dart';

// --- Model Data Properti Sewa ---
class RentalProperty {
  final String id;
  final String title;
  final String location;
  final String imageUrl; // bisa lokal (assets/...) atau URL
  final String pricePerMonth;
  final int bedrooms;
  final int bathrooms;

  RentalProperty({
    required this.id,
    required this.title,
    required this.location,
    required this.imageUrl,
    required this.pricePerMonth,
    required this.bedrooms,
    required this.bathrooms,
  });
}

// --- Halaman Utama Sewa Properti ---
class RentPropertyScreen extends StatefulWidget {
  const RentPropertyScreen({super.key});

  @override
  State<RentPropertyScreen> createState() => _RentPropertyScreenState();
}

class _RentPropertyScreenState extends State<RentPropertyScreen> {
  String? _selectedFilter;

  final List<RentalProperty> recommendedRentals = [
    RentalProperty(
      id: 'R001',
      title: 'Studio Apartemen Modern',
      location: 'Kuningan, Jakarta Selatan',
      imageUrl: 'assets/images/property/studio-apartemen-modern.jpeg',
      pricePerMonth: 'Rp 4.5 Jt/Bulan',
      bedrooms: 1,
      bathrooms: 1,
    ),
    RentalProperty(
      id: 'R002',
      title: 'Rumah Keluarga Minimalis',
      location: 'BSD City, Tangerang',
      imageUrl: 'assets/images/property/rumah-keluarga-minimalis.jpg',
      pricePerMonth: 'Rp 12 Jt/Bulan',
      bedrooms: 3,
      bathrooms: 2,
    ),
    RentalProperty(
      id: 'R003',
      title: 'Kamar Kost Eksklusif',
      location: 'Sekitar Kampus ITB, Bandung',
      imageUrl: 'assets/images/property/kamar-kost-eksklusif.jpg',
      pricePerMonth: 'Rp 1.8 Jt/Bulan',
      bedrooms: 1,
      bathrooms: 1,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      backgroundColor: colorScheme.surface,
      appBar: AppBar(
        title: const Text('Properti Sewa'),
        centerTitle: true,
        elevation: 0,
        backgroundColor: colorScheme.surface,
        surfaceTintColor: Colors.transparent,
        scrolledUnderElevation: 0,
      ),
      body: CustomScrollView(
        slivers: [
          SliverPadding(
            padding: const EdgeInsets.all(16.0),
            sliver: SliverList(
              delegate: SliverChildListDelegate([
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Cari lokasi atau jenis properti...',
                    prefixIcon: Icon(Icons.search, color: colorScheme.outline),
                    filled: true,
                    fillColor: colorScheme.surfaceContainerHighest,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: BorderSide.none,
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                      vertical: 16.0,
                      horizontal: 10.0,
                    ),
                  ),
                  onFieldSubmitted: (value) {},
                ),
                const SizedBox(height: 12),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      _buildFilterChip(context, 'Apartemen'),
                      _buildFilterChip(context, 'Rumah'),
                      _buildFilterChip(context, 'Kost & Kontrakan'),
                      _buildFilterChip(context, '< Rp 5 Jt'),
                      _buildFilterChip(context, 'Furnished'),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                Text(
                  'Rekomendasi Untuk Anda',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                    color: colorScheme.onSurface,
                  ),
                ),
                const SizedBox(height: 8),
              ]),
            ),
          ),

          // --- Daftar Properti ---
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            sliver: SliverList.builder(
              itemCount: recommendedRentals.length,
              itemBuilder: (context, index) {
                return _buildRentalCard(context, recommendedRentals[index]);
              },
            ),
          ),
          const SliverToBoxAdapter(child: SizedBox(height: 20)),
        ],
      ),
    );
  }

  Widget _buildFilterChip(BuildContext context, String label) {
    final colorScheme = Theme.of(context).colorScheme;
    final isSelected = _selectedFilter == label;

    return Padding(
      padding: const EdgeInsets.only(right: 8.0),
      child: FilterChip(
        label: Text(label),
        selected: isSelected,
        onSelected: (selected) {
          setState(() => _selectedFilter = selected ? label : null);
        },
        showCheckmark: false,
        labelStyle: TextStyle(
          color: isSelected ? Colors.white : colorScheme.onSurfaceVariant,
          fontWeight: FontWeight.w500,
        ),
        backgroundColor: colorScheme.surfaceContainerHighest,
        selectedColor: colorScheme.primary,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
      ),
    );
  }

  // --- Widget Kartu Properti ---
  Widget _buildRentalCard(BuildContext context, RentalProperty property) {
    final colorScheme = Theme.of(context).colorScheme;

    return Card(
      elevation: 0,
      margin: const EdgeInsets.only(bottom: 16),
      color: colorScheme.surfaceContainerHighest,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      clipBehavior: Clip.hardEdge,
      child: InkWell(
        onTap: () {},
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AspectRatio(
              aspectRatio: 16 / 9,
              child: _buildImage(property.imageUrl, colorScheme),
            ),
            Padding(
              padding: const EdgeInsets.all(14.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    property.pricePerMonth,
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                      color: colorScheme.primary,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    property.title,
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      color: colorScheme.onSurface,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 6),
                  Row(
                    children: [
                      Icon(
                        Icons.location_on_outlined,
                        size: 16,
                        color: colorScheme.outline,
                      ),
                      const SizedBox(width: 4),
                      Expanded(
                        child: Text(
                          property.location,
                          style: TextStyle(
                            fontSize: 13,
                            color: colorScheme.outline,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      _buildDetail(
                        context,
                        Icons.bed,
                        '${property.bedrooms} KT',
                      ),
                      const SizedBox(width: 12),
                      _buildDetail(
                        context,
                        Icons.bathtub,
                        '${property.bathrooms} KM',
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// 🔄 Fungsi deteksi otomatis gambar lokal atau URL
  Widget _buildImage(String imageUrl, ColorScheme colorScheme) {
    final isLocal = imageUrl.startsWith('assets/');

    if (isLocal) {
      return Image.asset(
        imageUrl,
        fit: BoxFit.cover,
        errorBuilder: (_, __, ___) => Container(
          color: colorScheme.surfaceContainerHighest,
          child: const Icon(Icons.broken_image, size: 50),
        ),
      );
    } else {
      return Image.network(
        imageUrl,
        fit: BoxFit.cover,
        errorBuilder: (_, __, ___) => Container(
          color: colorScheme.surfaceContainerHighest,
          child: const Icon(Icons.image_not_supported, size: 50),
        ),
      );
    }
  }

  Widget _buildDetail(BuildContext context, IconData icon, String text) {
    final colorScheme = Theme.of(context).colorScheme;
    return Row(
      children: [
        Icon(icon, size: 16, color: colorScheme.primary),
        const SizedBox(width: 4),
        Text(
          text,
          style: TextStyle(fontSize: 13, color: colorScheme.onSurfaceVariant),
        ),
      ],
    );
  }
}
