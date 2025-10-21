// [file name]: detail_property_screen.dart
import 'package:flutter/material.dart';

import 'property_purchase_screen.dart'; // Import halaman pembelian

class DetailPropertyScreen extends StatelessWidget {
  const DetailPropertyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic> propertyData = {
      'title': 'Rumah Modern Minimalis 2 Lantai',
      'location': 'Jakarta Selatan, DKI Jakarta',
      'specs': '4 KT • 3 KM • 120 m²',
      'price': 'Rp 2.5 M',
    };

    return Scaffold(
      appBar: AppBar(title: Text('Detail Properti')),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset('assets/images/rumah_modern_min_2l.jpg'),
            SizedBox(height: 16),
            Text(
              'Rp 2.5 M',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text('Rumah Modern Minimalis 2 Lantai'),
            SizedBox(height: 8),
            Text('Jakarta Selatan, DKI Jakarta'),
            SizedBox(height: 8),
            Text('4 KT • 3 KM • 120 m²'),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        PropertyPurchaseScreen(property: propertyData),
                  ),
                );
              },
              child: Text('Ajukan Pembelian'),
            ),
          ],
        ),
      ),
    );
  }
}
