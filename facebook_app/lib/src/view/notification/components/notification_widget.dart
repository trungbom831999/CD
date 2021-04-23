import 'package:facebook_app/src/data/model/notification/accept_friend_notification.dart';
import 'package:facebook_app/src/data/model/notification/notification_post.dart';
import 'package:facebook_app/src/data/model/notification/request_friend_notification.dart';
import 'package:facebook_app/src/data/model/user.dart';
import 'package:facebook_app/src/view/post/post_detail.dart';
import 'package:facebook_app/src/view/profile/profile_friend.dart';
import 'package:facebook_app/src/viewmodel/home_view_model.dart';
import 'package:flutter/material.dart';
import 'package:facebook_app/src/data/model/notification/notification_friend.dart';
import 'package:intl/intl.dart';

class NotificationWidget extends StatelessWidget {
  NotificationApp notification;
  final UserEntity userEntity;
  final HomeProvide provide;
  NotificationWidget(this.notification, this.userEntity, this.provide);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if (notification is NotificationAcceptFriend ||
            notification is NotificationRequestFriend) {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => ProfileFriend(notification.userFirst)));
        } else {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => PostDetail(post: (notification as NotificationPost).post, provide: provide,)));
        }
      },
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: 100.0,
        padding: EdgeInsets.symmetric(horizontal: 15.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                CircleAvatar(
                  backgroundImage: NetworkImage(notification.userFirst.avatar),
                  radius: 35.0,
                ),
                SizedBox(width: 15.0),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    getContent(),
                    Text(fix(notification.updateTime),
                        style: TextStyle(fontSize: 14.0, color: Colors.grey)),
                  ],
                ),
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Icon(Icons.more_horiz),
                Text(''),
              ],
            )
          ],
        ),
      ),
    );
  }

  onTapNotification(BuildContext context, UserEntity entity) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => ProfileFriend(entity)),
    );
  }

  Widget getContent() {
    return RichText(
        text: TextSpan(
            style: TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.normal,
                color: Colors.black),
            children: [
          TextSpan(
              text:
                  '${notification.userFirst.firstName} ${notification.userFirst.lastName} ',
              style:
                  TextStyle(fontWeight: FontWeight.bold, color: Colors.black)),
          TextSpan(
              text: getText(
                  notification.getContent(userId: userEntity.id),
                  notification.userFirst.firstName.length +
                      notification.userFirst.lastName.length +
                      1))
        ]));
  }

  String fix(String text1) {
    var now = (new DateTime.now()).millisecondsSinceEpoch;
    var format = new DateFormat('yyyy-MM-dd HH:mm:ss');
    DateTime baiDang = format.parse(text1);
    var timeago = baiDang.millisecondsSinceEpoch;
    var timeagov1 = (now - timeago) / 1000;
    timeagov1 = (timeagov1 / 60 + 1);
    if (timeagov1 < 60) {
      String a = timeagov1.toStringAsFixed(0);
      return "$a phút trước";
    } else if (timeagov1 < 60 * 24) {
      String a = (timeagov1 / 60).toStringAsFixed(0);
      return "$a giờ trước";
    } else if (timeagov1 < 60 * 24 * 30) {
      String a = (timeagov1 / (60 * 24)).toStringAsFixed(0);
      return "$a ngày trước";
    } else {
      return "1 tháng trước trước";
    }
  }

  String getText(String message, int lenghtName) {
    int n = message.length;
    int dem = lenghtName + 3;
    for (int i = 0; i < n; i++) {
      if (i == n - 1) {
        dem++;
      } else {
        int j = message.substring(i + 1, n).indexOf(" ");
        if (j == -1) {
          dem++;
        } else {
          if (j >= 30) {
            //xuong dong
            message = message.substring(0, i + 30 - dem + 1) +
                "\n" +
                message.substring(i + 30 - dem + 1, n);
            dem = 0;
            n += 1;
            i += 30 - dem;
          } else if (j >= 30 - dem) {
            if (message[i] == " ") {
              message =
                  message.substring(0, i) + "\n" + message.substring(i + 1, n);
              dem = 0;
            } else {
              message =
                  message.substring(0, i) + "\n" + message.substring(i, n);
              dem = 0;
              i++;
              n++;
            }
          } else {
            dem++;
          }
        }
      }
      // đủ độ dài 30
      if (dem == 30) {
        message =
            message.substring(0, i + 2) + "\n" + message.substring(i + 2, n);
        n++;
        i++;
        dem = 0;
      }
    }
    return message;
  }
}
