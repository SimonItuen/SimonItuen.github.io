class UserModel {
  String surname;
  String givenName;
  String userId;
  String genderString;
  String id;
  String fcmToken;
  List<String> cart;
  String language;

  factory UserModel.fromJson(Map<String, dynamic> json) {
    List<String> cartList = [];

    if (json['cart'] != null) {
      for (String i in json['cart']) {
        cartList.add(i);
      }
    }

    return UserModel(
      surname: json['surname'].toString(),
      givenName: json['given_name'].toString(),
      id: json['_id'].toString(),
      userId: json['user_id'].toString(),
      cart: cartList,
      genderString: json['gender'].toString(),
      fcmToken: json['fcm_token'].toString(),
    );
  }

  UserModel({
    this.surname = '',
    this.givenName = '',
    this.id = '',
    this.userId='',
    this.cart = const [],
    this.fcmToken = '',
    this.language = '',
    this.genderString = '',
  });

  Map toMap() {
    return {
      "_id": id,
      "user_id": userId,
      "cart": cart.toList(),
      "fcm_token": fcmToken,
      "gender": genderString,
      "given_name": givenName,
      "surname": surname,
      "language": language
    };
  }
}
