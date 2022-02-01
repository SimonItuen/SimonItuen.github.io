import 'package:vaksine_web/models/other_model.dart';
import 'package:vaksine_web/models/price_model.dart';

class DashboardModel {
  final String userCount;
  final String diseaseCount;
  final String orderCount;
  final String vaccineCount;
  final String countryCount;
  final String childProgramCount;
  final String pharmacyCount;
  final PriceModel consultationFee;
  final OtherModel aboutUs;
  final OtherModel contactUs;

  DashboardModel({
    required this.userCount,
    required this.diseaseCount,
    required this.orderCount,
    required this.vaccineCount,
    required this.countryCount,
    required this.childProgramCount,
    required this.pharmacyCount,
    required this.consultationFee,
    required this.aboutUs,
    required this.contactUs,
  });

  factory DashboardModel.fromJson(Map<String, dynamic> json) {
    return DashboardModel(
      userCount: json['users'].toString(),
      diseaseCount: json['diseases'].toString(),
      orderCount: json['orders'].toString(),
      vaccineCount: json['vaccines'].toString(),
      countryCount: json['countries'].toString(),
      childProgramCount: json['childProgrammes'].toString(),
      pharmacyCount: json['pharmacies'].toString(),
      consultationFee: PriceModel.fromJson(json['consultationFee']),
      aboutUs: OtherModel.fromJson(json['aboutUs']),
      contactUs: OtherModel.fromJson(json['contactUs']),
    );
  }

  Map toMap() {
    return {
      "users": userCount,
      "diseases": diseaseCount,
      "vaccines": vaccineCount,
      "orderCount": orderCount,
      "countries": countryCount,
      "childPrograms": childProgramCount,
      "pharmacies": pharmacyCount,
      "consultationFee": consultationFee.toMap(),
      "aboutUs": aboutUs.toMap(),
      "contactUs": contactUs.toMap(),
    };
  }
}
