// To parse this JSON data, do
//
//     final eventFieldsModel = eventFieldsModelFromJson(jsonString);

import 'dart:convert';

EventFieldsModel eventFieldsModelFromJson(String str) => EventFieldsModel.fromJson(json.decode(str));

String eventFieldsModelToJson(EventFieldsModel data) => json.encode(data.toJson());

class EventFieldsModel {
  int? id;
  int? eventTypeId;
  String? label;
  String? type;
  String? value;
  List<String>? values;
  dynamic parentId;
  dynamic conditionValue;
  DateTime? createdAt;
  DateTime? updatedAt;


  EventFieldsModel({
    this.id,
    this.eventTypeId,
    this.label,
    this.type,
    this.values,
    this.value,
    this.parentId,
    this.conditionValue,
    this.createdAt,
    this.updatedAt,
  });

  EventFieldsModel copyWith({
    int? id,
    int? eventTypeId,
    String? label,
    String? type,
    String? value,
    List<String>? values,
    dynamic parentId,
    dynamic conditionValue,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) =>
      EventFieldsModel(
        id: id ?? this.id,
        eventTypeId: eventTypeId ?? this.eventTypeId,
        label: label ?? this.label,
        type: type ?? this.type,
        value: type ?? this.value,
        values: values ?? this.values,
        parentId: parentId ?? this.parentId,
        conditionValue: conditionValue ?? this.conditionValue,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
      );

  factory EventFieldsModel.fromJson(Map<String, dynamic> json) => EventFieldsModel(
    id: json["id"],
    eventTypeId: json["event_type_id"],
    label: json["label"],
    type: json["type"],
    value: json["value"],
    values: json["values"] == null ? [] : List<String>.from(json["values"]!.map((x) => x)),
    parentId: json["parent_id"],
    conditionValue: json["condition_value"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "event_type_id": eventTypeId,
    "label": label,
    "type": type,
    "value": value,
    "values": values == null ? [] : List<dynamic>.from(values!.map((x) => x)),
    "parent_id": parentId,
    "condition_value": conditionValue,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
  };
}
