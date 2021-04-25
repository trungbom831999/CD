import 'package:facebook_app/src/components/black_background_image.dart';
import 'package:facebook_app/src/components/photo_grid.dart';
import 'package:facebook_app/src/data/model/post.dart';
import 'package:facebook_app/src/viewmodel/home_view_model.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:multi_image_picker/multi_image_picker.dart';

import 'comment_list.dart';

class PostDetail extends StatefulWidget {
  final Post post;
  final HomeProvide provide;

  PostDetail({this.post, this.provide});

  @override
  State<StatefulWidget> createState() {
    return _PostDetail(this.post, this.provide);
  }
}

class _PostDetail extends State<PostDetail> {
  String content = "";
  final Post post;
  final HomeProvide provide;

  _PostDetail(this.post, this.provide);

  TextEditingController controller = TextEditingController();
  List<String> pathImages = [];
  List<Asset> images = List<Asset>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          iconTheme: IconThemeData(color: Colors.blue),
          title: Text(
            'Bài viết',
            style: TextStyle(fontSize: 20, color: Colors.black),
          ),
          elevation: 0,
        ),
        body: Container(
          color: Colors.white,
          height: MediaQuery.of(context).size.height * 0.97,
          child: Column(
            children: <Widget>[
              Container(
                padding: EdgeInsets.all(15),
                child: Row(
                  children: <Widget>[
                    CircleAvatar(
                      backgroundImage: NetworkImage(post.owner.avatar),
                      radius: 20.0,
                    ),
                    SizedBox(width: 7.0),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Row(
                          children: [
                            Text(post.owner.firstName + ' ' + post.owner.lastName,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 17.0)),
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
                        Text(fix(post.modified))
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(height: 10.0),
              GestureDetector(
                  onTap: () {
                    showMaterialModalBottomSheet(
                      context: context,
                      builder: (context) => PostDetail(
                        provide: provide,
                        post: post,
                      ),
                    );
                  },
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                    child: Container(
                        alignment: Alignment.centerLeft,
                        child: Text(post.described,
                            style: TextStyle(fontSize: 15.0))),
                  )),
              SizedBox(height: 10.0),
              buildImages(context),
              SizedBox(height: 10.0),
              Container(
                padding: EdgeInsets.fromLTRB(15, 0, 15, 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Icon(FontAwesomeIcons.thumbsUp,
                            size: 15.0, color: Colors.blue),
                        Text(' ${post.likes.length}'),
                      ],
                    ),
                    Row(
                      children: <Widget>[
                        Text('${post.comments.length} comments'),
                        // Text('${post.shares} shares'), // so luong share
                      ],
                    ),
                  ],
                ),
              ),
              Divider(height: 10.0),
              SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    Container(
                      height: MediaQuery.of(context).size.height * 0.6,
                      child: ListView.builder(
                          scrollDirection: Axis.vertical,
                          shrinkWrap: true,
                          itemCount: post.comments.length,
                          itemBuilder: (context, index) {
                            return CommentWidget(
                              comment:
                                  post.comments[post.comments.length - index - 1],
                              provide: provide,
                            );
                          }),
                    ),
                  ],
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                ),
                padding: EdgeInsets.only(top: 15.0, bottom: 15.0),
                child: Row(
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 8.0),
                      child: IconButton(
                        icon: Icon(
                          FontAwesomeIcons.image,
                          size: 25.0,
                          color: Colors.lightBlue,
                        ),
                        onPressed: () {},
                      ),
                    ),
                    Expanded(
                      child: Container(
                        child: TextField(
                          controller: controller,
                          onChanged: (text) {
                            setState(() {
                              content = text;
                            });
                          },
                          // decoration: InputDecoration(
                          //     border: InputBorder.none, hintText: 'Viết bình luận'),
                          decoration: InputDecoration(
                              contentPadding: EdgeInsets.all(10.0),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(25),
                                borderSide: BorderSide(
                                  width: 0,
                                  style: BorderStyle.none,
                                ),
                              ),
                              hintText: 'Viết bình luận',
                              filled: true,
                              fillColor: Colors.grey.shade200,
                              hintStyle: TextStyle(
                                fontSize: 16.0,
                                fontWeight: FontWeight.w500,
                                color: Colors.grey[600],
                              ),
                              suffixIcon: Icon(
                                FontAwesomeIcons.solidSmileBeam,
                                size: 25.0,
                                color: Colors.lightBlue,
                              )),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 8.0),
                      child: IconButton(
                        onPressed: () {
                          provide.addComment(post, content);
                          setState(() {
                            controller.text = "";
                          });
                          // Navigator.pop(context);
                        },
                        icon: Icon(
                          FontAwesomeIcons.paperPlane,
                          size: 25.0,
                          color: Colors.lightBlue,
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
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
    } else {
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
              )
            ],
          ));
    }
  }
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
