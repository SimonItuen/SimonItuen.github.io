class LanguageModel{

final String key;
final String english;
final String bokmal;

LanguageModel({required this.key, required this.bokmal, required this.english});

factory LanguageModel.fromJson(Map<String, dynamic> json) {
  return LanguageModel(
    key: json['Key'].toString(),
    english: json['English'].toString(),
    bokmal: json['Bokmål'].toString(),
  );
}}