import 'package:facebook_app/src/data/base_type/notification_type.dart';
import '../user.dart';
import 'notification_friend.dart';

class NotificationAcceptFriend extends NotificationApp {
  NotificationAcceptFriend(String id, UserEntity userFirst, String updateTime,
      double others, List<String> receivers)
      : super(id, userFirst, updateTime, NotificationType.acceptFriend, others,
            receivers);

  @override
  String getContent({String userId}) => "đã chấp nhận lời mời kết bạn của bạn";
}
