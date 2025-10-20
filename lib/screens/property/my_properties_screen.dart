import 'package:flutter/material.dart';

/// 📦 Model Data Properti
class Property {
  final String id;
  final String title;
  final String location;
  final String imageAsset;
  final String status;
  final String value;
  final IconData statusIcon;
  final Color statusColor;

  Property({
    required this.id,
    required this.title,
    required this.location,
    required this.imageAsset,
    required this.status,
    required this.value,
    required this.statusIcon,
    required this.statusColor,
  });
}

class MyPropertiesScreen extends StatefulWidget {
  const MyPropertiesScreen({super.key});

  @override
  State<MyPropertiesScreen> createState() => _MyPropertiesScreenState();
}

class _MyPropertiesScreenState extends State<MyPropertiesScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  // Mock data untuk contoh
  final List<Property> ownedProperties = [
    Property(
      id: 'P001',
      title: 'Apartemen The Mansion',
      location: 'Jakarta Selatan, Indonesia',
      imageAsset: 'assets/images/property/apartemen-the-mansion.jpg',
      status: 'Dimiliki',
      value: 'Rp 2.8 Miliar',
      statusIcon: Icons.verified,
      statusColor: Colors.green,
    ),
    Property(
      id: 'P002',
      title: 'Rumah Cluster Emerald',
      location: 'Bekasi, Jawa Barat, Indonesia',
      imageAsset: 'assets/images/property/rumah-cluster-emerald.jpg',
      status: 'Dimiliki',
      value: 'Rp 1.25 Miliar',
      statusIcon: Icons.verified,
      statusColor: Colors.green,
    ),
  ];

  final List<Property> pendingProperties = [
    Property(
      id: 'P003',
      title: 'Kavling Tanah Siap Bangun',
      location: 'Bandung, Jawa Barat, Indonesia',
      imageAsset: 'assets/images/property/kavling-tanah-siap-bangun.jpg',
      status: 'Menunggu Verifikasi',
      value: 'Rp 550 Juta',
      statusIcon: Icons.pending,
      statusColor: Colors.orange,
    ),
    Property(
      id: 'P004',
      title: 'Ruko Komersil Sentra Niaga',
      location: 'Jababeka, Bekasi, Indonesia',
      imageAsset: 'assets/images/property/ruko-komersil-sentra-niaga.jpg',
      status: 'Menunggu Pembayaran',
      value: 'Rp 3.1 Miliar',
      statusIcon: Icons.payment,
      statusColor: Colors.redAccent,
    ),
  ];

  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  /// 📭 Tampilan kosong (empty state)
  Widget _buildEmptyState(String title, String description) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.home_work_outlined, size: 80, color: Colors.grey),
            const SizedBox(height: 16),
            Text(
              title,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w600,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              description,
              textAlign: TextAlign.center,
              style: const TextStyle(color: Colors.black54),
            ),
            const SizedBox(height: 24),
            OutlinedButton.icon(
              onPressed: () {},
              icon: const Icon(Icons.add_home_work, color: Colors.teal),
              label: const Text('Tambahkan Properti Baru'),
              style: OutlinedButton.styleFrom(
                side: const BorderSide(color: Colors.teal),
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 12,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// 🏠 Kartu Properti
  Widget _buildPropertyCard(Property property) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      color: const Color(0xFFF9FAFB),
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(color: Colors.grey.shade300),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: () {},
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(16),
              ),
              child: Image.asset(
                property.imageAsset,
                height: 180,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(14),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    property.title,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      const Icon(
                        Icons.location_on,
                        size: 16,
                        color: Colors.grey,
                      ),
                      const SizedBox(width: 4),
                      Expanded(
                        child: Text(
                          property.location,
                          style: const TextStyle(
                            fontSize: 13,
                            color: Colors.black54,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                  const Divider(height: 24),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "Nilai Properti",
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.black54,
                            ),
                          ),
                          Text(
                            property.value,
                            style: const TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              color: Colors.teal,
                            ),
                          ),
                        ],
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 5,
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: property.statusColor.withOpacity(0.1),
                          border: Border.all(
                            color: property.statusColor.withOpacity(0.3),
                          ),
                        ),
                        child: Row(
                          children: [
                            Icon(
                              property.statusIcon,
                              color: property.statusColor,
                              size: 16,
                            ),
                            const SizedBox(width: 6),
                            Text(
                              property.status,
                              style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w600,
                                color: property.statusColor,
                              ),
                            ),
                          ],
                        ),
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

  /// 🧱 Daftar properti (tab content)
  Widget _buildPropertyList(
    List<Property> data,
    String emptyTitle,
    String emptyDesc,
  ) {
    if (data.isEmpty) return _buildEmptyState(emptyTitle, emptyDesc);
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: data.length,
      itemBuilder: (_, i) => _buildPropertyCard(data[i]),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F6F7),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          "Properti Saya",
          style: TextStyle(color: Colors.black87, fontWeight: FontWeight.w600),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black87),
          onPressed: () => Navigator.pop(context),
        ),
        bottom: TabBar(
          controller: _tabController,
          labelColor: Colors.teal,
          unselectedLabelColor: Colors.grey,
          indicatorColor: Colors.teal,
          indicatorWeight: 3,
          tabs: const [
            Tab(text: "Dimiliki", icon: Icon(Icons.apartment_outlined)),
            Tab(text: "Pengajuan", icon: Icon(Icons.list_alt_outlined)),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildPropertyList(
            ownedProperties,
            "Belum Ada Properti",
            "Tambahkan properti Anda untuk memulai daftar kepemilikan.",
          ),
          _buildPropertyList(
            pendingProperties,
            "Tidak Ada Pengajuan",
            "Semua pengajuan properti Anda akan muncul di sini.",
          ),
        ],
      ),
    );
  }
}
