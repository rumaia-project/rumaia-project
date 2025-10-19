import 'package:flutter/material.dart';
import 'package:rumaia_project/models/investor/investor_profit_model.dart';
import 'package:rumaia_project/utils/investor/investor_color.dart';
import 'package:rumaia_project/widgets/investor/investor_profit_card.dart';

/// PROFIT SHARING SCREEN
/// Modular layout showing each project’s profit sharing data.

class InvestorProfitScreen extends StatelessWidget {
  const InvestorProfitScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<InvestorProfitModel> profitData = dummyProfitData;

    return Scaffold(
      backgroundColor: InvestorColor.backgroundColor,
      appBar: AppBar(
        title: const Text(
          "Profit Sharing",
          style: TextStyle(fontWeight: FontWeight.w700, color: Colors.black),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: profitData.length,
        itemBuilder: (context, index) {
          final investment = profitData[index];
          return InvestorProfitCard(investment: investment);
        },
      ),
    );
  }
}
