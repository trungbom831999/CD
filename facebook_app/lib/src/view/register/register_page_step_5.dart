import 'package:facebook_app/src/view/register/register_page_step_6.dart';
import 'package:flutter/material.dart';

class RegisterPageFive extends StatefulWidget {
  String firstName, lastName, birthday, gender;

  RegisterPageFive(this.firstName, this.lastName, this.birthday, this.gender);

  @override
  State<StatefulWidget> createState() =>
      _RegisterPageState(firstName, lastName, birthday, gender);
}

class _RegisterPageState extends State<RegisterPageFive> {
  String firstName, lastName, birthday, gender;

  _RegisterPageState(this.firstName, this.lastName, this.birthday, this.gender);

  var _isTextNull = null;

  TextEditingController _phoneController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.blue),
        title: Text(
          'Số di động',
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
              buildTexPhone(),
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
        "Nhập số di động của bạn",
        style: TextStyle(
            fontSize: 20, color: Colors.black, fontWeight: FontWeight.bold),
      ),
    );
  }

  TextField buildTexPhone() {
    return TextField(
      textInputAction: TextInputAction.next,
      keyboardType: TextInputType.phone,
      onChanged: (text) {
        setState(() {
          _isTextNull = text.isEmpty;
        });
      },
      controller: _phoneController,
      autofocus: true,
      style: TextStyle(fontSize: 18, color: Colors.black),
      decoration: InputDecoration(
          labelText: "Số điện thoại",
          errorText: _isTextNull == null || !_isTextNull
              ? null
              : "Không được trống số điện thoại",
          suffixIcon: Visibility(
            visible: _isTextNull == null ? true : !_isTextNull,
            child: new GestureDetector(
              onTap: () {
                _phoneController.text = '';
                setState(() {
                  _isTextNull = true;
                });
              },
              child: new Icon(Icons.close),
            ),
          ),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
          labelStyle: TextStyle(color: Color(0xff888888), fontSize: 15)),
    );
  }

  onContinueClick() {
    if (_isTextNull == null || _isTextNull) {
      setState(() {
        _isTextNull = true;
      });
    } else {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => RegisterPageSix(firstName, lastName,
                  birthday, gender, _phoneController.text)));
    }
  }
}
