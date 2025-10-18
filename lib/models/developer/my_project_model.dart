/// ===============================================================
/// PROJECT MODEL
///
/// ===============================================================
class ProjectModel {
  final String title;
  final String location;
  final double progress;
  final String status;
  final String fundingStatus;
  final double currentFund;
  final double targetFund;
  final String estimation;
  final String imagePlaceholder;

  ProjectModel({
    required this.title,
    required this.location,
    required this.progress,
    required this.status,
    required this.fundingStatus,
    required this.currentFund,
    required this.targetFund,
    required this.estimation,
    required this.imagePlaceholder,
  });
}
