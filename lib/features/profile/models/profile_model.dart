// To parse this JSON data, do
//
//     final profileModel = profileModelFromJson(jsonString);

import 'dart:convert';

ProfileModel profileModelFromJson(String str) =>
    ProfileModel.fromJson(json.decode(str));

String profileModelToJson(ProfileModel data) => json.encode(data.toJson());

class ProfileModel {
  int? id;
  dynamic parentId;
  String? role;
  String? name;
  String? firstName;
  String? lastName;
  String? email;
  String? dateOfBirth;
  String? profileImage;
  String? backgroundImage;
  dynamic mobileNumber;
  String? country;
  dynamic latitude;
  dynamic longitude;
  dynamic timezone;
  dynamic otp;
  String? active;
  String? terma;
  String? gender;
  dynamic deletedAt;
  DateTime? createdAt;
  DateTime? updatedAt;
  bool? hasFullAccess;

  ProfileModel({
    this.id,
    this.parentId,
    this.role,
    this.name,
    this.firstName,
    this.lastName,
    this.email,
    this.dateOfBirth,
    this.profileImage,
    this.backgroundImage,
    this.mobileNumber,
    this.country,
    this.latitude,
    this.longitude,
    this.timezone,
    this.otp,
    this.active,
    this.terma,
    this.gender,
    this.deletedAt,
    this.createdAt,
    this.updatedAt,
    this.hasFullAccess,
  });

  ProfileModel copyWith({
    int? id,
    dynamic parentId,
    String? role,
    String? name,
    String? firstName,
    String? lastName,
    String? email,
    String? dateOfBirth,
    String? profileImage,
    String? backgroundImage,
    dynamic mobileNumber,
    String? country,
    dynamic latitude,
    dynamic longitude,
    dynamic timezone,
    dynamic otp,
    String? active,
    String? terma,
    String? gender,
    dynamic deletedAt,
    DateTime? createdAt,
    DateTime? updatedAt,
    bool? hasFullAccess,
  }) =>
      ProfileModel(
          id: id ?? this.id,
          parentId: parentId ?? this.parentId,
          role: role ?? this.role,
          name: name ?? this.name,
          firstName: firstName ?? this.firstName,
          lastName: lastName ?? this.lastName,
          email: email ?? this.email,
          dateOfBirth: dateOfBirth ?? this.dateOfBirth,
          profileImage: profileImage ?? this.profileImage,
          backgroundImage: backgroundImage ?? this.backgroundImage,
          mobileNumber: mobileNumber ?? this.mobileNumber,
          country: country ?? this.country,
          latitude: latitude ?? this.latitude,
          longitude: longitude ?? this.longitude,
          timezone: timezone ?? this.timezone,
          otp: otp ?? this.otp,
          active: active ?? this.active,
          terma: terma ?? this.terma,
          gender: gender ?? this.gender,
          deletedAt: deletedAt ?? this.deletedAt,
          createdAt: createdAt ?? this.createdAt,
          updatedAt: updatedAt ?? this.updatedAt,
          hasFullAccess: hasFullAccess ?? this.hasFullAccess);

  factory ProfileModel.fromJson(Map<String, dynamic> json) => ProfileModel(
        id: json["id"],
        parentId: json["parent_id"],
        role: json["role"],
        name: json["name"],
        firstName: json["first_name"],
        lastName: json["last_name"],
        email: json["email"],
        dateOfBirth: json["date_of_birth"],
        profileImage: json["profile_image"],
        backgroundImage: json["background_image"],
        mobileNumber: json["mobile_number"],
        country: json["country"],
        latitude: json["latitude"],
        longitude: json["longitude"],
        timezone: json["timezone"],
        otp: json["otp"],
        active: json["active"],
        terma: json["terma"],
        gender: json["gender"],
        deletedAt: json["deleted_at"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        hasFullAccess: json['has_full_access'],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "parent_id": parentId,
        "role": role,
        "name": name,
        "first_name": firstName,
        "last_name": lastName,
        "email": email,
        "date_of_birth": dateOfBirth,
        "profile_image": profileImage,
        "background_image": backgroundImage,
        "mobile_number": mobileNumber,
        "country": country,
        "latitude": latitude,
        "longitude": longitude,
        "timezone": timezone,
        "otp": otp,
        "active": active,
        "terma": terma,
        "gender": gender,
        "deleted_at": deletedAt,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
      };
}
