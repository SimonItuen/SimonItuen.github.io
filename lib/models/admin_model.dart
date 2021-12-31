class AdminModel {
  String surname;
  String givenName;
  String id;
  String email;
  String accessToken;
  String language;

  factory AdminModel.fromJson(Map<String, dynamic> json) {


    return AdminModel(
      surname: json['surname'].toString(),
      givenName: json['given_name'].toString(),
      id: json['_id'].toString(),
      email: json['email'].toString(),
      accessToken: json['access_token'].toString(),
      language: json['language'].toString(),
    );
  }

  AdminModel({
    this.surname = '',
    this.givenName = '',
    this.id = '',
    this.email='',
    this.accessToken = '',
    this.language='nb',
  });

  Map toMap() {
    return {
      "_id": id,
      "email": email,
      "access_token": accessToken,
      "given_name": givenName,
      "surname": surname,
      "language": language
    };
  }
}
