import 'package:flutter/material.dart';
import 'package:rumaia_project/models/investor/investor_profit_model.dart';
import 'package:rumaia_project/utils/investor/investor_color.dart';
import 'package:rumaia_project/widgets/investor/investor_profit_detail_tile.dart';

/// PROJECT PROFIT CARD
/// Container for each project’s profit-sharing summary.

class InvestorProfitCard extends StatelessWidget {
  final InvestorProfitModel investment;

  const InvestorProfitCard({super.key, required this.investment});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 6,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// Header Project Name + Total Profit
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                investment.projectName,
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(
                investment.totalProfit,
                style: const TextStyle(
                  color: InvestorColor.primaryColor,
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          const SizedBox(height: 6),
          Text(
            "Period: ${investment.period}",
            style: const TextStyle(
              color: InvestorColor.textColor,
              fontSize: 12,
            ),
          ),
          const Divider(height: 24),

          /// Profit detail list
          Column(
            children: investment.profitDetails
                .map((detail) => InvestorProfitDetail(detail: detail))
                .toList(),
          ),
        ],
      ),
    );
  }
}
