class AdminModel {
  String username;
  String id;
  String email;
  String accessToken;
  String language;

  factory AdminModel.fromJson(Map<String, dynamic> json) {


    return AdminModel(
      username: json['username'].toString(),
      id: json['_id'].toString(),
      email: json['email'].toString(),
      accessToken: json['access_token'].toString(),
      language: json['language'].toString(),
    );
  }

  AdminModel({
    this.username = '',
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
      "username": username,
      "language": language
    };
  }
}
