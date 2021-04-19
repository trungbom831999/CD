import 'package:facebook_app/src/data/model/user.dart';
import 'package:facebook_app/src/view/register/register_page_complete.dart';
import 'package:flutter/material.dart';
import 'package:facebook_app/src/ultils/string_ext.dart';

class RegisterPageSeven extends StatefulWidget {
  String firstName, lastName, birthday, gender, phone, email;

  RegisterPageSeven(this.firstName, this.lastName, this.birthday, this.gender,
      this.phone, this.email);

  @override
  State<StatefulWidget> createState() =>
      _RegisterPageState(firstName, lastName, birthday, gender, phone, email);
}

class _RegisterPageState extends State<RegisterPageSeven> {
  String firstName, lastName, birthday, gender, phone, email;

  _RegisterPageState(this.firstName, this.lastName, this.birthday, this.gender,
      this.phone, this.email);

  bool _showPass = false;
  bool _isTextNull = true;
  TextEditingController _passController = new TextEditingController();

  var error = null;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.blue),
        title: Text(
          'Mật khẩu',
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
              buildPasswordInput(),
              buildButtonContinue(),
            ],
          ),
        ),
      ),
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

  Padding buildTextTop() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 45, 0, 45),
      child: Text(
        "Nhập mật khẩu của bạn",
        style: TextStyle(
            fontSize: 20, color: Colors.black, fontWeight: FontWeight.bold),
      ),
    );
  }

  Padding buildPasswordInput() {
    return Padding(
        padding: const EdgeInsets.fromLTRB(0, 16, 0, 16),
        child: TextField(
          onChanged: (text) {
            setState(() {
              _isTextNull = text.isEmpty;
              if (text.isValidPassword())
                setState(() {
                  error = null;
                });
            });
          },
          controller: _passController,
          style: TextStyle(fontSize: 18, color: Colors.black),
          obscureText: !_showPass,
          decoration: InputDecoration(
            labelText: "Mật khẩu",
            errorText: error,
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
            labelStyle: TextStyle(color: Color(0xff888888), fontSize: 15),
            suffixIcon: Visibility(
              visible: !_isTextNull,
              child: new GestureDetector(
                onTap: () {
                  setState(() {
                    _showPass = !_showPass;
                  });
                },
                child: new Icon(
                    _showPass ? Icons.visibility : Icons.visibility_off),
              ),
            ),
          ),
        ));
  }

  onContinueClick() {
    if (_passController.text.isValidPassword()) {
      print(
          '$firstName $lastName $birthday $email $phone ${_passController.text.toSha256()}');
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => RegisterPageComplete(UserEntity(
                  "-1",
                  firstName,
                  lastName,
                  '',
                  birthday,
                  email,
                  phone,
                  _passController.text.toSha256(),
                  gender))));
    } else {
      setState(() {
        error = "Mật khẩu phải trên 8 ký tự";
      });
    }
  }
}
