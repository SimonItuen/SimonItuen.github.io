class PriceModel {
  String nameEn;
  String id;
  String nameBo;
  String amount;
  int amountValue;

  factory PriceModel.fromJson(Map<String, dynamic> json) {


    return PriceModel(
      nameEn: json['name_en'].toString(),
      id: json['_id'].toString(),
      nameBo: json['name_bo'].toString(),
      amount: json['amount'].toString(),
      amountValue: json['amount_value'],
    );
  }

  PriceModel({
    this.nameEn = '',
    this.id = '',
    this.nameBo='',
    this.amount = '299',
    this.amountValue=29900,
  });

  Map toMap() {
    return {
      "_id": id,
      "name_en": nameEn,
      "name_bo": nameBo,
      "amount": amount,
      "amount_value":amountValue
    };
  }
}
