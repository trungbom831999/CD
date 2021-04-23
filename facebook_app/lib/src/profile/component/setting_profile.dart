import 'dart:ui';

import 'package:facebook_app/src/viewmodel/profile_view_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'edit_profile.dart';

class SettingProfile extends StatelessWidget {
  final ProfileProvide provide;
  SettingProfile(this.provide);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.black, //change your color here
        ),
        title: Text(
          "Cài đặt trang cá nhân",
          style: TextStyle(color: Colors.black.withOpacity(1.0)),
        ),
        backgroundColor: Colors.white,
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 20.0),
        child: Column(
          children: <Widget>[
            GestureDetector(
              onTap:(){
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => EditProfile(provide)),
                );
              },
              child: Row(

                children: <Widget>[
                  Icon(Icons.edit, color: Colors.black, size: 30.0),
                  SizedBox(width: 10.0),
                  Text("Chỉnh sửa trang cá nhân",
                      style: TextStyle(fontSize: 16.0)),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 0.0),
              child: Divider(height: 30.0),
            ),
            GestureDetector(
              onTap:(){

              },
              child: Row(
                children: <Widget>[
                  Icon(Icons.search, color: Colors.black, size: 30.0),
                  SizedBox(width: 10.0),
                  Text("Tìm kiếm trên trang cá nhân",
                      style: TextStyle(fontSize: 16.0)),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 0.0),
              child: Divider(height: 30.0),
            ),
            Align(
              alignment: Alignment.topLeft,
              child: Text(
                "Liên kết đến trang cá nhân của bạn",
                style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                textAlign: TextAlign.left,
              ),
            ),
            Align(
              alignment: Alignment.topLeft,
              child: Text("Liên kết của riêng bạn trên Facebook.",
                  style: TextStyle(fontSize: 16.0)),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 0.0),
              child: Divider(height: 10.0),
            ),
            Text("https://www.facebook.com/"+provide.userEntity.id,
                style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold)),
            Align(
              alignment: Alignment.topLeft,
              child: OutlineButton(
                onPressed: () {
                  Clipboard.setData(new ClipboardData(
                      text: "https://www.facebook.com/"+provide.userEntity.id));
                  return showDialog(
                    context: context,
                    builder: (context) => AboutWidget(),
                  );
                },
                child: Text('SAO CHÉP LIÊN KẾT'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class AboutWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text("Sao chép liên kết"),
      content: Text("Thông báo thành công"),
      actions: [
        FlatButton(
          child: Text("OK"),
          onPressed: () { Navigator.pop(context);},
        )
      ],
    );
  }
}
