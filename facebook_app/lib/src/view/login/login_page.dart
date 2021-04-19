import 'package:facebook_app/src/base/base.dart';
import 'package:facebook_app/src/base/base_widget.dart';
import 'package:facebook_app/src/ultils/connect.dart';
import 'package:facebook_app/src/viewmodel/login_view_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:facebook_app/src/ultils/context_ext.dart';
// import 'package:facebook_app/src/view/home/home_page.dart';

class LoginPage extends PageProvideNode<LoginProvide> {
  @override
  Widget buildContent(BuildContext context) {
    return LoginPageTmp(mProvider);
  }
}

class LoginPageTmp extends StatefulWidget {
  final LoginProvide provide;

  LoginPageTmp(this.provide);

  @override
  State<StatefulWidget> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPageTmp>
    with TickerProviderStateMixin<LoginPageTmp>
    implements Presenter {
  LoginProvide _provide;
  static const ACTION_LOGIN = "login";
  TextEditingController emailController = TextEditingController();
  TextEditingController passWordController = TextEditingController();
  bool _showPass = false;
  bool _visible = false;

  @override
  void initState() {
    super.initState();
    _provide = widget.provide;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          color: Colors.white,
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                buildTopBackground(),
                buildUserInput(),
                buildPasswordInput(),
                buildButtonSignIn(),
                buildForgotPassword(),
                buildDeliver(context),
                buildButtonSignUp()
              ],
            ),
          ),
        ),
      ),
    );
  }

  Padding buildButtonSignUp() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(30, 0, 30, 20),
      child: SizedBox(
        child: Wrap(children: [
          RaisedButton(
            onPressed: () {
              Navigator.pushNamed(context, "/second");
            },
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all((Radius.circular(8)))),
            color: Colors.green,
            child: Text(
              "Tạo tài khoản facebook mới",
              style: TextStyle(color: Colors.white, fontSize: 16),
            ),
          )
        ]),
      ),
    );
  }

  GestureDetector buildForgotPassword() {
    return buildTextPress("Quên mật khẩu", Colors.blue);
  }

  Padding buildDeliver(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(30, 20, 30, 15),
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
        Container(
          width: MediaQuery.of(context).size.width / 2 - 50,
          height: 1,
          color: Colors.grey,
        ),
        Text("HOẶC"),
        Container(
          width: MediaQuery.of(context).size.width / 2 - 50,
          height: 1,
          color: Colors.grey,
        ),
      ]),
    );
  }

  Consumer<LoginProvide> buildButtonSignIn() {
    return Consumer<LoginProvide>(
      builder: (context, value, child) {
        return Padding(
            padding: const EdgeInsets.fromLTRB(30, 0, 30, 20),
            child: SizedBox(
              width: double.infinity,
              height: 56,
              child: buildButton(
                  value.loading ? null : () => onSignInClicked(value),
                  buildLoginChild(value)),
            ));
      },
    );
  }

  Consumer<LoginProvide> buildPasswordInput() {
    return Consumer<LoginProvide>(builder: (context, value, child) {
      return Padding(
          padding: const EdgeInsets.fromLTRB(30, 0, 30, 20),
          child: TextField(
            controller: passWordController,
            onChanged: (text) {
              value.password = text;
              setState(() {
                _visible = text.isNotEmpty;
              });
            },
            style: TextStyle(fontSize: 18, color: Colors.black),
            obscureText: !_showPass,
            decoration: InputDecoration(
              prefixIcon: Icon(Icons.lock_outline, color: Color(0xff888888)),
              labelText: "Mật khẩu",
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
              labelStyle: TextStyle(color: Color(0xff888888), fontSize: 15),
              errorText: value.errPassword,
              suffixIcon: Visibility(
                visible: _visible,
                child: new GestureDetector(
                  onTap: () {
                    setState(() {
                      print(value.password.isNotEmpty);
                      _showPass = !_showPass;
                    });
                  },
                  child: new Icon(
                      _showPass ? Icons.visibility : Icons.visibility_off),
                ),
              ),
            ),
          ));
    });
  }

  Consumer<LoginProvide> buildUserInput() {
    return Consumer(builder: (context, value, child) {
      return Padding(
        padding: const EdgeInsets.fromLTRB(30, 30, 30, 20),
        child: TextField(
          controller: emailController,
          textInputAction: TextInputAction.next,
          style: TextStyle(fontSize: 18, color: Colors.black),
          decoration: InputDecoration(
            labelText: "Số điện thoại hoặc email",
            // errorText: snapshot.hasError ? snapshot.error : null,
            prefixIcon: Icon(Icons.person, color: Color(0xff888888)),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
            labelStyle: TextStyle(color: Color(0xff888888), fontSize: 15),
            errorText: value.errEmail,
          ),
          onChanged: (str) => value.email = str,
        ),
      );
    });
  }

  Container buildTopBackground() {
    return Container(
      child: Image.asset('assets/images/top_background.jpg'),
    );
  }

  Widget buildLoginChild(LoginProvide value) {
    if (value.loading) {
      return const CircularProgressIndicator();
    } else {
      return FittedBox(
        fit: BoxFit.scaleDown,
        child: Text(
          'Đăng nhập',
          maxLines: 1,
          textAlign: TextAlign.center,
          overflow: TextOverflow.fade,
          style: const TextStyle(
              fontWeight: FontWeight.bold, fontSize: 16.0, color: Colors.white),
        ),
      );
    }
  }

  void onSignInClicked(LoginProvide value) async {
    Dialog saveLogin = Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
      //this right here
      child: Container(
        height: 300.0,
        width: 300.0,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.all(15.0),
              child: Text(
                'Lưu đăng nhập',
                style: TextStyle(color: Colors.black, fontSize: 18),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(15),
              child: TextField(
                controller: emailController,
                textInputAction: TextInputAction.next,
                style: TextStyle(fontSize: 18, color: Colors.black),
                decoration: InputDecoration(
                  labelText: "Số điện thoại hoặc email",
                  // errorText: snapshot.hasError ? snapshot.error : null,
                  prefixIcon: Icon(Icons.person, color: Color(0xff888888)),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12)),
                  labelStyle: TextStyle(color: Color(0xff888888), fontSize: 15),
                ),
              ),
            ),
            Padding(
                padding: const EdgeInsets.all(15),
                child: TextField(
                  controller: passWordController,
                  onChanged: (text) {
                    value.password = text;
                    setState(() {
                      _visible = text.isNotEmpty;
                    });
                  },
                  style: TextStyle(fontSize: 18, color: Colors.black),
                  obscureText: !_showPass,
                  decoration: InputDecoration(
                    prefixIcon:
                        Icon(Icons.lock_outline, color: Color(0xff888888)),
                    labelText: "Mật khẩu",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12)),
                    labelStyle:
                        TextStyle(color: Color(0xff888888), fontSize: 15),
                    suffixIcon: Visibility(
                      visible: _visible,
                      child: new GestureDetector(
                        onTap: () {
                          setState(() {
                            print(value.password.isNotEmpty);
                            _showPass = !_showPass;
                          });
                        },
                        child: new Icon(_showPass
                            ? Icons.visibility
                            : Icons.visibility_off),
                      ),
                    ),
                  ),
                )),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                FlatButton(
                    onPressed: () {
                      // Navigator.push(context,
                      //     MaterialPageRoute(builder: (context) => HomePage()));
                    },
                    child: Text(
                      'Huỷ',
                      style: TextStyle(color: Colors.grey, fontSize: 18.0),
                    )),
                FlatButton(
                    onPressed: () {
                      // _provide.saveLogin();
                      // Navigator.push(context,
                      //     MaterialPageRoute(builder: (context) => HomePage()));
                    },
                    child: Text(
                      'Lưu',
                      style: TextStyle(color: Colors.blue, fontSize: 18.0),
                    ))
              ],
            )
          ],
        ),
      ),
    );
    bool isAvailableConnect = await isAvailableInternet();
    if (isAvailableConnect) {
      if (value.isValidInfo()) {
        final s = value.login().listen(
          (_) {
            showDialog(
                context: context,
                barrierDismissible: false,
                builder: (BuildContext context) => saveLogin);
          },
          onError: (e) => value.dispatchFailure(e),
        );
        value.addSubscription(s);
      }
    } else {
      context.showToast("Không có kết nối Internet!");
    }
  }

  @override
  void onClick(String action) {
    if (ACTION_LOGIN == action) {
      // onSignInClicked();
    }
  }
}
