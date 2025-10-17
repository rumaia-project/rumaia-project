import 'package:flutter/material.dart';

class RequestDetailScreen extends StatelessWidget {
  final String title;
  const RequestDetailScreen({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text('Detail Property Request', style: TextStyle(fontSize: 18)),
            SizedBox(height: 12),
            Text('Status: Pending'),
            Text('Type: Rumah Minimalis'),
            Text('Area: 120 m²'),
            Text('Location: Bandung'),
          ],
        ),
      ),
    );
  }
}
