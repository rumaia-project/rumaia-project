import 'package:flutter/material.dart';

import 'detail_property_screen.dart';

class PropertyListScreen extends StatelessWidget {
  const PropertyListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Properti Tersedia')),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              decoration: InputDecoration(
                hintText: 'Cari lokasi atau nama properti...',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),
            Align(
              alignment: Alignment.centerLeft,
              child: Text('Menampilkan 6 properti'),
            ),
            Expanded(
              child: ListView(
                children: [
                  PropertyCard(
                    price: 'Rp 2.5 M',
                    title: 'Rumah Modern Minimalis 2 Lantai',
                    location: 'Jakarta Selatan, DKI Jakarta',
                    specs: '4 KT • 3 KM • 120 m²',
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DetailPropertyScreen(),
                      ),
                    ),
                  ),
                  PropertyCard(
                    price: 'Rp 1.8 M',
                    title: 'Rumah Siap Huni Cluster Exclusive',
                    location: 'BSD, Tangerang',
                    specs: '3 KT • 2 KM • 90 m²',
                    onTap: () {},
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

class PropertyCard extends StatelessWidget {
  final String price;
  final String title;
  final String location;
  final String specs;
  final VoidCallback onTap;

  const PropertyCard({
    super.key,
    required this.price,
    required this.title,
    required this.location,
    required this.specs,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                price,
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              Text(title),
              SizedBox(height: 4),
              Text(location),
              SizedBox(height: 4),
              Text(specs),
              SizedBox(height: 8),
              ElevatedButton(onPressed: onTap, child: Text('Lihat Detail')),
            ],
          ),
        ),
      ),
    );
  }
}
