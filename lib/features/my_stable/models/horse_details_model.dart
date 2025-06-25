class HorseDetailsModel {
  int? id;
  String? name;
  dynamic brand;
  String? sex;
  String? dateOfBirth;
  int? age;
  String? breed;
  String? height;
  String? colour;
  dynamic horseColor;
  String? sire;
  String? dam;
  String? descipline;
  String? profileImage;
  List<HorseGallery>? gallery;
  String? microchipNumber;
  String? eaNumber;
  String? amFeed;
  String? pmFeed;
  String? notes;
  String? weight;
  bool? isMyHorse;

  HorseDetailsModel({
    this.id,
    this.name,
    this.brand,
    this.sex,
    this.dateOfBirth,
    this.age,
    this.breed,
    this.height,
    this.colour,
    this.horseColor,
    this.sire,
    this.dam,
    this.descipline,
    this.profileImage,
    this.gallery,
    this.microchipNumber,
    this.eaNumber,
    this.amFeed,
    this.notes,
    this.pmFeed,
    this.weight,
    this.isMyHorse,
  });

  factory HorseDetailsModel.fromJson(Map<String, dynamic> json) {
    return HorseDetailsModel(
        id: json['id'] as int?,
        name: json['name'] as String?,
        brand: json['brand'] as dynamic,
        sex: json['sex'] as String?,
        dateOfBirth: json['date_of_birth'] as String?,
        age: json['age'] as int?,
        breed: json['breed'] as String?,
        height: json['height'] as String?,
        colour: json['colour'] as String?,
        horseColor: json['horse_color'] as dynamic,
        sire: json['sire'] as String?,
        dam: json['dam'] as String?,
        descipline: json['descipline'] as String?,
        notes: json['notes'] as String?,
        profileImage: json['profile'] as String?,
        gallery: (json['gallery'] as List)
            .map(
              (e) => HorseGallery.fromJson(e),
            )
            .toList(),
        microchipNumber: json["microchip_number"],
        eaNumber: json["ea_number"],
        amFeed: json["am_feed"],
        pmFeed: json["pm_feed"],
        weight: json["weight"],
        isMyHorse: json["is_my_horse"]);
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'brand': brand,
        'sex': sex,
        'date_of_birth': dateOfBirth,
        'age': age,
        'breed': breed,
        'height': height,
        'colour': colour,
        'horse_color': horseColor,
        'sire': sire,
        'dam': dam,
        'descipline': descipline,
        'notes': notes,
        'profile': profileImage,
        'gallery': gallery,
        "microchip_number": microchipNumber,
        "ea_number": eaNumber,
        "am_feed": amFeed,
        "pm_feed": pmFeed,
        "weight": weight,
        "is_my_horse": isMyHorse
      };

  HorseDetailsModel copyWith({
    int? id,
    String? name,
    dynamic brand,
    String? sex,
    String? dateOfBirth,
    int? age,
    String? breed,
    String? height,
    String? colour,
    dynamic horseColor,
    String? sire,
    String? dam,
    String? descipline,
    String? notes,
    String? profileImage,
    List<HorseGallery>? gallery,
    String? microchipNumber,
    String? eaNumber,
    String? amFeed,
    String? pmFeed,
    String? weight,
  }) {
    return HorseDetailsModel(
      id: id ?? this.id,
      name: name ?? this.name,
      brand: brand ?? this.brand,
      sex: sex ?? this.sex,
      dateOfBirth: dateOfBirth ?? this.dateOfBirth,
      age: age ?? this.age,
      breed: breed ?? this.breed,
      height: height ?? this.height,
      colour: colour ?? this.colour,
      horseColor: horseColor ?? this.horseColor,
      sire: sire ?? this.sire,
      dam: dam ?? this.dam,
      descipline: descipline ?? this.descipline,
      profileImage: profileImage ?? this.profileImage,
      gallery: gallery ?? this.gallery,
      microchipNumber: microchipNumber ?? this.microchipNumber,
      eaNumber: eaNumber ?? this.eaNumber,
      amFeed: amFeed ?? this.amFeed,
      notes: notes ?? this.notes,
      pmFeed: pmFeed ?? this.pmFeed,
      weight: weight ?? this.weight,
    );
  }
}

class HorseGallery {
  int? id;
  String? image;

  HorseGallery({this.id, this.image});

  factory HorseGallery.fromJson(Map<String, dynamic> json) => HorseGallery(
        id: json['id'] as int?,
        image: json['image'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'image': image,
      };
}
