class OtherModel {
  String descriptionEn;
  String id;
  String descriptionBo;

  factory OtherModel.fromJson(Map<String, dynamic> json) {


    return OtherModel(
      descriptionEn: json['description_en'].toString(),
      id: json['_id'].toString(),
      descriptionBo: json['description_bo'].toString()
    );
  }

  OtherModel({
    this.descriptionEn = '',
    this.id = '',
    this.descriptionBo=''
  });

  Map toMap() {
    return {
      "_id": id,
      "description_en": descriptionEn,
      "description_bo": descriptionBo
    };
  }
}
