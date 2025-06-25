class HorseEventModel {
  int? id;
  int? userId;
  int? horseId;
  int? eventTypeId;
  String? contact;
  String? location;
  int? categoryId;
  String? questionId;
  String? questionBA;
  String? questionBB;
  dynamic questionBC;
  dynamic questionBD;
  String? startDate;
  String? endDate;
  String? startTime;
  String? endTime;
  String? timezone;
  String? startDateTimeUtc;
  String? endDateTimeUtc;
  dynamic exceptions;
  dynamic eventDate;
  String? eventRepeat;
  String? alert;
  String? occuranceDate;
  dynamic notificationDate;
  dynamic notificationTimes;
  String? notes;
  String? createdAt;
  String? updatedAt;
  bool? isMyEvent;
  Horse? horse;

  HorseEventModel({
    this.id,
    this.userId,
    this.horseId,
    this.eventTypeId,
    this.contact,
    this.location,
    this.categoryId,
    this.questionId,
    this.questionBA,
    this.questionBB,
    this.questionBC,
    this.questionBD,
    this.startDate,
    this.endDate,
    this.startTime,
    this.endTime,
    this.timezone,
    this.startDateTimeUtc,
    this.endDateTimeUtc,
    this.exceptions,
    this.eventDate,
    this.eventRepeat,
    this.alert,
    this.occuranceDate,
    this.notificationDate,
    this.notificationTimes,
    this.notes,
    this.createdAt,
    this.updatedAt,
    this.isMyEvent,
    this.horse,
  });

  factory HorseEventModel.fromJson(Map<String, dynamic> json) {
    return HorseEventModel(
      id: json['id'] as int?,
      userId: json['user_id'] as int?,
      horseId: json['horse_id'] as int?,
      eventTypeId: json['event_type_id'] as int?,
      contact: json['contact'] as String?,
      location: json['location'] as String?,
      categoryId: json['category_id'] as int?,
      questionId: json['question_id'] as String?,
      questionBA: json['question_b_a'] as String?,
      questionBB: json['question_b_b'] as String?,
      questionBC: json['question_b_c'] as dynamic,
      questionBD: json['question_b_d'] as dynamic,
      startDate: json['start_date'] as String?,
      endDate: json['end_date'] as String?,
      startTime: json['start_time'] as String?,
      endTime: json['end_time'] as String?,
      timezone: json['timezone'] as String?,
      startDateTimeUtc: json['start_date_time_utc'] as String?,
      endDateTimeUtc: json['end_date_time_utc'] as String?,
      exceptions: json['exceptions'] as dynamic,
      eventDate: json['event_date'] as dynamic,
      eventRepeat: json['event_repeat'] as String?,
      alert: json['alert'] as String?,
      occuranceDate: json['occurance_date'] as String?,
      notificationDate: json['notification_date'] as dynamic,
      notificationTimes: json['notification_times'] as dynamic,
      notes: json['notes'] as String?,
      createdAt: json['created_at'] as String?,
      updatedAt: json['updated_at'] as String?,
      isMyEvent: json['is_my_event'] as bool?,
      horse: json['horse'] == null
          ? null
          : Horse.fromJson(json['horse'] as Map<String, dynamic>),
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'user_id': userId,
        'horse_id': horseId,
        'event_type_id': eventTypeId,
        'contact': contact,
        'location': location,
        'category_id': categoryId,
        'question_id': questionId,
        'question_b_a': questionBA,
        'question_b_b': questionBB,
        'question_b_c': questionBC,
        'question_b_d': questionBD,
        'start_date': startDate,
        'end_date': endDate,
        'start_time': startTime,
        'end_time': endTime,
        'timezone': timezone,
        'start_date_time_utc': startDateTimeUtc,
        'end_date_time_utc': endDateTimeUtc,
        'exceptions': exceptions,
        'event_date': eventDate,
        'event_repeat': eventRepeat,
        'alert': alert,
        'occurance_date': occuranceDate,
        'notification_date': notificationDate,
        'notification_times': notificationTimes,
        'notes': notes,
        'created_at': createdAt,
        'updated_at': updatedAt,
        'is_my_event': isMyEvent,
        'horse': horse?.toJson(),
      };
}

class Horse {
  int? id;
  int? userId;
  String? horseColor;
  String? name;
  String? brand;
  String? sex;
  String? dateOfBirth;
  String? height;
  String? breed;
  String? colour;
  String? descipline;
  String? sire;
  String? dam;
  String? profile;
  String? microchipNumber;
  String? eaNumber;
  String? amFeed;
  String? pmFeed;
  String? weight;
  String? createdAt;
  String? updatedAt;
  bool? isMyHorse;

  Horse({
    this.id,
    this.userId,
    this.horseColor,
    this.name,
    this.brand,
    this.sex,
    this.dateOfBirth,
    this.height,
    this.breed,
    this.colour,
    this.descipline,
    this.sire,
    this.dam,
    this.profile,
    this.microchipNumber,
    this.eaNumber,
    this.amFeed,
    this.pmFeed,
    this.weight,
    this.createdAt,
    this.updatedAt,
    this.isMyHorse,
  });

  factory Horse.fromJson(Map<String, dynamic> json) => Horse(
        id: json['id'] as int?,
        userId: json['user_id'] as int?,
        horseColor: json['horse_color'] as String?,
        name: json['name'] as String?,
        brand: json['brand'] as String?,
        sex: json['sex'] as String?,
        dateOfBirth: json['date_of_birth'] as String?,
        height: json['height'] as String?,
        breed: json['breed'] as String?,
        colour: json['colour'] as String?,
        descipline: json['descipline'] as String?,
        sire: json['sire'] as String?,
        dam: json['dam'] as String?,
        profile: json['profile'] as String?,
        microchipNumber: json['microchip_number'] as String?,
        eaNumber: json['ea_number'] as String?,
        amFeed: json['am_feed'] as String?,
        pmFeed: json['pm_feed'] as String?,
        weight: json['weight'] as String?,
        createdAt: json['created_at'] as String?,
        updatedAt: json['updated_at'] as String?,
        isMyHorse: json['is_my_horse'] as bool?,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'user_id': userId,
        'horse_color': horseColor,
        'name': name,
        'brand': brand,
        'sex': sex,
        'date_of_birth': dateOfBirth,
        'height': height,
        'breed': breed,
        'colour': colour,
        'descipline': descipline,
        'sire': sire,
        'dam': dam,
        'profile': profile,
        'microchip_number': microchipNumber,
        'ea_number': eaNumber,
        'am_feed': amFeed,
        'pm_feed': pmFeed,
        'weight': weight,
        'created_at': createdAt,
        'updated_at': updatedAt,
        'is_my_horse': isMyHorse,
      };
}
