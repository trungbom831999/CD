import 'dart:ui';
import 'dart:math';

import 'package:facebook_app/src/base/base.dart';
import 'package:facebook_app/src/data/model/friend.dart';
import 'package:facebook_app/src/data/model/user.dart';
import 'package:facebook_app/src/data/repository/user_repository_impl.dart';
import 'package:facebook_app/src/view/profile/profile_friend.dart';
import 'package:facebook_app/src/view/profile/profile_me.dart';
// import 'package:facebook_app/src/view/profile/profile_friend.dart';
// import 'package:facebook_app/src/view/profile/profile_me.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:facebook_app/src/viewmodel/friend_profile_view_model.dart';
import 'package:provider/provider.dart';

class ListUserFriend extends PageProvideNode<ProfileFriendProvide> {
  ListUserFriend(UserEntity entity) : super(params: [entity]);

  @override
  Widget buildContent(BuildContext context) {
    return ProfilePageTmp(mProvider);
  }
}

class ProfilePageTmp extends StatefulWidget {
  final ProfileFriendProvide provide;
  int maxFriends = 9999;
  Function(int) onImageClicked = null;
  Function onExpandClicked = null;

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
            "Tất cả bạn bè",
            style: TextStyle(color: Colors.black.withOpacity(1.0)),
          ),
          backgroundColor: Colors.white,
        ),

        // var images = buildFriends();
        body: SingleChildScrollView(child:
            Consumer<ProfileFriendProvide>(builder: (context, value, child) {
          return ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: provide.friends.length,
              itemBuilder: (context, index) {
                return buildFriend(provide.friends[index]);
              });
        })));
  }

  List<Widget> buildFriends() {
    int numImages = provide.friends.length;
    print(provide.friends.length);
    return List<Widget>.generate(min(numImages, widget.maxFriends), (index) {
      Friend friend = provide.friends[index];

      // If its the last image
      if (index == widget.maxFriends - 1) {
        // Check how many more images are left
        int remaining = numImages - widget.maxFriends;

        // If no more are remaining return a simple image widget
        if (remaining == 0) {
          return GestureDetector(
            child: buildFriend(friend),
            onTap: () => widget.onImageClicked(index),
          );
        } else {
          // Create the facebook like effect for the last image with number of remaining  images
          return GestureDetector(
            onTap: () => widget.onExpandClicked(),
            child: Stack(
              fit: StackFit.expand,
              children: [
                buildFriend(friend),
                Positioned.fill(
                  child: Container(
                    alignment: Alignment.center,
                    color: Colors.black,
                    child: Text(
                      '+' + remaining.toString(),
                      style: TextStyle(fontSize: 32),
                    ),
                  ),
                ),
              ],
            ),
          );
        }
      } else {
        return GestureDetector(
          child: buildFriend(friend),
          onTap: () => widget.onImageClicked(index),
        );
      }
    });
  }

  Container buildFriend(Friend friend) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 20.0),
      child: Row(
        children: <Widget>[
          GestureDetector(
            onTap: () {
              if (friend.userSecond.id == UserRepositoryImpl.currentUser.id) {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ProfileMe()),
                );
              } else {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ProfileFriend(friend.userSecond)),
                );
              }
            },
            child: Container(
              height: 60,
              width: 60,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30.0),
                image: DecorationImage(
                  image: NetworkImage(friend.userSecond.avatar),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(left: 12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  GestureDetector(
                    onTap: () {
                      if (friend.userSecond.id ==
                          UserRepositoryImpl.currentUser.id) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => ProfileMe()),
                        );
                      } else {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  ProfileFriend(friend.userSecond)),
                        );
                      }
                    },
                    child: Text(
                      friend.userSecond.firstName +
                          " " +
                          friend.userSecond.lastName,
                      style: TextStyle(
                          fontSize: 18,
                          color: Colors.black,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  // SizedBox(height: 2),
                  Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Container(
                          width: 150.0,
                          child: Text(
                            // getFriendChung(),
                            " ",
                            style: TextStyle(
                                color: Colors.grey.shade700, fontSize: 16),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        GestureDetector(
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
                                          ),
                                          child: Column(
                                            mainAxisSize: MainAxisSize.min,
                                            children: <Widget>[
                                              ListTile(
                                                leading: Icon(
                                                  Icons.people_outline,
                                                  color: Colors.black,
                                                ),
                                                title: Text('Xem bạn bè của ' +
                                                    friend
                                                        .userSecond.firstName +
                                                    " " +
                                                    friend.userSecond.lastName),
                                                onTap: () {
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            ListUserFriend(friend
                                                                .userSecond)),
                                                  );
                                                },
                                              ),
                                              ListTile(
                                                leading: Icon(
                                                  Icons.account_circle_outlined,
                                                  color: Colors.black,
                                                ),
                                                title: Text(
                                                    'Xem trang cá nhân của ' +
                                                        friend.userSecond
                                                            .firstName +
                                                        " " +
                                                        friend.userSecond
                                                            .lastName),
                                                onTap: () {
                                                  if (friend.userSecond.id ==
                                                      UserRepositoryImpl
                                                          .currentUser.id) {
                                                    Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                          builder: (context) =>
                                                              ProfileMe()),
                                                    );
                                                  } else {
                                                    Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                          builder: (context) =>
                                                              ProfileFriend(friend
                                                                  .userSecond)),
                                                    );
                                                  }
                                                },
                                              ),
                                              // _createTile(
                                              //     context,
                                              //     'Chặn ' +
                                              //         friend.userSecond
                                              //             .firstName +
                                              //         " " +
                                              //         friend
                                              //             .userSecond.lastName,
                                              //     Icon(
                                              //       Icons.block,
                                              //       color: Colors.black,
                                              //     ),
                                              //     _action1,
                                              //     friend.userSecond.id),
                                              // ListTile(
                                              //   leading: Icon(
                                              //     Icons.cancel_outlined,
                                              //     color: Colors.black,
                                              //   ),
                                              //   title: Text(
                                              //       'Hủy kết bạn ' +
                                              //           friend.userSecond
                                              //               .firstName +
                                              //           " " +
                                              //           friend
                                              //               .userSecond.lastName),
                                              //   onTap: () {
                                              //     widget.provide.friendRepository.deleteRequest(friend, () {});
                                              //   },
                                              // ),
                                            ],
                                          )),
                                    );
                                  });
                            },
                            child: Container(
                              height: 40.0,
                              width: 45.0,
                              child: Icon(Icons.more_horiz),
                            )),
                      ],
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  ListTile _createTile(BuildContext context, String name, Icon icon,
      Function action, String userId) {
    return ListTile(
      leading: icon,
      title: Text(name),
      onTap: () {
        Navigator.pop(context);
        action(userId);
      },
    );
  }

  _action1(String userId) {
    print(userId);
  }
}

String getFriendChung() {
  var rng = new Random();
  // int a = 1 + rng.nextInt(10);
  return "0 bạn chung";
}
