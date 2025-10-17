import 'package:flutter/material.dart';
import 'request_detail_screen.dart';

class MyRequestsScreen extends StatelessWidget {
  const MyRequestsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<String> requests = [
      'Rumah Minimalis di Bandung',
      'Apartemen di Jakarta',
    ];
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      body: ListView.builder(
        padding: const EdgeInsets.all(8),
        itemCount: requests.length,
        itemBuilder: (context, index) {
          return Card(
            elevation: 1,
            margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 8),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            child: ListTile(
              title: Text(requests[index]),
              trailing: const Icon(Icons.arrow_forward_ios, size: 16),
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => RequestDetailScreen(title: requests[index]),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
