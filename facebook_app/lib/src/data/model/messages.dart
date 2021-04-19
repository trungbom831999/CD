import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:facebook_app/src/data/base_type/message_type.dart';
import 'package:facebook_app/src/data/model/user.dart';

class Message {

  String message = '';
  String sendTime = '';
  UserEntity from = UserEntity.origin();
  UserEntity to = UserEntity.origin();
  MessageType type = MessageType.text;

  Message.origin();

  Message(
    this.from,
    this.to,
    this.message,
    this.sendTime,
    this.type,
  );

  Message.fromMap(Map map, UserEntity from, UserEntity to) {
    this.message = map['message'];
    this.sendTime = map['send_time'];
    this.type =  MessageType.values[int.parse(map['type'].toString())];
    this.from = from;
    this.to = to;
  }

  Map toMap(DocumentReference from, DocumentReference to) =>
      new Map<String, dynamic>.from({
        "message": this.message,
        "send_time": this.sendTime,
        "type": this.type.index,
        "from": from,
        "to": to
      });

// static List<Map> toListMap(
//     List<Post> posts, DocumentReference documentReference) {
//   List<Map> maps = [];
//   posts.forEach((Post post) {
//     Map step = post.postToMap(documentReference);
//     maps.add(step);
//   });
//   return maps;
// }

  static List<Message> fromListMap(
      List<Map> maps, UserEntity from, UserEntity to) {
    List<Message> messages = [];
    maps.forEach((element) {
      messages.add(Message.fromMap(element, from, to));
    });
    return messages;
  }
}
