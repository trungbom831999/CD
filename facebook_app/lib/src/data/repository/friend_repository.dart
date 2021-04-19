import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:facebook_app/src/data/model/friend.dart';
import 'package:facebook_app/src/data/model/user.dart';

abstract class FriendRepository {
  createRequestFriend(
      UserEntity userFirst, String idUserSecond, Function onError);

  acceptRequest(Friend friend, Function onError);

  deleteRequest(Friend friend, Function onError);

  Stream<QuerySnapshot> getFriends(String id);

  Stream<QuerySnapshot> getNotFriends(String id);

  Stream<QuerySnapshot> getRequestFriends(String id);

  Stream<QuerySnapshot> getRequestedFriends(String id);
}
