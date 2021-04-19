import 'package:facebook_app/src/base/base.dart';
import 'package:facebook_app/src/data/repository/user_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:rxdart/rxdart.dart';
import 'package:facebook_app/src/ultils/string_ext.dart';

class LoginProvide extends BaseProvide {
  final UserRepository _repository;
  String email = "";
  String password = "";
  String _errEmail = null;
  String _errPassword = null;

  bool _loading = false;

  bool get loading => _loading;

  set loading(bool loading) {
    _loading = loading;
    notifyListeners();
  }

  String get errEmail => _errEmail;

  set errEmail(String err) {
    _errEmail = err;
    notifyListeners();
  }

  String get errPassword => _errPassword;

  set errPassword(String err) {
    _errPassword = err;
    notifyListeners();
  }

  LoginProvide(this._repository);

  Stream <UserCredential> login() => _repository
      .signIn(email, password.toSha256())
      .doOnListen(() => loading = true)
      .doOnDone(() => loading = false);

  saveLogin(){
    _repository.setSaveLogin();
  }

  void dispatchFailure(e) {
    print(e.code);
    switch (e.code) {
      case "invalid-email":
        errEmail = "Email không hợp lệ";
        break;
      case "weak-password":
        errPassword = "Mật khẩu quá ngắn";
        break;
      case "wrong-password":
        errPassword = "Mật khẩu không chính xác";
        break;
      case "user-not-found":
        errEmail = "Tài khoản không tồn tại";
        break;
      case "user-disabled":
        errEmail = "Tài khoản đã bị vô hiệu hóa";
        break;
      default:
    }
  }

  bool isValidInfo() {
    bool result = true;
    if (email.isEmpty) {
      errEmail = "vui lòng nhập email";
      result = result && false;
    } else if (!email.isValidEmail()) {
      errEmail = "email không hợp lệ";
      result = result && false;
    } else {
      errEmail = null;
      result = result && true;
    }

    if (!password.isValidPassword()) {
      errPassword = "Mật khẩu phải trên 8 ký tự";
      result = result && false;
    } else {
      errPassword = null;
      result = result && true;
    }
    return result;
  }
}
