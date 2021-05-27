import 'package:facebook_app/src/base/base.dart';
import 'package:facebook_app/src/components/black_background_show_image.dart';
import 'package:facebook_app/src/components/separator_widget.dart';
import 'package:facebook_app/src/data/model/friend.dart';
import 'package:facebook_app/src/data/model/user.dart';
import 'package:facebook_app/src/data/repository/user_repository_impl.dart';
import 'package:facebook_app/src/view/friend/components/list_friend.dart';
import 'package:facebook_app/src/view/post/post_widget_friend.dart';
import 'package:facebook_app/src/viewmodel/friend_profile_view_model.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

import '../chat/chat_detail/chat_detailv2.dart';
import 'component/friend_grid.dart';
import 'component/setting_profile_friend.dart';

class ProfileFriend extends PageProvideNode<ProfileFriendProvide> {
  ProfileFriend(UserEntity entity) : super(params: [entity]);

  @override
  Widget buildContent(BuildContext context) {
    return ProfilePageTmp(mProvider);
  }
}

class ProfilePageTmp extends StatefulWidget {
  final ProfileFriendProvide provide;

  ProfilePageTmp(this.provide) {
    provide.initChild();
  }

  @override
  State<StatefulWidget> createState() => _ProfileFriend();
}

class _ProfileFriend extends State<ProfilePageTmp>
    with SingleTickerProviderStateMixin {
  ProfileFriendProvide provide;
  UserEntity currentUser = UserRepositoryImpl.currentUser;
  int status = 0;

  _ProfileFriend();

  @override
  void initState() {
    super.initState();
    provide = widget.provide;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(
            color: Colors.black, //change your color here
          ),
          title: Text(
            provide.userEntity.firstName + " " + provide.userEntity.lastName,
            style: TextStyle(color: Colors.black.withOpacity(1.0)),
          ),
          backgroundColor: Colors.white,
        ),

        // var images = buildFriends();
        body: SingleChildScrollView(
          child: Consumer<ProfileFriendProvide>(
            builder: (context, value, child) {
              return Column(
                children: <Widget>[
                  Container(
                    height: 450.0,
                    child: Stack(
                      children: <Widget>[
                        Padding(
                          padding:
                              EdgeInsets.only(top: 15.0, left: 10, right: 10),
                          child:
                              new Stack(fit: StackFit.loose, children: <Widget>[
                            new Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              BlackBackgroundShowImage(
                                                  value.userEntity.coverImage)),
                                    );
                                  },
                                  child: Container(
                                      width: MediaQuery.of(context).size.width -
                                          30,
                                      height: 200.0,
                                      decoration: new BoxDecoration(
                                          image: DecorationImage(
                                              image: NetworkImage(
                                                  value.userEntity.coverImage),
                                              fit: BoxFit.cover),
                                          borderRadius: BorderRadius.only(
                                              topLeft: Radius.circular(10.0),
                                              topRight:
                                                  Radius.circular(10.0)))),
                                ),
                              ],
                            ),
                          ]),
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: <Widget>[
                            Padding(
                              padding: EdgeInsets.only(top: 20.0),
                              child: new Stack(fit: StackFit.loose, children: <
                                  Widget>[
                                new Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    new GestureDetector(
                                      onTap: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  BlackBackgroundShowImage(
                                                      value.userEntity.avatar)),
                                        );
                                      },
                                      child: Container(
                                          width: 200.0,
                                          height: 200.0,
                                          margin: EdgeInsets.only(top: 50.0),
                                          decoration: new BoxDecoration(
                                            border: Border.all(
                                                width: 5,
                                                color: Theme.of(context)
                                                    .scaffoldBackgroundColor),
                                            shape: BoxShape.circle,
                                            image: new DecorationImage(
                                              image: NetworkImage(
                                                  value.userEntity.avatar),
                                              fit: BoxFit.cover,
                                            ),
                                          )),
                                    ),
                                  ],
                                ),
                              ]),
                            ),
                            SizedBox(height: 20.0),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Text(
                                    value.userEntity.firstName +
                                        " " +
                                        value.userEntity.lastName,
                                    style: TextStyle(
                                        fontSize: 24.0,
                                        fontWeight: FontWeight.bold)),
                                SizedBox(
                                  width: 5.0,
                                ),
                                Icon(
                                  Icons.check_circle,
                                  color: Colors.blueAccent,
                                )
                              ],
                            ),
                            if (value.userEntity.description != null)
                              SizedBox(height: 5.0),
                            if (value.userEntity.description != null)
                              Text(
                                value.userEntity.description,
                                style: TextStyle(
                                    fontSize: 16.0, color: Colors.grey),
                                textAlign: TextAlign.center,
                              ),
                            SizedBox(height: 15.0),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: <Widget>[
                                if (checkFriend())
                                  buildDestroyFriend(value)
                                else if (checkWaitingFriend()) //tra loi ket ban
                                  buildReply(value)
                                else if (checkRequestFriend()) //huy loi moi
                                  buildCancelRequest(value)
                                else
                                  buildSendResquest(value),
                                GestureDetector(
                                    onTap: () => Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                ChatDetail(provide.userEntity),
                                          ),
                                        ),
                                    child: Container(
                                      margin: const EdgeInsets.only(right: 6.0),
                                      height: 40.0,
                                      width: 50.0,
                                      decoration: BoxDecoration(
                                          color: Colors.grey[300],
                                          borderRadius:
                                              BorderRadius.circular(5.0)),
                                      child: Icon(
                                          FontAwesomeIcons.facebookMessenger),
                                    )),
                                GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                SettingProfileFriend(value)),
                                      );
                                    },
                                    child: Container(
                                      margin:
                                          const EdgeInsets.only(right: 15.0),
                                      height: 40.0,
                                      width: 50.0,
                                      decoration: BoxDecoration(
                                          color: Colors.grey[300],
                                          borderRadius:
                                              BorderRadius.circular(5.0)),
                                      child: Icon(Icons.more_horiz),
                                    ))
                              ],
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(15.0, 0.0, 15.0, 0.0),
                    child: Divider(height: 40.0),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 15.0),
                    child: Column(
                      children: <Widget>[
                        if (value.userEntity.city != "")
                          Row(
                            children: <Widget>[
                              Icon(Icons.home, color: Colors.grey, size: 30.0),
                              SizedBox(width: 10.0),
                              Text("Sống tại ",
                                  style: TextStyle(fontSize: 16.0)),
                              Text(value.userEntity.city,
                                  style: TextStyle(
                                      fontSize: 16.0,
                                      fontWeight: FontWeight.bold))
                            ],
                          ),
                        if (value.userEntity.city != "") SizedBox(height: 15.0),
                        if (value.userEntity.city != "")
                          Row(
                            children: <Widget>[
                              Icon(Icons.location_on,
                                  color: Colors.grey, size: 30.0),
                              SizedBox(width: 10.0),
                              Text("Đến từ ", style: TextStyle(fontSize: 16.0)),
                              Text(value.userEntity.city,
                                  style: TextStyle(
                                      fontSize: 16.0,
                                      fontWeight: FontWeight.bold))
                            ],
                          ),
                        SizedBox(height: 15.0),
                        Row(
                          children: <Widget>[
                            Icon(Icons.more_horiz,
                                color: Colors.grey, size: 30.0),
                            SizedBox(width: 10.0),
                            Text('Xem thêm thông tin',
                                style: TextStyle(fontSize: 16.0))
                          ],
                        ),
                      ],
                    ),
                  ),
                  Divider(height: 40.0),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 15.0),
                    child: Column(
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text('Bạn bè',
                                    style: TextStyle(
                                        fontSize: 22.0,
                                        fontWeight: FontWeight.bold)),
                                SizedBox(height: 6.0),
                                Text(
                                    value.friends.length.toString() +
                                        ' người bạn',
                                    style: TextStyle(
                                        fontSize: 16.0,
                                        color: Colors.grey[800])),
                              ],
                            ),
                            // Text('Tìm bạn bè',
                            //     style: TextStyle(
                            //         fontSize: 16.0, color: Colors.blue)),
                          ],
                        ),
                        // Future.delayed(const Duration(milliseconds: 10), checkFriend("123"))

                        FriendGrid(
                            friends: value.friends,
                            onImageClicked: null,
                            onExpandClicked: null),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ListUserFriend(
                                      value.userEntity)),
                            );
                          },
                          child: Container(
                            margin: EdgeInsets.symmetric(vertical: 15.0),
                            height: 40.0,
                            decoration: BoxDecoration(
                              color: Colors.grey[300],
                              borderRadius: BorderRadius.circular(5.0),
                            ),
                            child: Center(
                                child: Text('Xem tất cả bạn bè',
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16.0))),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SeparatorWidget(),
                  ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: value.userListPost.length,
                      itemBuilder: (context, index) {
                        return PostWidgetFriend(
                            post: value.userListPost[index], provide: value);
                      }),
                ],
              );
            },
          ),
        ));
  }

  ListTile _createTile(
      BuildContext context, String name, Icon icon, Function action) {
    return ListTile(
      leading: icon,
      title: Text(name),
      onTap: () {
        Navigator.pop(context);
        action();
      },
    );
  }

  _action1() {
    print('action 1');
  }

  bool checkFriend() {
    Friend fr = provide.friends.firstWhere((element) {
      return (element.userSecond.id == currentUser.id);
    }, orElse: () => null);
    if (fr != null)
      return true;
    else
      return false;
  }

  bool checkRequestFriend() {
    print('friend request user ${provide.friendRequest.length}');
    Friend fr = provide.friendRequest.firstWhere((element) {
      return (element.userSecond.id == currentUser.id);
    }, orElse: () => null);
    if (fr != null)
      return true;
    else
      return false;
  }

  bool checkWaitingFriend() {
    Friend fr = provide.friendWaitConfirm.firstWhere((element) {
      return (element.userSecond.id == currentUser.id);
    }, orElse: () => null);
    if (fr != null)
      return true;
    else
      return false;
  }

  //lay friend voi currentUser (da la ban be)
  Friend getFriendWithCurrentUser() {
    return provide.friends
        .firstWhere((element) => element.userSecond.id == currentUser.id);
  }

  //lay friend voi currentUser (gui cho current)
  Friend getFriendWithCurrentUser2() {
    return provide.friendWaitConfirm
        .firstWhere((element) => element.userSecond.id == currentUser.id);
  }

  //lay friend voi currentUser (current gui)
  Friend getFriendWithCurrentUser3() {
    return provide.friendRequest
        .firstWhere((element) => element.userSecond.id == currentUser.id);
  }

  Widget buildFriendButton(ProfileFriendProvide value) {
    print('build lai ${status}');
    if (checkFriend()) {
      return buildDestroyFriend(value);
    } else if (checkWaitingFriend()) {
      return buildReply(value);
    } else if (checkRequestFriend()) {
      return buildCancelRequest(value);
    } else if (status == 4) {
      return buildSendResquest(value);
    }
  }

  //huy ket ban
  GestureDetector buildDestroyFriend(ProfileFriendProvide value) {
    return GestureDetector(
      onTap: () {
        value.friendRepository.deleteRequest(getFriendWithCurrentUser(), () {});
        setState(() {
          status = 4;
          provide.notifyListeners();
        });
      },
      child: Container(
        margin: const EdgeInsets.only(right: 6.0),
        height: 40.0,
        width: MediaQuery.of(context).size.width - 150,
        decoration: BoxDecoration(
            color: Colors.blue, borderRadius: BorderRadius.circular(5.0)),
        child: Center(
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Icon(
                FontAwesomeIcons.userTimes,
                color: Colors.white,
                size: 22.0,
              ),
              Text('  Hủy kết bạn',
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 16.0)),
            ],
          ),
        ),
      ),
    );
  }

  //tra loi loi moi
  GestureDetector buildReply(ProfileFriendProvide value) {
    return GestureDetector(
      onTap: () {
        showModalBottomSheet(
            context: context,
            builder: (builder) {
              return new Container(
                // height: 350.0,
                color: Color(0xFF737373),
                child: new Container(
                    decoration: new BoxDecoration(
                        color: Colors.white,
                        borderRadius: new BorderRadius.only(
                            topLeft: const Radius.circular(10.0),
                            topRight: const Radius.circular(10.0))),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        ListTile(
                          leading: Icon(
                            Icons.check,
                            color: Colors.black,
                          ),
                          title: Text('Đồng ý'),
                          onTap: () {
                            Navigator.pop(context);
                            value.friendRepository.acceptRequest(
                                getFriendWithCurrentUser2(), () {});
                          },
                        ),
                        ListTile(
                          leading: Icon(
                            Icons.close,
                            color: Colors.black,
                          ),
                          title: Text('Từ chối'),
                          onTap: () {
                            Navigator.pop(context);
                            value.friendRepository.deleteRequest(
                                getFriendWithCurrentUser2(), () {});
                            setState(() {
                              status = 4;
                              provide.notifyListeners();
                            });
                          },
                        ),
                      ],
                    )),
              );
            });
      },
      child: Container(
        margin: const EdgeInsets.only(right: 6.0),
        height: 40.0,
        width: MediaQuery.of(context).size.width - 150,
        decoration: BoxDecoration(
            color: Colors.blue, borderRadius: BorderRadius.circular(5.0)),
        child: Center(
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Icon(
                FontAwesomeIcons.userCheck,
                color: Colors.white,
                size: 22.0,
              ),
              Text('  Trả lời',
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 16.0)),
            ],
          ),
        ),
      ),
    );
  }

  //huy loi moi
  GestureDetector buildCancelRequest(ProfileFriendProvide value) {
    return GestureDetector(
      onTap: () {
        value.friendRepository
            .deleteRequest(getFriendWithCurrentUser3(), () {});
        setState(() {
          status = 4;
          provide.notifyListeners();
        });
      },
      child: Container(
        margin: const EdgeInsets.only(right: 6.0),
        height: 40.0,
        width: MediaQuery.of(context).size.width - 150,
        decoration: BoxDecoration(
            color: Colors.blue, borderRadius: BorderRadius.circular(5.0)),
        child: Center(
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Icon(
                FontAwesomeIcons.userMinus,
                color: Colors.white,
                size: 22.0,
              ),
              Text('  Hủy lời mời',
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 16.0)),
            ],
          ),
        ),
      ),
    );
  }

  //gui loi moi
  GestureDetector buildSendResquest(ProfileFriendProvide value) {
    return GestureDetector(
      onTap: () {
        value.friendRepository
            .createRequestFriend(currentUser, value.userEntity.id, () {});
      },
      child: Container(
        margin: const EdgeInsets.only(right: 6.0),
        height: 40.0,
        width: MediaQuery.of(context).size.width - 150,
        decoration: BoxDecoration(
            color: Colors.blue, borderRadius: BorderRadius.circular(5.0)),
        child: Center(
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Icon(
                FontAwesomeIcons.userPlus,
                color: Colors.white,
                size: 22.0,
              ),
              Text('  Gửi lời mời',
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 16.0)),
            ],
          ),
        ),
      ),
    );
  }
}
