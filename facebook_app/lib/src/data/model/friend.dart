import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:facebook_app/src/data/base_type/friend_status.dart';

import 'user.dart';

class Friend {
  UserEntity userFirst = UserEntity.origin();
  UserEntity userSecond = UserEntity.origin();
  String created = '';
  String modified = '';
  FriendStatus status = FriendStatus.none;

  Friend.origin();

  Friend(this.userFirst, this.userSecond, this.created, this.modified,
      this.status);

  Friend.fromJson(
    Map map,
    UserEntity userFirst,
    UserEntity userScond,
  ) {
    this.userFirst = userFirst;
    this.userSecond = userScond;
    this.status = FriendStatus.values[int.parse(map['status'].toString())];
    this.created = map['created'];
    this.modified = map['modified'];
  }

  Map friendToMap(DocumentReference userFirst, DocumentReference userSecond) =>
      new Map<String, dynamic>.from({
        "first_user": userFirst,
        "second_user": userSecond,
        "status": this.status.index,
        "created": this.created,
        "modified": this.modified,
      });

  // static List<Map> friendToListMap(List<Friend> friends) {
  //   List<Map> friendMap = [];
  //   friends.forEach((Friend friend) {
  //     Map step = friend.friendToMap();
  //     friendMap.add(step);
  //   });
  //   return friendMap;
  // }

}
