import 'package:facebook_app/src/components/black_background_image.dart';
import 'package:facebook_app/src/components/photo_grid.dart';
import 'package:facebook_app/src/data/model/post.dart';
import 'package:facebook_app/src/data/repository/user_repository_impl.dart';
import 'package:facebook_app/src/view/profile/profile_friend.dart';
import 'package:facebook_app/src/view/profile/profile_me.dart';
import 'package:facebook_app/src/viewmodel/home_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_linkify/flutter_linkify.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:video_player/video_player.dart';
import 'package:facebook_app/src/ultils/string_ext.dart';
import 'package:facebook_app/src/view/post/video_player.dart';
import 'comment_widget.dart';
import 'edit_post.dart';

class PostWidget extends StatelessWidget {
  final Post post;
  final HomeProvide provide;
  VideoPlayerController controller;
  Future<void> initializeVideoPlayerFuture;

  PostWidget createState() => PostWidget();

  PostWidget({this.post, this.provide});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          Container(
            color: Colors.grey[400],
            width: MediaQuery.of(context).size.width,
            height: 11.0,
          ),
          Container(
              padding: EdgeInsets.all(15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: <Widget>[
                      GestureDetector(
                        onTap: () {
                          if (post.owner.id == UserRepositoryImpl.currentUser.id) {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => ProfileMe()),
                            );
                          } else {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ProfileFriend(post.owner)),
                            );
                          }
                        },
                        child: CircleAvatar(
                          backgroundImage: NetworkImage(post.owner.avatar),
                          radius: 20.0,
                        ),
                      ),
                      SizedBox(width: 7.0),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          GestureDetector(
                            onTap: () {
                              if (post.owner.id ==
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
                                          ProfileFriend(post.owner)),
                                );
                              }
                            },
                            child: Row(
                              children: [
                                Text(
                                    post.owner.firstName + ' ' + post.owner.lastName,
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold, fontSize: 17.0)),
                                SizedBox(
                                  width: 5.0,
                                ),
                                Icon(
                                  Icons.check_circle,
                                  size: 15,
                                  color: Colors.blueAccent,
                                )
                              ],
                            ),
                          ),
                          SizedBox(height: 5.0),
                          Text(fix(post.modified))
                        ],
                      ),
                    ],
                  ),
                  buildMenu(context),
                ],
              )
          ),
          SizedBox(height: 5.0),
          GestureDetector(
            onTap: () {
              showMaterialModalBottomSheet(
                  context: context,
                  builder: (context) => CreateCommentWidget(
                    provide: provide,
                    post: post,
                  ));
            },
            child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                child: Container(
                  alignment: Alignment.centerLeft,
                  child: Linkify(
                    onOpen: (link) async {
                      if (await canLaunch(link.url)) {
                        await launch(link.url);
                      } else {
                        throw 'Could not launch $link';
                      }
                    },
                    text:post.described.getMyText(),
                    //textAlign: TextAlign.left,
                    linkStyle: TextStyle( fontSize: 15.0,color: Colors.black),
                  ),
                  //Text(post.described.getMyText(), style: TextStyle(fontSize: 15.0)
                )),
          ),
          SizedBox(height: 10.0),
          buildImages(context),
          buildVideos(context),
          SizedBox(height: 10.0),
          Container(
            padding: EdgeInsets.fromLTRB(15, 0, 15, 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Icon(FontAwesomeIcons.thumbsUp,
                        size: 12.0, color: Colors.blue),
                    Text(' ${post.likes.length}'),
                  ],
                ),
                Row(
                  children: <Widget>[
                    GestureDetector(
                      onTap: () {
                        showMaterialModalBottomSheet(
                          context: context,
                          backgroundColor: Colors.transparent,
                          builder: (context) => CreateCommentWidget(
                            provide: provide,
                            post: post,
                          ),
                        );
                      },
                      child: Text('${post.comments.length} comments'),
                    ),

                    // Text('${post.shares} shares'), // so luong share
                  ],
                ),
              ],
            ),
          ),
          Divider(height: 20.0),
          buildBottom(context, post),
        ],
      ),
    );
  }

  Visibility buildImages(BuildContext context) {
    if (post.images.length == 1) {
      return Visibility(
        visible: true,
        child: GestureDetector(
            onTap: () {
              showMaterialModalBottomSheet(
                  context: context,
                  builder: (context) => BlackBackgroundScreen(
                      provide: provide, post: post, index: 0));
            },
            child: Image.network(post.images[0])),
      );
    } else if (post.images.length % 2 == 0) {
      return Visibility(
        visible: post.images.length > 0,
        child: PhotoGrid(
          imageUrls: post.images,
          onImageClicked: (i) => showMaterialModalBottomSheet(
              context: context,
              builder: (context) => BlackBackgroundScreen(
                  provide: provide, post: post, index: i)),
          maxImages: 4,
        ),
      );
    } else if (post.images.length == 3) {
      return Visibility(
          visible: true,
          child: Row(
            children: [
              GestureDetector(
                onTap: () {
                  showMaterialModalBottomSheet(
                      context: context,
                      builder: (context) => BlackBackgroundScreen(
                          provide: provide, post: post, index: 0));
                },
                child: Padding(
                  padding: const EdgeInsets.all(2.0),
                  child: Container(
                    height: MediaQuery.of(context).size.height / 2,
                    width: MediaQuery.of(context).size.width / 2 - 4,
                    child: Image.network(post.images[0], fit: BoxFit.cover),
                  ),
                ),
              ),
              Column(
                children: [
                  GestureDetector(
                    onTap: () {
                      showMaterialModalBottomSheet(
                          context: context,
                          builder: (context) => BlackBackgroundScreen(
                              provide: provide, post: post, index: 1));
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(2.0),
                      child: Container(
                        height: MediaQuery.of(context).size.height / 4,
                        width: MediaQuery.of(context).size.width / 2 - 4,
                        child: Image.network(post.images[1], fit: BoxFit.cover),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      showMaterialModalBottomSheet(
                          context: context,
                          builder: (context) => BlackBackgroundScreen(
                              provide: provide, post: post, index: 2));
                    },
                    child: Container(
                      height: MediaQuery.of(context).size.height / 4,
                      width: MediaQuery.of(context).size.width / 2 - 4,
                      child: Image.network(post.images[2], fit: BoxFit.cover),
                    ),
                  ),
                ],
              ),
            ],
          ));
    }
  }

  buildBottom(BuildContext context, Post post) {
    if (provide.checkFriend(post.owner.id))
      return buildBottomLikeFriend(context);
    return buildBottomLikeNoFriend(context);
  }

  buildBottomLikeFriend(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(15, 0, 15, 0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          FlatButton(
            onPressed: () => {provide.updateLike(post)},
            child: Row(
              // Replace with a Row for horizontal icon + text
              children: <Widget>[
                Icon(FontAwesomeIcons.thumbsUp,
                    size: 20.0,
                    color: !post.isLiked ? Colors.grey : Colors.blue),
                SizedBox(width: 5.0),
                Text(
                  'Like',
                  style: TextStyle(
                      fontSize: 14,
                      color: !post.isLiked ? Colors.grey : Colors.blue),
                )
              ],
            ),
          ),
          FlatButton(
            onPressed: () => {
              showMaterialModalBottomSheet(
                context: context,
                backgroundColor: Colors.transparent,
                builder: (context) => CreateCommentWidget(
                  provide: provide,
                  post: post,
                ),
              )
            },
            child: Row(
              // Replace with a Row for horizontal icon + text
              children: <Widget>[
                Icon(FontAwesomeIcons.commentAlt,
                    size: 20.0, color: Colors.grey),
                SizedBox(width: 5.0),
                Text('Comment',
                    style: TextStyle(fontSize: 14.0, color: Colors.grey)),
              ],
            ),
          ),
          Row(
            children: <Widget>[
              Icon(FontAwesomeIcons.share, size: 15.0, color: Colors.grey),
              SizedBox(width: 5.0),
              Text('Share',
                  style: TextStyle(fontSize: 14.0, color: Colors.grey)),
            ],
          ),
        ],
      ),
    );
  }

  buildBottomLikeNoFriend(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(15, 0, 15, 0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          FlatButton(
            onPressed: () => {provide.updateLike(post)},
            child: Row(
              // Replace with a Row for horizontal icon + text
              children: <Widget>[
                Icon(FontAwesomeIcons.thumbsUp,
                    size: 20.0,
                    color: !post.isLiked ? Colors.grey : Colors.blue),
                SizedBox(width: 5.0),
                Text(
                  'Like',
                  style: TextStyle(
                      fontSize: 14,
                      color: !post.isLiked ? Colors.grey : Colors.blue),
                )
              ],
            ),
          ),
          Row(
            children: <Widget>[
              Icon(FontAwesomeIcons.share, size: 20.0, color: Colors.grey),
              SizedBox(width: 5.0),
              Text('Share',
                  style: TextStyle(fontSize: 14.0, color: Colors.grey)),
            ],
          ),
        ],
      ),
    );
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

  Visibility buildVideos(BuildContext context) {
    bool isVisible = post.video.url.isNotEmpty;
    if(isVisible)
    return Visibility(
      visible: isVisible,
      child: VideoPlayerWidget(post.video.url),
    );
    return Visibility(child: Container(), visible: isVisible,);
  }
  Visibility buildMenu(BuildContext context){
    return  Visibility(
      visible: post.owner.id == UserRepositoryImpl.currentUser.id,
      child: PopupMenuButton<String>(
        onSelected: (String value) {
          showMaterialModalBottomSheet(
            context: context,
            backgroundColor: Colors.transparent,
            builder: (context) => EditPostWidget(
                provide: provide,
                post: post
            ),
          );
        },
        itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
          const PopupMenuItem<String>(
            value: 'Value1',
            child: Text('Chỉnh sửa'),
          ),
        ],
      ),
    );
  }
}