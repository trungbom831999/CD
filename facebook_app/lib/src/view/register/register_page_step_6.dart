import 'package:facebook_app/src/data/model/user.dart';
import 'package:facebook_app/src/view/register/register_page_create.dart';
import 'package:facebook_app/src/view/register/register_page_step_7.dart';
import 'package:facebook_app/src/viewmodel/sign_up_view_moldel.dart';
import 'package:flutter/material.dart';
import 'package:facebook_app/src/ultils/string_ext.dart';

class RegisterPageSix extends StatefulWidget {
  String firstName, lastName, birthday, gender, phone;
  var user = null;

  RegisterPageSix(
      this.firstName, this.lastName, this.birthday, this.gender, this.phone);

  RegisterPageSix.origin(UserEntity user) {
    this.user = user;
  }

  @override
  State<StatefulWidget> createState() {
    if (user == null)
      return _RegisterPageState(firstName, lastName, birthday, gender, phone);
    else
      return _RegisterPageState.origin(user);
  }
}

class _RegisterPageState extends State<RegisterPageSix> {
  String firstName, lastName, birthday, gender, phone;
  var user = null;

  _RegisterPageState(
      this.firstName, this.lastName, this.birthday, this.gender, this.phone);

  _RegisterPageState.origin(UserEntity user) {
    this.user = user;
    _emailController.text = user.email;
  }

  bool _isTextNull = true;
  TextEditingController _emailController = new TextEditingController();
  var errorText = null;
  RegisterBloc _registerBloc = RegisterBloc();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.blue),
        title: Text(
          'Địa chỉ email',
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
              buildTexEmail(),
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
        "Nhập địa chỉ email của bạn",
        style: TextStyle(
            fontSize: 20, color: Colors.black, fontWeight: FontWeight.bold),
      ),
    );
  }

  Padding buildTexEmail() {
    return Padding(
        padding: const EdgeInsets.fromLTRB(0, 16, 0, 16),
        child: StreamBuilder(
          builder: (context, snapshot) => TextField(
            textInputAction: TextInputAction.next,
            controller: _emailController,
            onChanged: (text) {
              setState(() {
                _isTextNull = text.isEmpty;
                if (!text.isEmpty && text.isValidEmail()) {
                  setState(() {
                    errorText = null;
                  });
                }
              });
            },
            keyboardType: TextInputType.emailAddress,
            style: TextStyle(fontSize: 18, color: Colors.black),
            decoration: InputDecoration(
                labelText: "Email",
                errorText: user == null ? errorText : "Email đã tồn tại",
                suffixIcon: Visibility(
                  visible: !_isTextNull,
                  child: new GestureDetector(
                    onTap: () {
                      _emailController.text = '';
                      setState(() {
                        _isTextNull = true;
                      });
                    },
                    child: new Icon(_isTextNull ? null : Icons.close),
                  ),
                ),
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                labelStyle: TextStyle(color: Color(0xff888888), fontSize: 15)),
          ),
          stream: _registerBloc.emailStream,
        ));
  }

  onContinueClick() {
    if (_emailController.text.isEmpty) {
      setState(() {
        errorText = "Không được để trống email";
      });
    } else if (!_emailController.text.isValidEmail()) {
      setState(() {
        errorText = "Email không hợp lệ";
      });
    } else if(user == null) {
      errorText = null;
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => RegisterPageSeven(firstName, lastName,
                  birthday, gender, phone, _emailController.text)));
    } else{
      (user as UserEntity).email = _emailController.text;
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => RegisterPageCreate(user)));
    }
  }
}
