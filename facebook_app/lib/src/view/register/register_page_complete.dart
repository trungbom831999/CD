import 'package:facebook_app/src/data/model/user.dart';
import 'package:facebook_app/src/view/register/register_page_create.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class RegisterPageComplete extends StatefulWidget {
  UserEntity _user;

  RegisterPageComplete(this._user);

  @override
  State<StatefulWidget> createState() => _RegisterPageState(_user);
}

class _RegisterPageState extends State<RegisterPageComplete> {
  UserEntity _user;

  _RegisterPageState(this._user);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.blue),
        title: Text(
          'Điều khoản & quyền riêng tư',
          style: TextStyle(fontSize: 20, color: Colors.black),
        ),
        elevation: 0,
      ),
      body: Container(
        padding: EdgeInsets.fromLTRB(30, 0, 30, 0),
        constraints: BoxConstraints.expand(),
        color: Colors.white,
        child: SingleChildScrollView(
          child: Column(
            children: [
              buildTextTop(),
              SizedBox(
                height: 250,
                child: WebView(
                  initialUrl: "https://vi-vn.facebook.com/policies/",
                  javascriptMode: JavascriptMode.unrestricted,
                ),
              ),
              buildButtonContinue(),
              buildText()
            ],
          ),
        ),
      ),
    );
  }

  Padding buildButtonContinue() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 20, 0, 20),
      child: SizedBox(
        width: double.infinity,
        height: 56,
        child: RaisedButton(
          onPressed: onContinueClick,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all((Radius.circular(8)))),
          color: Colors.blue,
          child: Text(
            "Đăng ký",
            style: TextStyle(color: Colors.white, fontSize: 16),
          ),
        ),
      ),
    );
  }

  Padding buildTextTop() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 20, 0, 10),
      child: Text(
        "Hoàn tất đăng ký",
        style: TextStyle(
            fontSize: 20, color: Colors.black, fontWeight: FontWeight.bold),
      ),
    );
  }

  GestureDetector buildText() {
    return GestureDetector(
      onTap: () {},
      child: new Text(
        "Đăng ký mà không tải lên danh bạ của tôi lên",
        style: TextStyle(fontSize: 14, color: Colors.blue),
        textAlign: TextAlign.center,
      ),
    );
  }

  onContinueClick() {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => RegisterPageCreate(_user)));
  }
}
