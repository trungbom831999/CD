import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:facebook_app/src/data/base_type/notification_type.dart';

import '../post.dart';
import '../user.dart';
import 'notification_friend.dart';


abstract class NotificationPost extends NotificationApp {
  Post post = Post.origin();

  String getContent({String userId});

  NotificationPost(
      String id,
      this.post,
      UserEntity userFirst,
      String updateTime,
      NotificationType type,
      double others,
      List<String> receivers)
      : super(id, userFirst, updateTime, type, others, receivers);

  @override
  NotificationPost.fromJson(Map map, UserEntity userFirst, Post post,
      {UserEntity userSecond})
      : super.fromJson(map, userFirst) {
    this.post = post;
  }

  Map toMap(DocumentReference userFirst,
          {DocumentReference post}) =>
      new Map<String, dynamic>.from({
        "first_user": userFirst,
        "type": this.type.index,
        "update_time": this.updateTime,
        "others": this.others,
        "receivers": this.receivers,
        "post": post
      });
}
