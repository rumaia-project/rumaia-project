// Model to represent an investment opportunity

class InvestorOpportunitiesModel {
  final String title;
  final String location;
  final double minInvestment;
  final double roi;
  final double fundingProgress;
  final String description;

  InvestorOpportunitiesModel({
    required this.title,
    required this.location,
    required this.minInvestment,
    required this.roi,
    required this.fundingProgress,
    required this.description,
  });
}

// Dummy data for testing UI only
List<InvestorOpportunitiesModel> dummyInvestments = [
  InvestorOpportunitiesModel(
    title: "EcoSmart Residence",
    location: "Jakarta, Indonesia",
    minInvestment: 5000,
    roi: 12.5,
    fundingProgress: 0.78,
    description:
        "A sustainable housing project with modern smart technology integration. The goal is to create eco-friendly urban living spaces.",
  ),
  InvestorOpportunitiesModel(
    title: "Solar Energy Plant",
    location: "Bandung, Indonesia",
    minInvestment: 10000,
    roi: 15.0,
    fundingProgress: 0.54,
    description:
        "Investment in renewable solar energy plant designed to supply sustainable power to West Java region.",
  ),
  InvestorOpportunitiesModel(
    title: "Urban Coffee Hub",
    location: "Surabaya, Indonesia",
    minInvestment: 2500,
    roi: 10.8,
    fundingProgress: 0.92,
    description:
        "A new modern coffee hub focusing on creative co-working spaces and premium coffee distribution in East Java.",
  ),
];
