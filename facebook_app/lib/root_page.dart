import 'package:dartin/dartin.dart';
import 'package:facebook_app/src/data/repository/user_repository_impl.dart';
import 'package:facebook_app/src/view/login/login_page.dart';
import 'package:flutter/material.dart';

import 'src/data/source/local/user_local_data.dart';
import 'src/data/source/remote/fire_base_auth.dart';
import 'src/data/source/remote/fire_base_storage.dart';
import 'src/data/source/remote/fire_base_user_storage.dart';

class RootPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _RootPage();
}

enum AuthStatus { notSignedIn, signIn, none }

class _RootPage extends State<RootPage> {
  AuthStatus status = AuthStatus.notSignedIn;

  @override
  void initState() {
    super.initState();
    var userRepo = UserRepositoryImpl(
        inject<FirAuth>(),
        inject<UserLocalDatasource>(),
        inject<FirUploadPhoto>(),
        inject<FirUserUpload>());
    if (userRepo.getSaveLogin()) {
      userRepo.getCurrentUser().then((value) {
        setState(() {
          status = value != null ? AuthStatus.signIn : AuthStatus.notSignedIn;
        });
      });
    }else{
      setState(() {
        status = AuthStatus.notSignedIn;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    switch (status) {
      case AuthStatus.notSignedIn:
        return new LoginPage();
      case AuthStatus.signIn:
        return new LoginPage();
    // return new HomePage();
      case AuthStatus.none:
        return new Container();
      default:
        return new Container();
    }
  }
}
