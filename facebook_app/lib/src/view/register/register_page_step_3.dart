import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:facebook_app/src/ultils/time_ext.dart';

import 'register_page_step_4.dart';

class RegisterPageThree extends StatefulWidget {
  String firstName, lastName;

  RegisterPageThree(this.firstName, this.lastName);

  @override
  State<StatefulWidget> createState() =>
      _RegisterPageThreeState(firstName, lastName);
}

class _RegisterPageThreeState extends State<RegisterPageThree> {
  String firstName, lastName, birthday= DateTime.now().getPre().subtract(Duration(days: 1)).toString();

  _RegisterPageThreeState(this.firstName, this.lastName);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.blue),
        title: Text(
          'Ngày sinh',
          style: TextStyle(fontSize: 20, color: Colors.black),
        ),
        elevation: 0,
      ),
      body: Container(
        padding: EdgeInsets.fromLTRB(30, 0, 30, 0),
        constraints: BoxConstraints.expand(),
        color: Colors.white,
        child: ListView(
          children: [buildTextTop(),buildDatePicker() , buildButtonContinue()],
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

  Center buildTextTop() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(0, 50, 0, 30),
        child: Text(
          "Sinh nhật của bạn khi nào?",
          style: TextStyle(
              fontSize: 20, color: Colors.black, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  Container buildDatePicker() {
    return Container(
      height: 150,
      child: CupertinoDatePicker(
        mode: CupertinoDatePickerMode.date,
        initialDateTime: DateTime.now().getPre().subtract(Duration(days: 1)),
        maximumDate: DateTime.now().getPre(),
        onDateTimeChanged: (DateTime newDateTime) {
          birthday = newDateTime.toString();
        },
      ),
    );
  }

  onContinueClick() {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) =>
                RegisterPageFour(firstName, lastName, birthday)));
  }
}
