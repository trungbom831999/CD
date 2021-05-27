import 'dart:io';

import 'package:facebook_app/src/components/photo_grid_offline.dart';
import 'package:facebook_app/src/viewmodel/home_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_absolute_path/flutter_absolute_path.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:multi_image_picker/multi_image_picker.dart';
import 'package:facebook_app/src/ultils/context_ext.dart';
import 'package:facebook_app/src/ultils/string_ext.dart';
import 'package:facebook_app/src/view/post/video_player.dart';

class CreatePostWidget extends StatefulWidget {
  final HomeProvide provide;

  CreatePostWidget({this.provide});

  @override
  State<StatefulWidget> createState() {
    return _CreatePostState(this.provide);
  }
}

class _CreatePostState extends State<CreatePostWidget> {
  String content = "";
  var myController = TextEditingController();
  String cont = " ";
  final HomeProvide provide;

  _CreatePostState(this.provide);

  List<String> pathImages = [];
  String pathVideo;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery
          .of(context)
          .size
          .height * 0.9,
      decoration: new BoxDecoration(
        color: Colors.white,
        borderRadius: new BorderRadius.only(
          topLeft: const Radius.circular(10),
          topRight: const Radius.circular(10),
        ),
      ),
      padding: EdgeInsets.all(20),
      child: Column(
        children: [
          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: <Widget>[
                    CircleAvatar(
                      backgroundImage: NetworkImage(provide.userEntity.avatar),
                      radius: 20.0,
                    ),
                    SizedBox(width: 7.0),
                    Text(
                        '${provide.userEntity.firstName} ${provide.userEntity
                            .lastName}',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 17.0)),
                    SizedBox(height: 5.0),
                  ],
                ),
                TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                      provide.uploadPost(content,
                          pathImages: pathImages,
                          pathVideos: pathVideo,
                          onDone: () {
                            context.showToast("Tải lên bài viết thành công!");
                          });
                    },
                    child: Text(
                      'ĐĂNG',
                      style: TextStyle(
                          fontSize: 20,
                          color: content.isEmpty ? Colors.grey : Colors.blue),
                    )),
              ],
            ),
          ),
          SizedBox(height: 20.0),
          TextField(
            maxLines: null,
            minLines: 4,
            textInputAction: TextInputAction.next,
            controller: myController,
            onChanged: (text) {
              setState(() {
                int n = myController.text.length;
                if (n >= 2 && myController.text[n - 1] == " ") {
                  cont = myController.text;
                  cont = cont.getMyTextSpace();
                  if (myController.text != cont) {
                    myController.text = cont;
                    myController.selection = TextSelection.fromPosition(
                      TextPosition(offset: myController.text.length),
                    );
                  }
                }
                content = myController.text;
              });
            },
            decoration: InputDecoration(
                border: InputBorder.none, hintText: 'Bạn đang nghĩ gì?'),
          ),
          SizedBox(height: 10.0),
          Container(
            height: MediaQuery
                .of(context)
                .size
                .height * 0.55,
            child: ListView(
              children: [
                buildImages(context),
                buildVideo(context),
                Divider(height: 30.0),
                GestureDetector(
                    onTap: () {
                      loadAssets();
                    },
                    child: Container(
                        height: 20.0,
                        width: 400.0,
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.25),
                          borderRadius: BorderRadius.circular(5.0),
                        ),
                        child: Row(children: <Widget>[
                          Icon(FontAwesomeIcons.images,
                              size: 20.0, color: Colors.green),
                          SizedBox(
                            width: 10.0,
                          ),
                          Text('Tải ảnh lên', style: TextStyle(fontSize: 16.0)),
                        ]))),
                Divider(height: 30.0),
                GestureDetector(
                    onTap: () {
                      getVideo();
                    },
                    child: Container(
                        height: 20.0,
                        width: 400.0,
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.25),
                          borderRadius: BorderRadius.circular(5.0),
                        ),
                        child: Row(children: <Widget>[
                          Icon(FontAwesomeIcons.video, size: 20.0,
                              color: Colors.red),
                          SizedBox(
                            width: 10.0,
                          ),
                          Text('Tải video lên',
                              style: TextStyle(fontSize: 16.0)),
                        ]))),
                Divider(height: 30.0),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget buildVideo(BuildContext context)  {
    return Visibility(
        visible: pathVideo != null && pathVideo.isNotEmpty,
        child: VideoPlayerWidget(pathVideo)
    );
  }

  Visibility buildImages(BuildContext context) {
    if (pathImages.length == 1) {
      return Visibility(
        visible: true,
        child: Container(
          height: MediaQuery
              .of(context)
              .size
              .height / 2,
          width: MediaQuery
              .of(context)
              .size
              .width - 10,
          child: Image.file(
            File(pathImages[0]),
            fit: BoxFit.cover,
          ),
        ),
      );
    } else if (pathImages.length % 2 == 0) {
      return Visibility(
        visible: pathImages.length > 0,
        child: PhotoGridOffline(
          imageUrls: pathImages,
          onImageClicked: (i) => print('Image $i was clicked!'),
          onExpandClicked: () => print('Expand Image was clicked'),
          maxImages: 4,
        ),
      );
    } else {
      return Visibility(
          visible: true,
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(2.0),
                child: Container(
                  height: MediaQuery
                      .of(context)
                      .size
                      .height / 3,
                  width: MediaQuery
                      .of(context)
                      .size
                      .width / 2.5,
                  child: Image.file(
                    File(pathImages[0]),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(2.0),
                    child: Container(
                      height: MediaQuery
                          .of(context)
                          .size
                          .height / 6,
                      width: MediaQuery
                          .of(context)
                          .size
                          .width / 2.2,
                      child: Image.file(
                        File(pathImages[1]),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Container(
                    height: MediaQuery
                        .of(context)
                        .size
                        .height / 6,
                    width: MediaQuery
                        .of(context)
                        .size
                        .width / 2.2,
                    child: Image.file(
                      File(pathImages[2]),
                      fit: BoxFit.cover,
                    ),
                  ),
                ],
              )
            ],
          ));
    }
  }

  loadAssets() {
    try {
      MultiImagePicker.pickImages(
        maxImages: 4,
        enableCamera: true,
        // selectedAssets: images,
        cupertinoOptions: CupertinoOptions(takePhotoIcon: "chat"),
        materialOptions: MaterialOptions(
          actionBarColor: "#abcdef",
          actionBarTitle: "Chọn ảnh",
          allViewTitle: "Tất cả ảnh",
          useDetailsView: false,
          selectCircleStrokeColor: "#000000",
        ),
      ).then((value) {
        for (int i = 0; i < value.length; i++) {
          FlutterAbsolutePath.getAbsolutePath(value[i].identifier)
              .then((value) =>
              setState(() {
                pathImages.add(value);
              }));
        }
      });
    } on Exception catch (e) {}
    if (!mounted) return;
  }

  Future getVideo() async {
    Future<PickedFile> _videoFile =
    ImagePicker.platform.pickVideo(source: ImageSource.gallery);
    _videoFile.then((file) async {
      print("path video=======" + file.path);
      setState(() {
        pathVideo = file.path;
      });
    });
  }
}
