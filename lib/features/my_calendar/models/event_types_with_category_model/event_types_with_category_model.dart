import 'event_type_category_model.dart';

class EventTypesWithCategoryModel {
  int? id;
  String? name;
  String? createdAt;
  String? updatedAt;
  List<EventTypeCategoryModel>? categories;

  EventTypesWithCategoryModel({
    this.id,
    this.name,
    this.createdAt,
    this.updatedAt,
    this.categories,
  });

  factory EventTypesWithCategoryModel.fromJson(Map<String, dynamic> json) {
    return EventTypesWithCategoryModel(
      id: json['id'] as int?,
      name: json['name'] as String?,
      createdAt: json['created_at'] as String?,
      updatedAt: json['updated_at'] as String?,
      categories: (json['categories'] as List<dynamic>?)
          ?.map(
              (e) => EventTypeCategoryModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'created_at': createdAt,
        'updated_at': updatedAt,
        'categories': categories?.map((e) => e.toJson()).toList(),
      };

  EventTypesWithCategoryModel copyWith({
    int? id,
    String? name,
    String? createdAt,
    String? updatedAt,
    List<EventTypeCategoryModel>? categories,
  }) {
    return EventTypesWithCategoryModel(
      id: id ?? this.id,
      name: name ?? this.name,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      categories: categories ?? this.categories,
    );
  }
}
