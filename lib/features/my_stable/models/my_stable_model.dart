class MyStableModel {
  int? id;
  String? profileImage;
  String? name;
  dynamic brand;
  String? sex;
  String? dateOfBirth;
  int? age;
  String? breed;
  dynamic horseColor;
  bool? isSelected;
  MyStableModel({
    this.id,
    this.profileImage,
    this.name,
    this.brand,
    this.sex,
    this.dateOfBirth,
    this.age,
    this.breed,
    this.horseColor,
    this.isSelected,
  });

  factory MyStableModel.fromJson(Map<String, dynamic> json) => MyStableModel(
        id: json['id'] as int?,
        profileImage: json['profile'] as String?,
        name: json['name'] as String?,
        brand: json['brand'] as dynamic,
        sex: json['sex'] as String?,
        dateOfBirth: json['date_of_birth'] as String?,
        age: json['age'] as int?,
        breed: json['breed'] as String?,
        horseColor: json['horse_color'] as dynamic,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'profile_image': profileImage,
        'name': name,
        'brand': brand,
        'sex': sex,
        'date_of_birth': dateOfBirth,
        'age': age,
        'breed': breed,
        'horse_color': horseColor,
        'isSelected': isSelected,
      };

  MyStableModel copyWith({
    int? id,
    String? profileImage,
    String? name,
    dynamic brand,
    String? sex,
    String? dateOfBirth,
    int? age,
    String? breed,
    dynamic horseColor,
    bool? isSelected,
  }) {
    return MyStableModel(
      id: id ?? this.id,
      profileImage: profileImage ?? this.profileImage,
      name: name ?? this.name,
      brand: brand ?? this.brand,
      sex: sex ?? this.sex,
      dateOfBirth: dateOfBirth ?? this.dateOfBirth,
      age: age ?? this.age,
      breed: breed ?? this.breed,
      horseColor: horseColor ?? this.horseColor,
      isSelected: isSelected ?? this.isSelected,
    );
  }
}
