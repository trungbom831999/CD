import 'package:facebook_app/src/data/model/user.dart';

class Comment {
  UserEntity user = UserEntity.origin();
  String comment = "";
  String created = '';

  Comment.origin();

  Comment(this.user, this.comment, this.created);

  Comment.fromJson(Map map) {
    this.user = UserEntity.fromJson(map['user']);
    this.created = map['created'];
    this.comment = map['comment'];
  }

  Map toMap() => new Map<String, dynamic>.from({
        "user": this.user.userToMap(),
        "created": this.created,
        "comment": this.comment,
      });

  static List<Map> toListMap(List<Comment> comments) {
    List<Map> maps = [];
    comments.forEach((Comment comment) {
      Map step = comment.toMap();
      maps.add(step);
    });
    return maps;
  }

  static List<Comment> fromListMap(List<Map> maps) {
    List<Comment> comments = [];
    maps.forEach((element) {
      comments.add(Comment.fromJson(element));
    });
    return comments;
  }
}
