import 'dart:async';
import 'package:dartin/dartin.dart';
import 'package:facebook_app/src/data/model/user.dart';
import 'package:facebook_app/src/data/repository/user_repository.dart';
import 'package:facebook_app/src/data/repository/user_repository_impl.dart';
import 'package:facebook_app/src/data/source/local/user_local_data.dart';
import 'package:facebook_app/src/data/source/remote/fire_base_auth.dart';
import 'package:facebook_app/src/data/source/remote/fire_base_storage.dart';
import 'package:facebook_app/src/data/source/remote/fire_base_user_storage.dart';

class RegisterBloc {
  UserRepository _userRepositoryImpl = UserRepositoryImpl(
      inject<FirAuth>(),
      inject<UserLocalDatasource>(),
      inject<FirUploadPhoto>(),
      inject<FirUserUpload>());

  StreamController _emailController = StreamController.broadcast();

  Stream get emailStream => _emailController.stream;

  void signUp(UserEntity user, Function onSuccess, Function onError) {
    _userRepositoryImpl.signUp(user, onSuccess, (code) {
      _onSignUpErr(code);
      onError();
    });
  }

  void _onSignUpErr(String code) {
    switch (code) {
      case "ERROR_EMAIL_ALREADY_IN_USE":
        _emailController.sink.addError("Email đã tồn tại");
        break;
      default:
    }
  }

  void dispose() {
    _emailController.close();
  }
}
