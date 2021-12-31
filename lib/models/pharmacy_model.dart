class PharmacyModel {
  String id;
  String name;
  String address;
  double rating;
  int customers;
  double longitude;
  double latitude;
  String descriptionEn;
  String descriptionBo;

  PharmacyModel({
    this.id = '',
    this.name = '',
    this.address = '',
    this.rating = 0.0,
    this.customers = 0,
    this.longitude = 0,
    this.latitude = 0,
    this.descriptionEn = '',
    this.descriptionBo = '',
  });

  factory PharmacyModel.fromJson(Map<String, dynamic> json) {
    return PharmacyModel(id: json['_id'].toString(),
      name: json['name'].toString(),
      address: json['address'].toString(),
      rating: json['rating']??0.0,
      customers: json['customers']??0,
      latitude: json['latitude']??0.0,
      longitude: json['longitude']??0.0,
      descriptionEn: json['description_en'].toString(),
      descriptionBo: json['description_bo'].toString(),
    );
  }

  Map toMap() {
    return {
      "_id": id,
      "name": name,
      "address": address,
      "rating": rating,
      "customers": customers,
      "longitude": longitude,
      "latitude": latitude,
      "description_en": descriptionEn,
      "description_bo": descriptionBo,
    };
  }
}
