import 'package:flutter/material.dart';

class DetailPropertyScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Detail Properti')),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network('https://via.placeholder.com/400x200'),
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
            ElevatedButton(onPressed: () {}, child: Text('Ajukan Pembelian')),
          ],
        ),
      ),
    );
  }
}
