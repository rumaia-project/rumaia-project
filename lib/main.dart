import 'package:flutter/material.dart';
import 'package:rumaia_project/widgets/developer/botnavbar.dart';

void main() {
  runApp(const RumaiaApp());
}

class RumaiaApp extends StatelessWidget {
  const RumaiaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Rumaia Project',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blueAccent),
        useMaterial3: true,
      ),
      home: const BotnavbarScreen(),
    );
  }
}
