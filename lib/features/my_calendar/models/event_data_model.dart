

class EventDataModel {
  List<EventGalleryImage>? eventImage;
  int? id;
  int? eventTypeId;
  int? eventCategoryId;
  String? eventTypeName;
  String? categoryName;
  String? location;
  String? questionId;
  String? questionBA;
  dynamic questionBB;
  dynamic questionBC;
  dynamic questionBD;
  String? eventRepeat;
  String? eventDate;
  dynamic days;
  String? notes;
  String? horseColor;
  int? horseId;
  String? startDate;
  String? endDate;
  String? startTime;
  String? endTime;
  String? alert;
  String? contact;
  String? contactNumber;
  String? horseName;
  String? horseBrand;
  String? horseSex;
  String? profileImage;
  bool? isCompleted;
  String? completedAgo;
  bool? isMyEvent;
  String? eventTimeStatus; 
  EventDataModel({
    this.eventImage,
    this.id,
    this.eventTypeId,
    this.eventCategoryId,
    this.eventTypeName,
    this.categoryName,
    this.location,
    this.questionId,
    this.questionBA,
    this.questionBB,
    this.questionBC,
    this.questionBD,
    this.eventRepeat,
    this.eventDate,
    this.days,
    this.notes,
    this.horseColor,
    this.horseId,
    this.startDate,
    this.endDate,
    this.startTime,
    this.endTime,
    this.alert,
    this.contact,
    this.contactNumber,
    this.horseName,
    this.horseBrand,
    this.horseSex,
    this.profileImage,
    this.isCompleted,
    this.completedAgo,
    this.isMyEvent, 
    this.eventTimeStatus, 
  });

  factory EventDataModel.fromJson(Map<String, dynamic> json) {
    return EventDataModel(
      // eventImage: json['event_image'] as List<EventGalleryImage>?,
      eventImage: (json['event_image'] as List).map((e) =>EventGalleryImage.fromJson(e),).toList(),
      id: json['id'] as int?,
      eventTypeId: json['event_type_id'] as int?,
      eventCategoryId: json['category_id'] as int?,
      eventTypeName: json['event_type_name'] as String?,
      categoryName: json['category_name'] as String?,
      location: json['location'] as String?,
      questionId: json['question_id'] as String?,
      questionBA: json['question_b_a'] as String?,
      questionBB: json['question_b_b'] as dynamic,
      questionBC: json['question_b_c'] as dynamic,
      questionBD: json['question_b_d'] as dynamic,
      eventRepeat: json['event_repeat'] as String?,
      eventDate: json['event_date'] as String?,
      days: json['days'] as dynamic,
      notes: json['notes'] as String?,
      horseColor: json['horse_color'] as String?,
      horseId: json['horse_id'] as int?,
      startDate: json['start_date'] as String?,
      endDate: json['end_date'] as String?,
      startTime: json['start_time'] as String?,
      endTime: json['end_time'] as String?,
      alert: json['alert'] as String?,
      contact: json['contact'] as String?,
      contactNumber: json['contact_phone_no'] as String?,
      horseName: json['horse_name'] as String?,
      horseBrand: json['horse_brand'] as String?,
      horseSex: json['horse_sex'] as String?,
      profileImage: json['profile_image'] as String?,
      isCompleted: json['is_completed'] as bool?,
      completedAgo: json['completed_ago'] as String?,
      isMyEvent: json['is_my_event'] as bool?, 
    );
  }

  Map<String, dynamic> toJson() => {
        'event_image': eventImage,
        'id': id,
        'event_type_id': eventTypeId,
        'category_id': eventCategoryId,
        'event_type_name': eventTypeName,
        'category_name': categoryName,
        'location': location,
        'question_id': questionId,
        'question_b_a': questionBA,
        'question_b_b': questionBB,
        'question_b_c': questionBC,
        'question_b_d': questionBD,
        'event_repeat': eventRepeat,
        'event_date': eventDate,
        'days': days,
        'notes': notes,
        'horse_color': horseColor,
        'horse_id': horseId,
        'start_date': startDate,
        'end_date': endDate,
        'start_time': startTime,
        'end_time': endTime,
        'alert': alert,
        'contact': contact,
        'contact_phone_no': contactNumber,
        'horse_name': horseName,
        'horse_brand': horseBrand,
        'horse_sex': horseSex,
        'profile_image': profileImage,
        "isCompleted": isCompleted,
        "completed_ago": completedAgo,
        "is_my_event": isMyEvent, 
        "eventTimeStatus":eventTimeStatus, 
      };

  EventDataModel copyWith({
    List<EventGalleryImage>? eventImage,
    int? id,
    int? eventTypeId,
    int? eventCategoryId,
    String? eventTypeName,
    String? categoryName,
    String? location,
    String? questionId,
    String? questionBA,
    dynamic questionBB,
    dynamic questionBC,
    dynamic questionBD,
    String? eventRepeat,
    String? eventDate,
    dynamic days,
    String? notes,
    String? horseColor,
    int? horseId,
    String? startDate,
    String? endDate,
    String? startTime,
    String? endTime,
    String? alert,
    String? contact,
    String? contactNumber,
    String? horseName,
    String? horseBrand,
    String? horseSex,
    String? profileImage,
    bool? isCompleted,
    String? completedAgo,
    bool? isMyEvent, 
    String ? eventTimeStatus, 
  }) {
    return EventDataModel(
      eventImage: eventImage ?? this.eventImage,
      id: id ?? this.id,
      eventTypeId: eventTypeId ?? this.eventTypeId,
      eventCategoryId: eventCategoryId ?? this.eventCategoryId,
      eventTypeName: eventTypeName ?? this.eventTypeName,
      categoryName: categoryName ?? this.categoryName,
      location: location ?? this.location,
      questionId: questionId ?? this.questionId,
      questionBA: questionBA ?? this.questionBA,
      questionBB: questionBB ?? this.questionBB,
      questionBC: questionBC ?? this.questionBC,
      questionBD: questionBD ?? this.questionBD,
      eventRepeat: eventRepeat ?? this.eventRepeat,
      eventDate: eventDate ?? this.eventDate,
      days: days ?? this.days,
      notes: notes ?? this.notes,
      horseColor: horseColor ?? this.horseColor,
      completedAgo: horseColor ?? this.completedAgo,
      horseId: horseId ?? this.horseId,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      startTime: startTime ?? this.startTime,
      endTime: endTime ?? this.endTime,
      alert: alert ?? this.alert,
      contact: contact ?? this.contact,
      contactNumber: contactNumber ?? this.contactNumber,
      horseName: horseName ?? this.horseName,
      horseBrand: horseBrand ?? this.horseBrand,
      horseSex: horseSex ?? this.horseSex,
      profileImage: profileImage ?? this.profileImage,
      isCompleted: isCompleted ?? this.isCompleted,
      isMyEvent: isMyEvent ?? this.isMyEvent,
      eventTimeStatus: eventTimeStatus ?? this.eventTimeStatus,
    );
  }
}

class EventGalleryImage {
  int? id;
  String? image;

  EventGalleryImage({this.id, this.image});

  factory EventGalleryImage.fromJson(Map<String, dynamic> json) => EventGalleryImage(
    id: json['id'] as int?,
    image: json['image'] as String?,
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'image': image,
  };
}
