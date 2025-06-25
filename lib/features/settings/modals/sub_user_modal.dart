class SubUserModal {
  int? id;
  int? parentId;
  String? role;
  String? name;
  String? firstName;
  String? lastName;
  dynamic userType;
  String? email;
  String? dateOfBirth;
  String? profileImage;
  String? country;
  dynamic latitude;
  dynamic longitude;
  dynamic timezone;
  dynamic otp;
  String? active;
  dynamic deletedAt;
  String? createdAt;
  String? updatedAt;

  SubUserModal({
    this.id,
    this.parentId,
    this.role,
    this.name,
    this.firstName,
    this.lastName,
    this.userType,
    this.email,
    this.dateOfBirth,
    this.profileImage,
    this.country,
    this.latitude,
    this.longitude,
    this.timezone,
    this.otp,
    this.active,
    this.deletedAt,
    this.createdAt,
    this.updatedAt,
  });

  factory SubUserModal.fromJson(Map<String, dynamic> json) => SubUserModal(
        id: json['id'] as int?,
        parentId: json['parent_id'] as int?,
        role: json['role'] as String?,
        name: json['name'] as String?,
        firstName: json['first_name'] as String?,
        lastName: json['last_name'] as String?,
        userType: json['user_type'] as dynamic,
        email: json['email'] as String?,
        dateOfBirth: json['date_of_birth'] as String?,
        profileImage: json['profile_image'] as String?,
        country: json['country'] as String?,
        latitude: json['latitude'] as dynamic,
        longitude: json['longitude'] as dynamic,
        timezone: json['timezone'] as dynamic,
        otp: json['otp'] as dynamic,
        active: json['active'] as String?,
        deletedAt: json['deleted_at'] as dynamic,
        createdAt: json['created_at'] as String?,
        updatedAt: json['updated_at'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'parent_id': parentId,
        'role': role,
        'name': name,
        'first_name': firstName,
        'last_name': lastName,
        'user_type': userType,
        'email': email,
        'date_of_birth': dateOfBirth,
        'profile_image': profileImage,
        'country': country,
        'latitude': latitude,
        'longitude': longitude,
        'timezone': timezone,
        'otp': otp,
        'active': active,
        'deleted_at': deletedAt,
        'created_at': createdAt,
        'updated_at': updatedAt,
      };
}
