import 'package:facebook_app/src/data/model/user.dart';
import 'package:facebook_app/src/data/repository/friend_repository.dart';
import 'package:facebook_app/src/data/repository/notification_repository.dart';
import 'package:facebook_app/src/data/repository/photo_repository.dart';
import 'package:facebook_app/src/data/repository/post_repository.dart';
import 'package:facebook_app/src/data/repository/user_repository.dart';
import 'package:facebook_app/src/viewmodel/profile_view_model.dart';

class ProfileFriendProvide extends ProfileProvide {
  ProfileFriendProvide(
      PostRepository repository,
      PhotoRepository photoRepository,
      UserRepository userRepository,
      FriendRepository friendRepository,
      NotificationRepository notificationRepository,
      UserEntity entity)
      : super(repository, photoRepository, userRepository, friendRepository,
            notificationRepository) {
    userEntity = entity;
  }

  void initChild() {
     print('init child');
    getFriends(userEntity);
    // getNotFriends(userEntity);
    getFriendsRequest(userEntity);
    getFriendsWaitConfirm(userEntity);
    getUserListPost(userEntity.id);
    getUserPhotos(userEntity.id);
    getUserVideos(userEntity.id);
  }
}
