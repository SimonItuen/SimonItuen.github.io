class DashboardModel {
  final String userCount;
  final String diseaseCount;
  final String orderCount;
  final String vaccineCount;
  final String countryCount;
  final String childProgramCount;
  final String pharmacyCount;

  DashboardModel(
      {required this.userCount, required this.diseaseCount, required this.orderCount, required this.vaccineCount, required this.countryCount, required this.childProgramCount, required this.pharmacyCount,});

  factory DashboardModel.fromJson(Map<String, dynamic> json) {
    return DashboardModel(userCount: json['users'].toString(),
        diseaseCount: json['diseases'].toString(),
        orderCount: json['orders'].toString(),
        vaccineCount: json['vaccines'].toString(),
        countryCount: json['countries'].toString(),
        childProgramCount: json['childProgrammes'].toString(),
        pharmacyCount: json['pharmacies'].toString());
  }

  Map toMap() {
    return {
      "users": userCount,
      "diseases": diseaseCount,
      "vaccines": vaccineCount,
      "orderCount": orderCount,
      "countries": countryCount,
      "childPrograms": childProgramCount,
      "pharmacies": pharmacyCount
    };
  }
}
