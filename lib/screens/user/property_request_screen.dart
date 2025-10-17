import 'package:flutter/material.dart';

import 'property_home_screen.dart';

class PropertyRequestScreen extends StatelessWidget {
  const PropertyRequestScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Property Request')),
      body: Center(
        child: ElevatedButton.icon(
          icon: const Icon(Icons.map),
          label: const Text('Select Location'),
          onPressed: () => Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const UserHomeScreen()),
          ),
        ),
      ),
    );
  }
}
