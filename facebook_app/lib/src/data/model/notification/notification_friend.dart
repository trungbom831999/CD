import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:facebook_app/src/data/base_type/notification_type.dart';

import '../user.dart';

abstract class NotificationApp {
  String id = "";
  UserEntity userFirst = UserEntity.origin();
  String updateTime = "";
  NotificationType type = NotificationType.requestFriend;
  List<String> receivers = [];
  double others = 0;

  NotificationApp.origin();

  NotificationApp(this.id, this.userFirst, this.updateTime, this.type,
      this.others, this.receivers);

  String getContent({String userId});

  NotificationApp.fromJson(
    Map map,
    UserEntity userFirst,
  ) {
    this.userFirst = userFirst;
    this.id = map['id'];
    this.type = NotificationType.values[int.parse(map['type'].toString())];
    this.updateTime = map['update_time'];
    this.others = map['others'];
    this.receivers =
        (map['receivers'] as List).map((e) => e.toString()).toList();
  }

  Map toMap(DocumentReference userFirst) => new Map<String, dynamic>.from({
        "id": this.id,
        "first_user": userFirst,
        "type": this.type.index,
        "update_time": this.updateTime,
        "others": this.others,
        "receivers": this.receivers,
      });
}
