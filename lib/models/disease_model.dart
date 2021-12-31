class DiseaseModel {
  String id;
  String key;
  String nameEn;
  String nameBo;
  String vaccineId;
  List<String> countRule;
  List<String> vaccinationDates;

  DiseaseModel(
      {this.id = '',
        this.key = '',
      this.nameEn = '',
      this.nameBo = '',
      this.vaccineId = '',
      this.countRule = const [], this.vaccinationDates= const []});

  factory DiseaseModel.fromJson(Map<String, dynamic> json) {
    List<String> countRuleList = [];
    List<String> vaccinationDatesList = [];
    if (json['count_rule'] != null) {
      for (String i in json['count_rule']) {
        countRuleList.add(i.toString());
      }
    }
    if (json['vaccination_dates'] != null) {
      for (String i in json['vaccination_dates']) {
        vaccinationDatesList.add(i.toString());
      }
    }
    return DiseaseModel(
      id: json['_id'].toString(),
        nameEn: json['name_en'].toString(),
      nameBo: json['name_bo'].toString(),
      key: json['key'].toString(),
      vaccineId: json['vaccine_id'].toString(),
      countRule: countRuleList,
      vaccinationDates: vaccinationDatesList
    );
  }

  Map toMap() {
    return {
      "_id": id,
      "key": key,
      "name_en": nameEn,
      "name_bo": nameBo,
      "vaccine_id": vaccineId,
      "count_rule": countRule.toList(),
      "vaccination_dates": vaccinationDates.toList()
    };
  }
}
