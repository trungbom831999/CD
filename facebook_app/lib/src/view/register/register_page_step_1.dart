import 'package:facebook_app/src/base/base_widget.dart';
import 'package:facebook_app/src/view/register/register_page_step_2.dart';
import 'package:flutter/material.dart';

class RegisterPageFirst extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPageFirst> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.blue),
        title: Text(
          'Tạo tài khoản',
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
              buildImage(),
              buildTextTop(),
              buildTextBottom(),
              buildExistsAccount()
            ],
          ),
        ),
      ),
    );
  }

  Padding buildExistsAccount() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 100, 0, 0),
      child: buildTextPress("Bạn đã có tài khoản?", null)
    );
  }

  Padding buildButtonContinue() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
      child: SizedBox(
        width: double.infinity,
        height: 56,
        child: RaisedButton(
          onPressed: onContinueClick,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all((Radius.circular(8)))),
          color: Colors.blue,
          child: Text(
            "Tiếp tục",
            style: TextStyle(color: Colors.white, fontSize: 16),
          ),
        ),
      ),
    );
  }

  Align buildTextBottom() {
    return Align(
      alignment: Alignment.center,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 16),
        child: Column(
          children: [
            Text(
              "Chúng tôi sẽ giúp bạn tạo tài khoản mới sau một vài bước",
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey,
              ),
              textAlign: TextAlign.center,
            ),
            buildButtonContinue()
          ],
        ),
      ),
    );
  }

  Text buildTextTop() {
    return Text(
      "Tham gia facebook",
      style: TextStyle(
          fontSize: 20, color: Colors.black, fontWeight: FontWeight.bold),
    );
  }

  Center buildImage() {
    return Center(
      child: Container(
          width: MediaQuery.of(context).size.width / 1.5,
          height: MediaQuery.of(context).size.width / 1.5,
          padding: EdgeInsets.fromLTRB(15, 40, 15, 15),
          child: Image.asset('assets/images/image_signup.png')),
    );
  }

  onContinueClick() {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => RegisterPageSecond()));
  }
}
