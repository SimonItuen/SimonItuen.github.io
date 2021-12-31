class VaccineModel {
  String id;
  String vaccineId;
  String nameEn;
  String nameBo;
  String categoryNameEn;
  String categoryNameBo;
  List<String> vaccineQuestionsMaleEn;
  List<String> vaccineQuestionsMaleBo;
  List<String> vaccineQuestionsFemaleEn;
  List<String> vaccineQuestionsFemaleBo;



  VaccineModel(
      {this.categoryNameEn = '',this.categoryNameBo = '',
      this.nameEn = '',
      this.nameBo = '',
      this.vaccineId = '',
        this.id = '',
      this.vaccineQuestionsMaleEn = const [], this.vaccineQuestionsMaleBo= const [],
      this.vaccineQuestionsFemaleEn = const [], this.vaccineQuestionsFemaleBo= const []});

  factory VaccineModel.fromJson(Map<String, dynamic> json) {
    List<String> vaccineQuestionsMaleListEn = [];
    List<String> vaccineQuestionsMaleListBo = [];
    List<String> vaccineQuestionsFemaleListEn = [];
    List<String> vaccineQuestionsFemaleListBo = [];
    if (json['vaccine_questions_male_en'] != null) {
      for (String i in json['vaccine_questions_male_en']) {
        vaccineQuestionsMaleListEn.add(i.toString());
      }
    }
    if (json['vaccine_questions_male_bo'] != null) {
      for (String i in json['vaccine_questions_male_bo']) {
        vaccineQuestionsMaleListBo.add(i.toString());
      }
    }
    if (json['vaccine_questions_female_en'] != null) {
      for (String i in json['vaccine_questions_female_en']) {
        vaccineQuestionsFemaleListEn.add(i.toString());
      }
    }
    if (json['vaccine_questions_female_bo'] != null) {
      for (String i in json['vaccine_questions_female_bo']) {
        vaccineQuestionsFemaleListBo.add(i.toString());
      }
    }

    return VaccineModel(
      nameEn: json['name_en'].toString(),
      nameBo: json['name_bo'].toString(),
      categoryNameBo: json['category_name_bo'].toString(),
      categoryNameEn: json['category_name_en'].toString(),
      vaccineId: json['vaccine_id'].toString(),
        id: json['_id'].toString(),
      vaccineQuestionsMaleBo: vaccineQuestionsMaleListBo,
      vaccineQuestionsMaleEn: vaccineQuestionsMaleListEn,
      vaccineQuestionsFemaleBo: vaccineQuestionsFemaleListBo,
      vaccineQuestionsFemaleEn: vaccineQuestionsFemaleListEn
    );
  }

  Map toMap() {
    return {
      "_id": id,
      "name_en": nameEn,
      "name_bo": nameBo,
      "vaccine_id": vaccineId,
      "category_name_en":categoryNameEn,
      "category_name_bo": categoryNameBo,
      "vaccine_questions_male_en": vaccineQuestionsMaleEn.toList(),
      "vaccine_questions_male_bo": vaccineQuestionsMaleBo.toList(),
      "vaccine_questions_female_en": vaccineQuestionsFemaleEn.toList(),
      "vaccine_questions_female_bo": vaccineQuestionsFemaleBo.toList(),
    };
  }
}
