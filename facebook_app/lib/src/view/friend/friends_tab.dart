import 'dart:math';

import 'package:facebook_app/src/data/model/user.dart';
import 'package:facebook_app/src/viewmodel/home_view_model.dart';
import 'package:facebook_app/src/base/base.dart';
import 'package:facebook_app/src/data/model/friend.dart';
import 'package:facebook_app/src/viewmodel/friend_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// import '../profile/profile_friend.dart';
import 'components/list_friend.dart';
import 'components/list_friend2.dart';

class FriendsTab extends PageProvideNode<FriendProvide> {
  final HomeProvide homeProvide;
  FriendsTab(this.homeProvide);

  @override
  Widget buildContent(BuildContext context) {
    return FriendsPageTmp(mProvider,this.homeProvide);
  }
}

class FriendsPageTmp extends StatefulWidget {
  final FriendProvide provide;
  final HomeProvide homeProvide;
  final int maxFriends = 9999;
  Function(int) onImageClicked;
  Function onExpandClicked;

  FriendsPageTmp(this.provide,this.homeProvide);

  @override
  State<StatefulWidget> createState() => _FriendsPageState(this.homeProvide);
}

class _FriendsPageState extends State<FriendsPageTmp>
    with SingleTickerProviderStateMixin {
  FriendProvide _provide;
  final HomeProvide homeProvide;
  _FriendsPageState(this.homeProvide);
  @override
  void initState() {
    super.initState();
    _provide = widget.provide;
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: Consumer<FriendProvide>(builder: (context, value, child) {
          return Container(
              padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 15.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text('Bạn bè',
                      style:
                      TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold)),
                  SizedBox(height: 15.0),
                  Row(
                    children: <Widget>[
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ListUserFriend2(
                                  // provide: value,
                                    friends: getFriendKhongChung(homeProvide.friends, homeProvide),
                                    onImageClicked: null,
                                    onExpandClicked: null)),
                          );
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 15.0, vertical: 10.0),
                          decoration: BoxDecoration(
                              color: Colors.grey[300],
                              borderRadius: BorderRadius.circular(30.0)),
                          child: Text('Gợi ý',
                              style: TextStyle(
                                  fontSize: 17.0, fontWeight: FontWeight.bold)),
                        ),
                      ),
                      SizedBox(width: 10.0),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ListUserFriend(
                                    widget.homeProvide.userEntity)),
                          );
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 15.0, vertical: 10.0),
                          decoration: BoxDecoration(
                              color: Colors.grey[300],
                              borderRadius: BorderRadius.circular(30.0)),
                          child: Text('Tất cả bạn bè',
                              style: TextStyle(
                                  fontSize: 17.0, fontWeight: FontWeight.bold)),
                        ),
                      ),
                    ],
                  ),
                  Divider(height: 30.0),
                  Row(
                    children: <Widget>[
                      Text('Lời mời kết bạn',
                          style: TextStyle(
                              fontSize: 21.0, fontWeight: FontWeight.bold)),
                      SizedBox(width: 10.0),
                      Text(value.friendRequest.length.toString(),
                          style: TextStyle(
                              fontSize: 21.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.red)),
                    ],
                  ),
                  ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: value.friendRequest.length,
                      itemBuilder: (context, index) {
                        return buildFriend(value.friendRequest[index]);
                      }),
                  // Divider(height: 30.0),
                  // Text('Bạn có thể biết',
                  //     style:
                  //     TextStyle(fontSize: 21.0, fontWeight: FontWeight.bold)),
                  // SizedBox(height: 25.0),
                  // Row(
                  //   children: <Widget>[
                  //     CircleAvatar(
                  //       backgroundImage: AssetImage('assets/mathew.jpg'),
                  //       radius: 40.0,
                  //     ),
                  //     SizedBox(width: 25.0),
                  //     Column(
                  //       mainAxisAlignment: MainAxisAlignment.center,
                  //       crossAxisAlignment: CrossAxisAlignment.start,
                  //       children: <Widget>[
                  //         Text('Mathew',
                  //             style: TextStyle(
                  //                 fontSize: 16.0, fontWeight: FontWeight.bold)),
                  //         SizedBox(height: 15.0),
                  //         Row(
                  //           children: <Widget>[
                  //             Container(
                  //               padding: EdgeInsets.symmetric(
                  //                   horizontal: 25.0, vertical: 10.0),
                  //               decoration: BoxDecoration(
                  //                   color: Colors.blue,
                  //                   borderRadius: BorderRadius.circular(5.0)),
                  //               child: Text('Confirm',
                  //                   style: TextStyle(
                  //                       color: Colors.white, fontSize: 15.0)),
                  //             ),
                  //             SizedBox(width: 10.0),
                  //             Container(
                  //               padding: EdgeInsets.symmetric(
                  //                   horizontal: 25.0, vertical: 10.0),
                  //               decoration: BoxDecoration(
                  //                   color: Colors.grey[300],
                  //                   borderRadius: BorderRadius.circular(5.0)),
                  //               child: Text('Delete',
                  //                   style: TextStyle(
                  //                       color: Colors.black, fontSize: 15.0)),
                  //             ),
                  //           ],
                  //         )
                  //       ],
                  //     )
                  //   ],
                  // ),
                ],
              ));
        }));
  }

  List<Widget> buildFriends() {
    int numImages = _provide.friendRequest.length;
    print('number friend request $numImages');
    return List<Widget>.generate(min(numImages, widget.maxFriends), (index) {
      Friend friend = _provide.friendRequest[index];

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
              // Navigator.push(
              //   context,
              //   MaterialPageRoute(
              //       builder: (context) =>
              //           ProfileFriend(friend.userSecond)),
              // );
            },
            child: CircleAvatar(
              backgroundImage: NetworkImage(friend.userSecond.avatar),
              radius: 40.0,
            ),
          ),
          SizedBox(width: 25.0),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              GestureDetector(
                onTap: () {
                  // Navigator.push(
                  //   context,
                  //   MaterialPageRoute(
                  //       builder: (context) =>
                  //           ProfileFriend(friend.userSecond)),
                  // );
                },
                child: Text(
                    friend.userSecond.firstName +
                        " " +
                        friend.userSecond.lastName,
                    style:
                    TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold)),
              ),
              SizedBox(height: 15.0),
              Row(
                children: <Widget>[
                  GestureDetector(
                    onTap: () {
                      _provide.acceptRequest(friend);
                      print('oke fr');
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(
                          horizontal: 25.0, vertical: 10.0),
                      decoration: BoxDecoration(
                          color: Colors.blue,
                          borderRadius: BorderRadius.circular(5.0)),
                      child: Text('Chấp nhận',
                          style:
                          TextStyle(color: Colors.white, fontSize: 15.0)),
                    ),
                  ),
                  SizedBox(width: 10.0),
                  GestureDetector(
                    onTap: () {
                      _provide.deleteRequest(friend);
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(
                          horizontal: 25.0, vertical: 10.0),
                      decoration: BoxDecoration(
                          color: Colors.grey[300],
                          borderRadius: BorderRadius.circular(5.0)),
                      child: Text('Xóa',
                          style:
                          TextStyle(color: Colors.black, fontSize: 15.0)),
                    ),
                  ),
                ],
              )
            ],
          )
        ],
      ),
    );
  }
}

List<UserEntity> getFriendKhongChung(List<Friend> friends, HomeProvide provide) {
  List<UserEntity> a= List();
  for(int i=0;i<provide.users.length;i++){
    int kt=0;
    for(int j=0;j<friends.length;j++){
      if(friends[j].userSecond.id==provide.users[i].id||provide.users[i].id==provide.userEntity.id){
        kt=1;
        break;
      }
    }
    if(kt==0){
      a.add(provide.users[i]);
    }
  }
  print("${a.length}+abc");
  return a;
}

