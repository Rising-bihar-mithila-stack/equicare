import 'dart:convert';

import 'event_fields_model.dart';

EditEventModel editEventModelFromJson(String str) => EditEventModel.fromJson(json.decode(str));

String editEventModelToJson(EditEventModel data) => json.encode(data.toJson());

class EditEventModel {
  int? id;
  int? userId;
  int? horseId;
  int? eventTypeId;
  String? contact;
  String? location;
  int? categoryId;
  DateTime? startDate;
  DateTime? endDate;
  String? startTime;
  String? endTime;
  String? timezone;
  DateTime? startDateTimeUtc;
  DateTime? endDateTimeUtc;
  dynamic exceptions;
  dynamic eventDate;
  String? eventRepeat;
  String? alert;
  DateTime? occuranceDateUtc;
  String? occuranceTimesUtc;
  dynamic notificationDateUtc;
  dynamic notificationTimesUtc;
  String? notes;
  String? fieldsData;
  DateTime? createdAt;
  DateTime? updatedAt;
  List<EventImage>? eventImages;
  List<EventFieldsModel>? fieldsResponse;
  bool? isMyEvent;

  EditEventModel({
    this.id,
    this.userId,
    this.horseId,
    this.eventTypeId,
    this.contact,
    this.location,
    this.categoryId,
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
    this.occuranceDateUtc,
    this.occuranceTimesUtc,
    this.notificationDateUtc,
    this.notificationTimesUtc,
    this.notes,
    this.fieldsData,
    this.createdAt,
    this.updatedAt,
    this.eventImages,
    this.fieldsResponse,
    this.isMyEvent,
  });

  EditEventModel copyWith({
    int? id,
    int? userId,
    int? horseId,
    int? eventTypeId,
    String? contact,
    String? location,
    int? categoryId,
    DateTime? startDate,
    DateTime? endDate,
    String? startTime,
    String? endTime,
    String? timezone,
    DateTime? startDateTimeUtc,
    DateTime? endDateTimeUtc,
    dynamic exceptions,
    dynamic eventDate,
    String? eventRepeat,
    String? alert,
    DateTime? occuranceDateUtc,
    String? occuranceTimesUtc,
    dynamic notificationDateUtc,
    dynamic notificationTimesUtc,
    String? notes,
    String? fieldsData,
    DateTime? createdAt,
    DateTime? updatedAt,
    List<EventImage>? eventImages,
    List<EventFieldsModel>? fieldsResponse,
    bool? isMyEvent,
  }) =>
      EditEventModel(
        id: id ?? this.id,
        userId: userId ?? this.userId,
        horseId: horseId ?? this.horseId,
        eventTypeId: eventTypeId ?? this.eventTypeId,
        contact: contact ?? this.contact,
        location: location ?? this.location,
        categoryId: categoryId ?? this.categoryId,
        startDate: startDate ?? this.startDate,
        endDate: endDate ?? this.endDate,
        startTime: startTime ?? this.startTime,
        endTime: endTime ?? this.endTime,
        timezone: timezone ?? this.timezone,
        startDateTimeUtc: startDateTimeUtc ?? this.startDateTimeUtc,
        endDateTimeUtc: endDateTimeUtc ?? this.endDateTimeUtc,
        exceptions: exceptions ?? this.exceptions,
        eventDate: eventDate ?? this.eventDate,
        eventRepeat: eventRepeat ?? this.eventRepeat,
        alert: alert ?? this.alert,
        occuranceDateUtc: occuranceDateUtc ?? this.occuranceDateUtc,
        occuranceTimesUtc: occuranceTimesUtc ?? this.occuranceTimesUtc,
        notificationDateUtc: notificationDateUtc ?? this.notificationDateUtc,
        notificationTimesUtc: notificationTimesUtc ?? this.notificationTimesUtc,
        notes: notes ?? this.notes,
        fieldsData: fieldsData ?? this.fieldsData,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        eventImages: eventImages ?? this.eventImages,
        fieldsResponse: fieldsResponse ?? this.fieldsResponse,
        isMyEvent: isMyEvent ?? this.isMyEvent,
      );

  factory EditEventModel.fromJson(Map<String, dynamic> json) => EditEventModel(
    id: json["id"],
    userId: json["user_id"],
    horseId: json["horse_id"],
    eventTypeId: json["event_type_id"],
    contact: json["contact"],
    location: json["location"],
    categoryId: json["category_id"],
    startDate: json["start_date"] == null ? null : DateTime.parse(json["start_date"]),
    endDate: json["end_date"] == null ? null : DateTime.parse(json["end_date"]),
    startTime: json["start_time"],
    endTime: json["end_time"],
    timezone: json["timezone"],
    startDateTimeUtc: json["start_date_time_utc"] == null ? null : DateTime.parse(json["start_date_time_utc"]),
    endDateTimeUtc: json["end_date_time_utc"] == null ? null : DateTime.parse(json["end_date_time_utc"]),
    exceptions: json["exceptions"],
    eventDate: json["event_date"],
    eventRepeat: json["event_repeat"],
    alert: json["alert"],
    occuranceDateUtc: json["occurance_date_utc"] == null ? null : DateTime.parse(json["occurance_date_utc"]),
    occuranceTimesUtc: json["occurance_times_utc"],
    notificationDateUtc: json["notification_date_utc"],
    notificationTimesUtc: json["notification_times_utc"],
    notes: json["notes"],
    fieldsData: json["fieldsData"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    eventImages: json["event_images"] == null ? [] : List<EventImage>.from(json["event_images"]!.map((x) => EventImage.fromJson(x))),
    fieldsResponse: json["fieldsResponse"] == null ? [] : List<EventFieldsModel>.from(json["fieldsResponse"]!.map((x) => EventFieldsModel.fromJson(x))),
    isMyEvent: json["is_my_event"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "user_id": userId,
    "horse_id": horseId,
    "event_type_id": eventTypeId,
    "contact": contact,
    "location": location,
    "category_id": categoryId,
    "start_date": "${startDate!.year.toString().padLeft(4, '0')}-${startDate!.month.toString().padLeft(2, '0')}-${startDate!.day.toString().padLeft(2, '0')}",
    "end_date": "${endDate!.year.toString().padLeft(4, '0')}-${endDate!.month.toString().padLeft(2, '0')}-${endDate!.day.toString().padLeft(2, '0')}",
    "start_time": startTime,
    "end_time": endTime,
    "timezone": timezone,
    "start_date_time_utc": startDateTimeUtc?.toIso8601String(),
    "end_date_time_utc": endDateTimeUtc?.toIso8601String(),
    "exceptions": exceptions,
    "event_date": eventDate,
    "event_repeat": eventRepeat,
    "alert": alert,
    "occurance_date_utc": "${occuranceDateUtc!.year.toString().padLeft(4, '0')}-${occuranceDateUtc!.month.toString().padLeft(2, '0')}-${occuranceDateUtc!.day.toString().padLeft(2, '0')}",
    "occurance_times_utc": occuranceTimesUtc,
    "notification_date_utc": notificationDateUtc,
    "notification_times_utc": notificationTimesUtc,
    "notes": notes,
    "fieldsData": fieldsData,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
    "event_images": eventImages == null ? [] : List<dynamic>.from(eventImages!.map((x) => x.toJson())),
    "fieldsResponse": fieldsResponse == null ? [] : List<dynamic>.from(fieldsResponse!.map((x) => x.toJson())),
    "is_my_event": isMyEvent,
  };
}

class EventImage {
  int? id;
  String? image;

  EventImage({
    this.id,
    this.image,
  });

  EventImage copyWith({
    int? id,
    String? image,
  }) =>
      EventImage(
        id: id ?? this.id,
        image: image ?? this.image,
      );

  factory EventImage.fromJson(Map<String, dynamic> json) => EventImage(
    id: json["id"],
    image: json["image"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "image": image,
  };
}

// class FieldsResponse {
//   int? id;
//   String? value;
//   String? label;
//   String? type;
//   List<String>? values;
//   int? parentId;
//   String? conditionValue;
//
//   FieldsResponse({
//     this.id,
//     this.value,
//     this.label,
//     this.type,
//     this.values,
//     this.parentId,
//     this.conditionValue,
//   });
//
//   FieldsResponse copyWith({
//     int? id,
//     String? value,
//     String? label,
//     String? type,
//     List<String>? values,
//     int? parentId,
//     String? conditionValue,
//   }) =>
//       FieldsResponse(
//         id: id ?? this.id,
//         value: value ?? this.value,
//         label: label ?? this.label,
//         type: type ?? this.type,
//         values: values ?? this.values,
//         parentId: parentId ?? this.parentId,
//         conditionValue: conditionValue ?? this.conditionValue,
//       );
//
//   factory FieldsResponse.fromJson(Map<String, dynamic> json) => FieldsResponse(
//     id: json["id"],
//     value: json["value"],
//     label: json["label"],
//     type: json["type"],
//     values: json["values"] == null ? [] : List<String>.from(json["values"]!.map((x) => x)),
//     parentId: json["parent_id"],
//     conditionValue: json["condition_value"],
//   );
//
//   Map<String, dynamic> toJson() => {
//     "id": id,
//     "value": value,
//     "label": label,
//     "type": type,
//     "values": values == null ? [] : List<dynamic>.from(values!.map((x) => x)),
//     "parent_id": parentId,
//     "condition_value": conditionValue,
//   };
// }
