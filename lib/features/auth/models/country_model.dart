import 'dart:convert';

CountryModel countryModelFromJson(String str) =>
    CountryModel.fromJson(json.decode(str));

String countryModelToJson(CountryModel data) => json.encode(data.toJson());

class CountryModel {
  int? id;
  String? value;

  CountryModel({
    this.id,
    this.value,
  });

  CountryModel copyWith({
    int? id,
    String? value,
  }) =>
      CountryModel(
        id: id ?? this.id,
        value: value ?? this.value,
      );

  factory CountryModel.fromJson(Map<String, dynamic> json) => CountryModel(
        id: json["id"],
        value: json["value"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "value": value,
      };
}
