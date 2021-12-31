class CountryModel {
  String id;
  String nameEn;
  String nameBo;
  String code;
  String shortTrip;
  String longTrip;
  String malPrevEn;
  String malPrevBo;
  bool malariaFree;

  CountryModel(
      {this.id = '',
        this.nameEn = '',
      this.nameBo = '',
      this.code = '',
      this.shortTrip = '',
      this.longTrip = '',
      this.malPrevEn = '',
      this.malariaFree = false,
      this.malPrevBo = ''});

  factory CountryModel.fromJson(Map<String, dynamic> json) {
    return CountryModel(
      id: json['_id'].toString(),
      nameEn: json['name_en'].toString(),
      nameBo: json['name_bo'].toString(),
      code: json['code'].toString(),
      shortTrip: json['short_trip'].toString(),
      longTrip: json['long_trip'].toString(),
      malPrevEn: json['mal_prev_en'].toString(),
      malPrevBo: json['mal_prev_bo'].toString(),
      malariaFree: json['malaria_free'],
    );
  }

  Map toMap() {
    return {
      "_id": id,
      "name_en": nameEn,
      "code": code,
      "short_trip": shortTrip,
      "long_trip": longTrip,
      "name_bo": nameBo,
      "mal_prev_en": malPrevEn,
      "mal_prev_bo": malPrevBo,
      "malaria_free": malariaFree
    };
  }
}
