import 'package:facebook_app/src/data/model/user.dart';

import 'messages.dart';

class Conservation {
  String id;
  Message currentMessage = Message.origin();

  Conservation.origin();

  Conservation(
      this.id,
      this.currentMessage,
      );

  Conservation.fromMap(Map map, UserEntity first, UserEntity second) {
    this.id = map['id'];
    this.currentMessage = Message.fromMap(map['current_message'], first, second);
  }

  UserEntity checkFriend(String userId){
    if(currentMessage.from.id == userId) return currentMessage.to;
    return currentMessage.from;
  }

  static List<Conservation> fromListMap(
      List<Map> maps, UserEntity fist, UserEntity second) {
    List<Conservation> conservations = [];
    maps.forEach((element) {
      conservations.add(Conservation.fromMap(element, fist, second));
    });
    return conservations;
  }
}
