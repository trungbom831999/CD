import 'dart:ui';
import 'dart:math';
import 'package:facebook_app/src/data/model/user.dart';
// import 'package:facebook_app/src/view/profile/profile_me.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'list_friend.dart';

class ListUserFriend2 extends StatefulWidget {
  // final ProfileProvide provide;
  final int maxFriends = 9999;
  final List<UserEntity> friends;
  final Function(int) onImageClicked;
  final Function onExpandClicked;

  // ListUserFriend(this.provide, this.friends, this.onImageClicked, this.onExpandClicked);
  ListUserFriend2({
    // @required this.provide,
    @required this.friends,
    @required this.onImageClicked,
    @required this.onExpandClicked,
    Key key,
  }) : super(key: key);

  @override
  createState() => _ListUserFriendState();
}

@override
class _ListUserFriendState extends State<ListUserFriend2> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(
            color: Colors.black, //change your color here
          ),
          title: Text(
            "Gợi ý",
            style: TextStyle(color: Colors.black.withOpacity(1.0)),
          ),
          backgroundColor: Colors.white,
        ),

        // var images = buildFriends();
        body: SingleChildScrollView(
            child: ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: widget.friends.length,
                itemBuilder: (context, index) {
                  return buildFriend(widget.friends[index]);
                })));
  }

  List<Widget> buildFriends() {
    int numImages = widget.friends.length;
    print(widget.friends.length);
    return List<Widget>.generate(min(numImages, widget.maxFriends), (index) {
      UserEntity friend = widget.friends[index];

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

  Container buildFriend(UserEntity friend) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 20.0),
      child: Row(
        children: <Widget>[
          GestureDetector(
            onTap: () {
              // if (friend.id == UserRepositoryImpl.currentUser.id) {
              //   Navigator.push(
              //     context,
              //     MaterialPageRoute(builder: (context) => ProfileMe()),
              //   );
              // } else {
              //   Navigator.push(
              //     context,
              //     MaterialPageRoute(
              //         builder: (context) => ProfileFriend(friend)),
              //   );
              // }
            },
            child: Container(
              height: 60,
              width: 60,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30.0),
                image: DecorationImage(
                  image: NetworkImage(friend.avatar),
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
                      // if (friend.id == UserRepositoryImpl.currentUser.id) {
                      //   Navigator.push(
                      //     context,
                      //     MaterialPageRoute(builder: (context) => ProfileMe()),
                      //   );
                      // } else {
                      //   Navigator.push(
                      //     context,
                      //     MaterialPageRoute(
                      //         builder: (context) => ProfileFriend(friend)),
                      //   );
                      // }
                    },
                    child: Text(
                      friend.firstName + " " + friend.lastName,
                      style: TextStyle(
                          fontSize: 18,
                          color: Colors.black,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  SizedBox(height: 2),
                  Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Container(
                          width: 150.0,
                          child: Text(
                            getFriendChung(),
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
                                                    friend.firstName +
                                                    " " +
                                                    friend.lastName),
                                                onTap: () {
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            ListUserFriend(
                                                                friend)),
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
                                                        friend.firstName +
                                                        " " +
                                                        friend.lastName),
                                                onTap: () {
                                                  // if (friend.id ==
                                                  //     UserRepositoryImpl
                                                  //         .currentUser.id) {
                                                  //   Navigator.push(
                                                  //     context,
                                                  //     MaterialPageRoute(
                                                  //         builder: (context) =>
                                                  //             ProfileMe()),
                                                  //   );
                                                  // } else {
                                                  //   Navigator.push(
                                                  //     context,
                                                  //     MaterialPageRoute(
                                                  //         builder: (context) =>
                                                  //             ProfileFriend(friend
                                                  //                 )),
                                                  //   );
                                                  // }
                                                },
                                              ),
                                              // _createTile(
                                              //     context,
                                              //     'Chặn ' +
                                              //         friend.firstName +
                                              //         " " +
                                              //         friend.lastName,
                                              //     Icon(
                                              //       Icons.block,
                                              //       color: Colors.black,
                                              //     ),
                                              //     _action1,
                                              //     friend.id),
                                              // _createTile(
                                              //     context,
                                              //     'Hủy kết bạn ' +
                                              //         friend.firstName +
                                              //         " " +
                                              //         friend.lastName,
                                              //     Icon(
                                              //       Icons.cancel_outlined,
                                              //       color: Colors.black,
                                              //     ),
                                              //     _action1,
                                              //     friend.id),
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
  int a = 1 + rng.nextInt(10);
  return "${a} bạn chung";
}
