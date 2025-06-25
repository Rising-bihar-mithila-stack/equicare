class EventTypeCategoryModel {
  int? id;
  String? name;
  String? slug;
  int? eventTypeId;

  EventTypeCategoryModel({this.id, this.name, this.slug, this.eventTypeId});

  factory EventTypeCategoryModel.fromJson(Map<String, dynamic> json) =>
      EventTypeCategoryModel(
        id: json['id'] as int?,
        name: json['name'] as String?,
        slug: json['slug'] as String?,
        eventTypeId: json['event_type_id'] as int?,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'slug': slug,
        'event_type_id': eventTypeId,
      };

  EventTypeCategoryModel copyWith({
    int? id,
    String? name,
    String? slug,
    int? eventTypeId,
  }) {
    return EventTypeCategoryModel(
      id: id ?? this.id,
      name: name ?? this.name,
      slug: slug ?? this.slug,
      eventTypeId: eventTypeId ?? this.eventTypeId,
    );
  }
}
