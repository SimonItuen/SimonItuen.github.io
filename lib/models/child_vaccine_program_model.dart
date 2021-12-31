class ChildVaccineProgramModel {
  String programEn;
  String programBo;
  String year;
  String id;

  ChildVaccineProgramModel(
      {this.programEn = '',
      this.programBo = '',
      this.year = '',this.id = ''});

  factory ChildVaccineProgramModel.fromJson(Map<String, dynamic> json) {
    return ChildVaccineProgramModel(
      programEn: json['program_en'].toString(),
      programBo: json['program_bo'].toString(),
      year: json['year'].toString(),
      id: json['_id'].toString(),
    );
  }

  Map toMap() {
    return {
      "_id": id,
      "program_en": programEn,
      "year": year,
      "program_bo": programBo,
    };
  }
}
