import 'package:rumaia_project/models/investor/investor_profit_detail_model.dart';

/// INVESTMENT PROFIT MODEL
/// Represents an investment project and its profit-sharing history.

class InvestorProfitModel {
  final String projectName;
  final String totalProfit;
  final String period;
  final List<InvestorProfitDetailModel> profitDetails;

  InvestorProfitModel({
    required this.projectName,
    required this.totalProfit,
    required this.period,
    required this.profitDetails,
  });
}

/// Dummy data for preview
final List<InvestorProfitModel> dummyProfitData = [
  InvestorProfitModel(
    projectName: "Rumaia Tower A",
    totalProfit: "Rp 12.450.000",
    period: "Q3 2025",
    profitDetails: [
      InvestorProfitDetailModel(
        date: "10 Oct 2025",
        amount: "Rp 2.000.000",
        type: "Dividend",
      ),
      InvestorProfitDetailModel(
        date: "15 Sep 2025",
        amount: "Rp 1.500.000",
        type: "Bonus",
      ),
    ],
  ),
  InvestorProfitModel(
    projectName: "Rumaia Residence B",
    totalProfit: "Rp 8.900.000",
    period: "Q3 2025",
    profitDetails: [
      InvestorProfitDetailModel(
        date: "12 Oct 2025",
        amount: "Rp 1.200.000",
        type: "Dividend",
      ),
      InvestorProfitDetailModel(
        date: "20 Sep 2025",
        amount: "Rp 1.000.000",
        type: "Bonus",
      ),
    ],
  ),
  InvestorProfitModel(
    projectName: "Rumaia Office Park",
    totalProfit: "Rp 15.300.000",
    period: "Q3 2025",
    profitDetails: [
      InvestorProfitDetailModel(
        date: "05 Oct 2025",
        amount: "Rp 3.000.000",
        type: "Dividend",
      ),
      InvestorProfitDetailModel(
        date: "20 Sep 2025",
        amount: "Rp 2.000.000",
        type: "Bonus",
      ),
    ],
  ),
];
