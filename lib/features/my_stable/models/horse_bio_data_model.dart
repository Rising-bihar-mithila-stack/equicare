class HorseBioDataModel {
  String? icon;
  String? title;
  String? info;

  HorseBioDataModel({this.icon, this.title, this.info});

  factory HorseBioDataModel.fromJson(Map<String, dynamic> json) {
    return HorseBioDataModel(
      icon: json['icon'] as String?,
      title: json['title'] as String?,
      info: json['info'] as String?,
    );
  }

  Map<String, dynamic> toJson() => {
        'icon': icon,
        'title': title,
        'info': info,
      };

  HorseBioDataModel copyWith({
    String? icon,
    String? title,
    String? info,
  }) {
    return HorseBioDataModel(
      icon: icon ?? this.icon,
      title: title ?? this.title,
      info: info ?? this.info,
    );
  }
}
