

import 'package:facebook_app/src/data/base_type/notification_type.dart';

import '../post.dart';
import '../user.dart';
import 'notification_post.dart';

class NotificationLikePost extends NotificationPost {
  NotificationLikePost(String id, Post post, UserEntity userFirst,
      String updateTime, double others, List<String> receivers)
      : super(id, post, userFirst, updateTime, NotificationType.likePost,
            others, receivers);

  @override
  String getContent({String userId}) {
    if (others > 0) {
      if (userId == post.owner.id)
        return "và  ${others.toInt()} người khác  đã thích bài viết của bạn";
      else
        return "và ${others.toInt()} người khác đã thích bài viết của bạn đang theo dõi";
    } else {
      if (userId == post.owner.id)
        return " đã thích bài viết của bạn";
      else
        return " đã thích bài viết bạn đang theo dõi";
    }
  }
}
