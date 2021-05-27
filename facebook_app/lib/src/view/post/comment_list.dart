import 'package:facebook_app/src/data/repository/user_repository_impl.dart';
import 'package:facebook_app/src/view/profile/profile_friend.dart';
import 'package:facebook_app/src/view/profile/profile_me.dart';
import 'package:facebook_app/src/viewmodel/home_view_model.dart';
import 'package:flutter/material.dart';
import 'package:facebook_app/src/data/model/comment.dart';
import 'package:facebook_app/src/ultils/string_ext.dart';
import 'package:flutter_linkify/flutter_linkify.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:intl/intl.dart';

class CommentWidget extends StatelessWidget {
  final Comment comment;
  final HomeProvide provide;

  CommentWidget({this.comment, this.provide});

  @override
  Widget build(BuildContext context) {
    return  Container(
            padding: EdgeInsets.all(5),
            child: Row(
              children: <Widget>[
                GestureDetector(
                  onTap: () {
                    if (comment.user.id == UserRepositoryImpl.currentUser.id) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => ProfileMe()),
                      );
                    } else {
                      int status = provide.checkStatusFriend(comment.user.id);
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ProfileFriend(comment.user)),
                      );
                    }
                  },
                  child: CircleAvatar(
                    backgroundImage: NetworkImage(comment.user.avatar),
                    radius: 20.0,
                  ),
                ),
                SizedBox(width: 10.0),
                Flexible(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Row(
                        children: [
                          GestureDetector(
                            onTap: () {
                              if (comment.user.id ==
                                  UserRepositoryImpl.currentUser.id) {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => ProfileMe()),
                                );
                              } else {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          ProfileFriend(comment.user)),
                                );
                              }
                            },
                            child: Text(
                                comment.user.firstName +
                                    ' ' +
                                    comment.user.lastName,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 17.0)),
                          ),
                          SizedBox(
                            width: 5.0,
                          ),
                          Icon(
                            Icons.check_circle,
                            size: 15,
                            color: Colors.blueAccent,
                          ),
                        ],
                      ),
                      SizedBox(height: 5.0),
                      Align(
                          alignment: Alignment.centerLeft,
                          child: Container(
                            child: Linkify(
                              onOpen: (link) async {
                                if (await canLaunch(link.url)) {
                                  await launch(link.url);
                                } else {
                                  throw 'Could not launch $link';
                                }
                              },
                              text: comment.comment.getMyText(),
                              //textAlign: TextAlign.left,
                              linkStyle: TextStyle(
                                  fontSize: 15.0, color: Colors.black),
                            ),

                            // Text(comment.comment.getMyText(),
                            //     style: TextStyle(fontSize: 15.0)
                          )),
                      Text(fix(comment.created), style: TextStyle(fontSize: 13),),
                    ],
                  ),
                ),
              ],
            ),
    );
  }

  String fix(String text1) {
    var now = (new DateTime.now()).millisecondsSinceEpoch;
    var format = DateFormat('yyyy-MM-dd HH:mm:ss');
    DateTime baiDang = format.parse(text1);
    var timeago = baiDang.millisecondsSinceEpoch;
    var timeagov1 = (now - timeago) / 1000;
    timeagov1 = (timeagov1 / 60 + 1);
    if (timeagov1 < 60) {
      String a = timeagov1.toStringAsFixed(0);
      return "$a phút";
    } else if (timeagov1 < 60 * 24) {
      String a = (timeagov1 / 60).toStringAsFixed(0);
      return "$a giờ";
    } else if (timeagov1 < 60 * 24 * 30) {
      String a = (timeagov1 / (60 * 24)).toStringAsFixed(0);
      return "$a ngày";
    } else {
      return "1 tháng trước";
    }
  }
}
