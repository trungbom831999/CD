import 'package:facebook_app/src/viewmodel/chat_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:facebook_app/src/data/model/user.dart';
import 'package:facebook_app/src/view/chat/chat_detail/chat_detailv3.dart';
import 'package:facebook_app/src/data/model/conservation.dart';
import 'package:intl/intl.dart';
import 'package:facebook_app/src/data/repository/user_repository_impl.dart';
import 'package:facebook_app/src/ultils/string_ext.dart';
class ConversationItem extends StatelessWidget {
  final ChatProvide provide;
  final Conservation conservation;

  const ConversationItem(this.provide, this.conservation);

  @override
  Widget build(BuildContext context) {
    UserEntity friend = conservation.checkFriend(UserRepositoryImpl.currentUser.id);
    return InkWell(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ChatDetailV3(conservation, friend),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12.0),
        child: Slidable(
          actionPane: SlidableDrawerActionPane(),
          actionExtentRatio: 0.15,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              children: <Widget>[
                _buildConversationImage(friend),
                _buildTitleAndLatestMessage(conservation),
              ],
            ),
          ),
          actions: <Widget>[
            Padding(
              padding: EdgeInsets.only(left: 16.0),
              child: SlideAction(
                decoration: BoxDecoration(
                  color: Colors.blue,
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.camera_alt,
                  color: Colors.white,
                  size: 20.0,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8.0, right: 8.0),
              child: SlideAction(
                decoration: BoxDecoration(
                  color: Colors.grey.shade300,
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.phone,
                  color: Colors.black,
                  size: 20.0,
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.only(right: 16.0),
              child: SlideAction(
                decoration: BoxDecoration(
                  color: Colors.grey.shade300,
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.videocam,
                  color: Colors.black,
                  size: 20.0,
                ),
              ),
            ),
          ],
          secondaryActions: <Widget>[
            Padding(
              padding: EdgeInsets.only(left: 16.0),
              child: SlideAction(
                decoration: BoxDecoration(
                  color: Colors.grey.shade300,
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.menu,
                  color: Colors.black,
                  size: 20.0,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 8.0, right: 8.0),
              child: SlideAction(
                decoration: BoxDecoration(
                  color: Colors.grey.shade300,
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.notifications,
                  color: Colors.black,
                  size: 20.0,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(right: 16.0),
              child: SlideAction(
                decoration: BoxDecoration(
                  color: Colors.red,
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.restore_from_trash,
                  color: Colors.white,
                  size: 20.0,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  _buildTitleAndLatestMessage(Conservation conservation) {
    var friend = conservation.checkFriend(provide.userEntity.id);
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.only(left: 12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            _buildConverastionTitle(friend),
            SizedBox(height: 2),
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  _buildLatestMessage(conservation),
                  _buildTimeOfLatestMessage(conservation)
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  _buildConverastionTitle(UserEntity userEntity) {
    return Text(
      userEntity.firstName + " " + userEntity.lastName,
      style: TextStyle(
          fontSize: 14,
          color: Colors.grey.shade700,
          fontWeight: FontWeight.bold),
    );
  }

  _buildLatestMessage(Conservation conservation) {
    return Container(
      width: 150.0,
      child: Text(
        getTextMess(conservation, provide).getMyText(),
        //conservation.currentMessage.message,
        style: TextStyle(color: Colors.grey.shade700, fontSize: 14),
        overflow: TextOverflow.ellipsis,
      ),
    );
  }

  _buildTimeOfLatestMessage(Conservation conservation) {
    return Text(getTimeMess(conservation.currentMessage.sendTime),
        style: TextStyle(color: Colors.grey.shade700, fontSize: 11));
  }

  _buildConversationImage(UserEntity userEntity) {
    return Container(
      height: 50,
      width: 50,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30.0),
        image: DecorationImage(
          image: NetworkImage(userEntity.avatar),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}

String getTextMess(Conservation conservation, ChatProvide provide) {
  var friend = conservation.checkFriend(provide.userEntity.id);
  if (friend.id == conservation.currentMessage.to.id) {
    String a = "Bạn: " + conservation.currentMessage.message;
    int n = a.length;
    if (n > 20) {
      a = a.substring(0, 17) + "...";
      return a;
    } else
      return a;
  } else {
    String a = conservation.currentMessage.message;
    int n = a.length;
    if (n > 20) {
      a = a.substring(0, 17) + "...";
      return a;
    } else
      return a;
  }
}

String getTimeMess(String sendTime) {
  var Now = (new DateTime.now());
  var format = new DateFormat('yyyy-MM-dd');

  String now = DateFormat('yyyy-MM-dd').format(Now);
  // print("hôm nay là $now");

  String past = format.parse(sendTime).toString();
  int n = past.length;
  int k = -1;
  for (int j = 0; j < n; j++) {
    if (past[j] == " ") {
      k = j;
      break;
    }
  }
  past = past.substring(0, k);
  String past2 = past;
  // print("hôm nay là 11 $past 1");

  if (past == now) {
    format = new DateFormat('yyyy-MM-dd HH:mm:ss');
    String s = format.parse(sendTime).toString();
    n = s.length;
    int k1 = -1, k2 = -1;
    for (int j = 0; j < n; j++) {
      if (s[j] == " ") {
        k1 = j;
      }
      if (s[j] == ":") {
        k2 = j;
      }
    }
    //print("hôm nay là ssss $s");
    s = s.substring(0, k2);
    s = s.substring(k1, k2);
    //print("hôm nay là ssss $s");
    return s;
  } else {
    DateTime s = format.parse(sendTime);
    String a = DateFormat('E').format(s);
    if (a == "Mon")
      return "T.2";
    else if (a == "Tue")
      return "T.3";
    else if (a == "Wed")
      return "T.4";
    else if (a == "Thu")
      return "T.5";
    else if (a == "Fri")
      return "T.6";
    else if (a == "Sat")
      return "T.7";
    else
      return "CN";
  }
}
