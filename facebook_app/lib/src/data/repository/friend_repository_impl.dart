import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:facebook_app/src/data/model/friend.dart';
import 'package:facebook_app/src/data/model/user.dart';
import 'package:facebook_app/src/data/source/remote/fire_base_friend.dart';
import 'package:facebook_app/src/data/source/remote/fire_base_notification.dart';

import 'friend_repository.dart';

class FriendRepositoryImpl extends FriendRepository {
  final FirFriend _firFriend;
  final FirNotification _firNotification;

  FriendRepositoryImpl(this._firFriend, this._firNotification);

  //dong y ket ban
  @override
  acceptRequest(Friend friend, Function onError) {
    _firFriend.acceptRequest(friend, onError);
    _firNotification.createNotificationFriend(
        friend.userSecond, friend.userFirst.id);
  }

  //xoa ket ban
  deleteRequest(Friend friend, Function onError) {
    _firFriend.deleteRequest(friend, onError);
    // _firNotification.createNotificationFriend(
    //     friend.userSecond, friend.userFirst.id);
  }

  //tao ket ban
  @override
  createRequestFriend(
      UserEntity userFirst, String idUserSecond, Function onError) {
    _firFriend.createRequestFriend(userFirst.id, idUserSecond, onError);
    _firNotification.createNotificationRequestFriend(userFirst, idUserSecond);
  }

  @override
  Stream<QuerySnapshot> getFriends(String id) {
    return _firFriend.getFriends(id);
  }

  Stream<QuerySnapshot> getNotFriends(String id) {
    return _firFriend.getNotFriends(id);
  }

  @override
  Stream<QuerySnapshot> getRequestFriends(String id) {
    return _firFriend.getRequestFriends(id);
  }

  @override
  Stream<QuerySnapshot> getRequestedFriends(String id) {
    return _firFriend.getRequestedFriends(id);
  }
}
