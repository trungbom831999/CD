import 'dart:ui';

import 'package:facebook_app/src/viewmodel/profile_view_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';

class EditProfile extends StatelessWidget {
  final ProfileProvide provide;
  String description = "";

  EditProfile(this.provide);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.black, //change your color here
        ),
        title: Text(
          "Chỉnh sửa trang cá nhân",
          style: TextStyle(color: Colors.black.withOpacity(1.0)),
        ),
        backgroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 20.0),
          child: Column(
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: <Widget>[
                      Text("Ảnh đại diện",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 18.0)),
                      SizedBox(height: 5.0),
                    ],
                  ),
                  TextButton(
                      onPressed: () {
                        _changeAvatar();
                      },
                      child: Text(
                        'Chỉnh sửa',
                        style: TextStyle(fontSize: 15.0, color: Colors.blue),
                      )),
                ],
              ),
              Container(
                  width: 200.0,
                  height: 200.0,
                  decoration: new BoxDecoration(
                    border: Border.all(
                        width: 5,
                        color: Theme.of(context).scaffoldBackgroundColor),
                    shape: BoxShape.circle,
                    image: new DecorationImage(
                      image: NetworkImage(provide.userEntity.avatar),
                      fit: BoxFit.cover,
                    ),
                  )),
              Padding(
                padding: const EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 0.0),
                child: Divider(height: 30.0),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: <Widget>[
                      Text("Ảnh bìa",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 18.0)),
                      SizedBox(height: 5.0),
                    ],
                  ),
                  TextButton(
                      onPressed: () {
                        _changeCoverImage();
                      },
                      child: Text(
                        'Chỉnh sửa',
                        style: TextStyle(fontSize: 15.0, color: Colors.blue),
                      )),
                ],
              ),
              Container(
                  width: MediaQuery.of(context).size.width - 30,
                  height: 200.0,
                  decoration: new BoxDecoration(
                      image: DecorationImage(
                          image: NetworkImage(provide.userEntity.coverImage),
                          fit: BoxFit.cover),
                      borderRadius: BorderRadius.circular(10))),
              Padding(
                padding: const EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 0.0),
                child: Divider(height: 30.0),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: <Widget>[
                      Text("Tiểu sử",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 18.0)),
                      SizedBox(height: 5.0),
                    ],
                  ),
                  TextButton(
                      onPressed: () {
                        provide.updateDescriptionUser(provide.userEntity, description);
                      },
                      child: Text(
                        'Chỉnh sửa',
                        style: TextStyle(fontSize: 15.0, color: Colors.blue),
                      )),
                ],
              ),
              if (provide.userEntity.description == null)
                TextFormField(
                  textAlign: TextAlign.center,
                  decoration: InputDecoration(
                    hintText: 'Mô tả bản thân',
                  ),
                  onChanged: (text) {
                    description = text;
                  },
                )
              else
                TextFormField(
                  initialValue: provide.userEntity.description,
                  keyboardType: TextInputType.multiline,
                  maxLines: null,
                  onChanged: (text) {
                    description = text;
                  },
                ),
            ],
          ),
        ),
      ),
    );
  }

  _changeAvatar() {
    print('change avatar');
    ImagePicker().getImage(source: ImageSource.gallery).then((path) {
      provide.updateAvatar(path.path);
    });
  }

  _changeCoverImage() {
    print('change cover img');
    ImagePicker().getImage(source: ImageSource.gallery).then((path) {
      provide.updateCover(path.path);
    });
  }
}
