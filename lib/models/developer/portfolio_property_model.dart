// ===============================================================
// MODEL: PortfolioPropertyModel
// ===============================================================

class PortfolioPropertyModel {
  final String title;
  final String address;
  final String totalInvestment;
  final String monthlyRevenue;
  final double maturity;
  final String propertyType;
  final String image;

  PortfolioPropertyModel({
    required this.title,
    required this.address,
    required this.totalInvestment,
    required this.monthlyRevenue,
    required this.maturity,
    required this.propertyType,
    required this.image,
  });
}
