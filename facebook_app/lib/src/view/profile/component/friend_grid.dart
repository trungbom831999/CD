import 'dart:math';

import 'package:facebook_app/src/data/model/friend.dart';
import 'package:facebook_app/src/data/repository/user_repository_impl.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../profile_friend.dart';
import '../profile_me.dart';

class FriendGrid extends StatefulWidget {
  // final ProfileProvide provide;
  final int maxFriends = 6;
  final List<Friend> friends;
  final Function(int) onImageClicked;
  final Function onExpandClicked;

  FriendGrid(
      // {@required this.provide,
      {
        // @required this.provide,
        @required this.friends,
      @required this.onImageClicked,
      @required this.onExpandClicked,
      Key key})
      : super(key: key);

  @override
  createState() => _FriendGridState();
}

class _FriendGridState extends State<FriendGrid> {
  @override
  Widget build(BuildContext context) {
    var images = buildFriends();
    return GridView(
      shrinkWrap: true, // new line
      physics: NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: 200,
        crossAxisSpacing: 3,
        mainAxisSpacing: 3,
      ),
      children: images,
    );
  }

  List<Widget> buildFriends() {
    int numImages = widget.friends.length;
    print(widget.friends.length);
    return List<Widget>.generate(min(numImages, widget.maxFriends), (index) {
      Friend friend = widget.friends[index];

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
                    color: Colors.black54,
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
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
                      builder: (context) =>
                          ProfileFriend(friend.userSecond)),
                );
              }
            },
            child: Container(
              height: MediaQuery.of(context).size.width / 3 - 20,
              width: MediaQuery.of(context).size.width / 3 - 20,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: NetworkImage(friend.userSecond.avatar),
                      fit: BoxFit.cover),
                  borderRadius: BorderRadius.circular(10.0)),
            ),
          ),
          SizedBox(height: 5.0),
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
                      builder: (context) =>
                          ProfileFriend(friend.userSecond)),
                );
              }
            },
            child: Text(
                friend.userSecond.firstName + " " + friend.userSecond.lastName,
                style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold)),
          )
        ],
      ),
    );
  }
}
