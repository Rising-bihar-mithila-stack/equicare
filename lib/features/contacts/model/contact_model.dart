import 'dart:convert';

ContactModel contactModelFromJson(String str) =>
    ContactModel.fromJson(json.decode(str));

String contactModelToJson(ContactModel data) => json.encode(data.toJson());

class ContactModel {
  int? id;
  String? fullName;
  String? phoneNo;
  String? emailAddress;
  String? company;
  String? profession;
  String? address;
  String? profile;

  ContactModel({
    this.id,
    this.fullName,
    this.phoneNo,
    this.emailAddress,
    this.company,
    this.profession,
    this.address,
    this.profile,
  });

  ContactModel copyWith({
    int? id,
    String? fullName,
    String? phoneNo,
    String? emailAddress,
    String? company,
    String? profession,
    String? address,
    String? profile,
  }) =>
      ContactModel(
        id: id ?? this.id,
        fullName: fullName ?? this.fullName,
        phoneNo: phoneNo ?? this.phoneNo,
        emailAddress: emailAddress ?? this.emailAddress,
        company: company ?? this.company,
        profession: profession ?? this.profession,
        address: address ?? this.address,
        profile: profile ?? this.profile,
      );

  factory ContactModel.fromJson(Map<String, dynamic> json) => ContactModel(
        id: json["id"],
        fullName: json["full_name"],
        phoneNo: json["phone_no"],
        emailAddress: json["email_address"],
        company: json["company"],
        profession: json["profession"],
        address: json["address"],
        profile: json["profile"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "full_name": fullName,
        "phone_no": phoneNo,
        "email_address": emailAddress,
        "company": company,
        "profession": profession,
        "address": address,
        "profile": profile,
      };
}
