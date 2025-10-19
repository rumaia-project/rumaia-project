import 'package:flutter/material.dart';
import 'package:rumaia_project/models/investor/investor_profit_detail_model.dart';
import 'package:rumaia_project/utils/investor/investor_color.dart';

/// PROFIT DETAIL TILE
/// Individual profit-sharing record (date, amount, type).

class InvestorProfitDetail extends StatelessWidget {
  final InvestorProfitDetailModel detail;

  const InvestorProfitDetail({super.key, required this.detail});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
      decoration: BoxDecoration(
        color: InvestorColor.backgroundColor,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xffeaeaea)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          /// Date + Type
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                detail.date,
                style: const TextStyle(
                  color: InvestorColor.textColor,
                  fontSize: 12,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                detail.type,
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),

          /// Profit Amount
          Text(
            detail.amount,
            style: const TextStyle(
              color: InvestorColor.primaryColor,
              fontSize: 14,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
