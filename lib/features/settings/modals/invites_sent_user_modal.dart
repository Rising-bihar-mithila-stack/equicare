class InvitesSentUserModal {
  int? id;
  int? byUserId;
  String? toEmail;
  String? status;
  String? createdAt;
  String? updatedAt;

  InvitesSentUserModal({
    this.id,
    this.byUserId,
    this.toEmail,
    this.status,
    this.createdAt,
    this.updatedAt,
  });

  factory InvitesSentUserModal.fromJson(Map<String, dynamic> json) {
    return InvitesSentUserModal(
      id: json['id'] as int?,
      byUserId: json['by_user_id'] as int?,
      toEmail: json['to_email'] as String?,
      status: json['status'] as String?,
      createdAt: json['created_at'] as String?,
      updatedAt: json['updated_at'] as String?,
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'by_user_id': byUserId,
        'to_email': toEmail,
        'status': status,
        'created_at': createdAt,
        'updated_at': updatedAt,
      };
}
