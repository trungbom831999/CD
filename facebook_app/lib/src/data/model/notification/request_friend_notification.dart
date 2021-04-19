
import 'package:facebook_app/src/data/base_type/notification_type.dart';

import '../user.dart';
import 'notification_friend.dart';

class NotificationRequestFriend extends NotificationApp {
  NotificationRequestFriend(String id, UserEntity userFirst, String updateTime,
      double others, List<String> receivers)
      : super(id, userFirst, updateTime, NotificationType.requestFriend, others,
            receivers);

  @override
  String getContent({String userId}) => "đã gửi cho bạn một lời mời kết bạn";
}
