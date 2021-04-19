import 'package:facebook_app/src/data/model/user.dart';
import 'package:flutter/material.dart';

class RegisterPageConfirm extends StatefulWidget {
  UserEntity _user;

  RegisterPageConfirm(this._user);

  @override
  State<StatefulWidget> createState() => _RegisterPageConfirm(_user);
}

class _RegisterPageConfirm extends State<RegisterPageConfirm> {
  UserEntity _user;

  _RegisterPageConfirm(this._user);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.blue),
        title: Text(
          'Xác nhận tài khoản',
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
              buildTextOfTop(),
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
            "Xác nhận",
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
        "Chúng tôi đã gửi SMS kèm mã tới ${_user.phone}",
        style: TextStyle(fontSize: 20, color: Colors.black),
        maxLines: 1,
      ),
    );
  }

  Text buildTextOfTop() {
    return Text(
      "Nhập mã gồm 5 chữ số từ SMS của bạn.",
      style: TextStyle(
          fontSize: 20, color: Colors.black, fontWeight: FontWeight.bold),
      maxLines: 1,
    );
  }

  GestureDetector buildText() {
    return GestureDetector(
      onTap: () {},
      child: new Text(
        "Đăng ký mà không tải lên danh bạ của tôi lên",
        style: TextStyle(fontSize: 14, color: Colors.blue),
      ),
    );
  }

  onContinueClick() {}
}
