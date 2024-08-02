class NotificationModel {
  NotificationModel({
    final String? title,
    final String? body,
    final DateTime? date,
    final String? redirectUrl,
    final String? role,
    final String? type,
    final String? jsonData,
    final bool? read,
  });

  factory NotificationModel.fromMap(Map<String, dynamic> json) =>
      NotificationModel(
        title: json['title'] as String?,
        body: json['body'] as String?,
        date: json['date'] == null
            ? null
            : DateTime.parse(json['date'] as String),
        redirectUrl: json['redirectUrl'] as String?,
        role: json['role'] as String?,
        type: json['type'] as String?,
        jsonData: json['jsonData'] as String?,
        read: json['read'] as bool?,
      );

  // factory NotificationModel.fromEntity(NotificationEntity entity) {
  //   return NotificationModel(
  //     title: entity.title,
  //     body: entity.body,
  //     date: entity.date,
  //     redirectUrl: entity.redirectUrl,
  //     role: entity.role,
  //     type: entity.type,
  //     jsonData: entity.jsonData,
  //     read: entity.read,
  //   );
  // }

  static NotificationModel fromRemoteMessage(List<Object?>? data) {
    return NotificationModel.fromMap(data!.first! as Map<String, dynamic>);
  }
}
