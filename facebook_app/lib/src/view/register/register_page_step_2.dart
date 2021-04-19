import 'package:facebook_app/src/view/register/register_page_step_3.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class RegisterPageSecond extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _RegisterPageSecondState();
}

class _RegisterPageSecondState extends State<RegisterPageSecond> {
  var _isFirstNull;
  var _isSecondNull;
  TextEditingController _firstNameController = new TextEditingController();
  TextEditingController _lastNameController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.blue),
        title: Text(
          'Tên',
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
            children: [buildTextTop(), buildNameInput(), buildButtonContinue()],
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

  Center buildTextTop() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(0, 80, 0, 30),
        child: Text(
          "Bạn tên gì?",
          style: TextStyle(
              fontSize: 20, color: Colors.black, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  onContinueClick() {
    if (_isFirstNull == null || _isSecondNull == null || _isFirstNull || _isSecondNull){
      setState(() {
        _isFirstNull = true;
        _isSecondNull = true;
      });
    }
    else{
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => RegisterPageThree(
                  _firstNameController.text, _lastNameController.text)));
    }
  }

  Row buildNameInput() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(0, 0, 10, 30),
            child: TextField(
              autofocus: true,
              onChanged: (text) {
                setState(() {
                  _isFirstNull = text.isEmpty;
                });
              },
              controller: _firstNameController,
              textInputAction: TextInputAction.next,
              style: TextStyle(fontSize: 18, color: Colors.black),
              decoration: InputDecoration(
                  labelText: "Họ",
                  suffixIcon: Visibility(
                    visible: _isFirstNull == null ? true : !_isFirstNull,
                    child: new GestureDetector(
                      onTap: () {
                        _firstNameController.text = '';
                        setState(() {
                          _isFirstNull = true;
                        });
                      },
                      child: new Icon(Icons.close),
                    ),
                  ),
                  errorText: _isFirstNull == null || !_isFirstNull
                      ? null
                      : "Không được trống họ",
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12)),
                  labelStyle:
                      TextStyle(color: Color(0xff888888), fontSize: 15)),
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(10, 0, 10, 30),
            child: TextField(
              controller: _lastNameController,
              onChanged: (text) {
                setState(() {
                  _isSecondNull = text.isEmpty;
                });
              },
              textInputAction: TextInputAction.next,
              style: TextStyle(fontSize: 18, color: Colors.black),
              decoration: InputDecoration(
                  labelText: "Tên",
                  suffixIcon: Visibility(
                    visible: _isSecondNull == null ? true : !_isSecondNull,
                    child: new GestureDetector(
                      onTap: () {
                        _lastNameController.text = '';
                        setState(() {
                          _isSecondNull = true;
                        });
                      },
                      child: new Icon(Icons.close),
                    ),
                  ),
                  errorText: _isSecondNull == null || !_isSecondNull
                      ? null
                      : "Không được trống tên",
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12)),
                  labelStyle:
                      TextStyle(color: Color(0xff888888), fontSize: 15)),
            ),
          ),
        ),
      ],
    );
  }
}
