import 'package:dartin/dartin.dart';
import 'package:facebook_app/src/data/repository/user_repository_impl.dart';
import 'package:facebook_app/src/data/source/local/user_local_data.dart';
import 'package:facebook_app/src/data/source/remote/fire_base_storage.dart';
import 'package:facebook_app/src/data/source/remote/fire_base_user_storage.dart';
import 'package:facebook_app/src/view/login/login_page.dart';
import 'package:facebook_app/src/viewmodel/home_view_model.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:facebook_app/src/data/source/remote/fire_base_auth.dart';
import 'package:flutter/services.dart';

class MenuTab extends StatelessWidget {
  final HomeProvide provide;

  const MenuTab(this.provide);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: Container(
            child: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.fromLTRB(15.0, 15.0, 0.0, 15.0),
          child: Text('Menu',
              style: TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold)),
        ),
        GestureDetector(
          onTap: () {},
          child: Row(
            children: <Widget>[
              SizedBox(width: 15.0),
              CircleAvatar(
                radius: 25.0,
                backgroundImage: NetworkImage(provide.userEntity.avatar),
              ),
              SizedBox(width: 20.0),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    children: [
                      Text(
                          provide.userEntity.firstName +
                              " " +
                              provide.userEntity.lastName,
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 18.0)),
                      SizedBox(
                        width: 5.0,
                      ),
                      Icon(
                        Icons.check_circle,
                        size: 15,
                        color: Colors.blueAccent,
                      ),
                    ],
                  ),
                  SizedBox(height: 5.0),
                  Text(
                    'Xem trang cá nhân',
                    style: TextStyle(color: Colors.grey),
                  )
                ],
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0),
          child: Divider(height: 20.0),
        ),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              Container(
                width: MediaQuery.of(context).size.width / 2 - 20,
                height: 85.0,
                padding: EdgeInsets.only(left: 20.0),
                decoration: BoxDecoration(
                    border: Border.all(width: 1.0, color: Colors.grey[300]),
                    borderRadius: BorderRadius.circular(10.0)),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Icon(Icons.group, color: Colors.blue, size: 30.0),
                    SizedBox(height: 5.0),
                    Text('Groups',
                        style: TextStyle(
                            fontSize: 16.0, fontWeight: FontWeight.bold))
                  ],
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width / 2 - 30,
                height: 85.0,
                padding: EdgeInsets.only(left: 20.0),
                decoration: BoxDecoration(
                    border: Border.all(width: 1.0, color: Colors.grey[300]),
                    borderRadius: BorderRadius.circular(10.0)),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Icon(Icons.shopping_basket, color: Colors.blue, size: 30.0),
                    SizedBox(height: 5.0),
                    Text('Marketplace',
                        style: TextStyle(
                            fontSize: 16.0, fontWeight: FontWeight.bold))
                  ],
                ),
              )
            ],
          ),
        ),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              Container(
                width: MediaQuery.of(context).size.width / 2 - 20,
                height: 85.0,
                padding: EdgeInsets.only(left: 20.0),
                decoration: BoxDecoration(
                    border: Border.all(width: 1.0, color: Colors.grey[300]),
                    borderRadius: BorderRadius.circular(10.0)),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Icon(Icons.person, color: Colors.blue, size: 30.0),
                    SizedBox(height: 5.0),
                    Text('Friends',
                        style: TextStyle(
                            fontSize: 16.0, fontWeight: FontWeight.bold))
                  ],
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width / 2 - 30,
                height: 85.0,
                padding: EdgeInsets.only(left: 20.0),
                decoration: BoxDecoration(
                    border: Border.all(width: 1.0, color: Colors.grey[300]),
                    borderRadius: BorderRadius.circular(10.0)),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Icon(Icons.history, color: Colors.blue, size: 30.0),
                    SizedBox(height: 5.0),
                    Text('Memories',
                        style: TextStyle(
                            fontSize: 16.0, fontWeight: FontWeight.bold))
                  ],
                ),
              )
            ],
          ),
        ),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              Container(
                width: MediaQuery.of(context).size.width / 2 - 20,
                height: 85.0,
                padding: EdgeInsets.only(left: 20.0),
                decoration: BoxDecoration(
                    border: Border.all(width: 1.0, color: Colors.grey[300]),
                    borderRadius: BorderRadius.circular(10.0)),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Icon(Icons.flag, color: Colors.blue, size: 30.0),
                    SizedBox(height: 5.0),
                    Text('Pages',
                        style: TextStyle(
                            fontSize: 16.0, fontWeight: FontWeight.bold))
                  ],
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width / 2 - 30,
                height: 85.0,
                padding: EdgeInsets.only(left: 20.0),
                decoration: BoxDecoration(
                    border: Border.all(width: 1.0, color: Colors.grey[300]),
                    borderRadius: BorderRadius.circular(10.0)),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Icon(Icons.save_alt, color: Colors.blue, size: 30.0),
                    SizedBox(height: 5.0),
                    Text('Saved',
                        style: TextStyle(
                            fontSize: 16.0, fontWeight: FontWeight.bold))
                  ],
                ),
              )
            ],
          ),
        ),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              Container(
                width: MediaQuery.of(context).size.width / 2 - 20,
                height: 85.0,
                padding: EdgeInsets.only(left: 20.0),
                decoration: BoxDecoration(
                    border: Border.all(width: 1.0, color: Colors.grey[300]),
                    borderRadius: BorderRadius.circular(10.0)),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Icon(FontAwesomeIcons.shoppingBag,
                        color: Colors.blue, size: 25.0),
                    SizedBox(height: 5.0),
                    Text('Jobs',
                        style: TextStyle(
                            fontSize: 16.0, fontWeight: FontWeight.bold))
                  ],
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width / 2 - 30,
                height: 85.0,
                padding: EdgeInsets.only(left: 20.0),
                decoration: BoxDecoration(
                    border: Border.all(width: 1.0, color: Colors.grey[300]),
                    borderRadius: BorderRadius.circular(10.0)),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Icon(Icons.event, color: Colors.blue, size: 30.0),
                    SizedBox(height: 5.0),
                    Text('Events',
                        style: TextStyle(
                            fontSize: 16.0, fontWeight: FontWeight.bold))
                  ],
                ),
              )
            ],
          ),
        ),
        Container(
          width: MediaQuery.of(context).size.width,
          height: 65.0,
          padding: EdgeInsets.symmetric(horizontal: 15.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Icon(Icons.help, size: 40.0, color: Colors.grey[700]),
                  SizedBox(width: 10.0),
                  Text('Trợ giúp & hỗ trợ', style: TextStyle(fontSize: 17.0)),
                ],
              ),
              Icon(Icons.arrow_drop_down, size: 30.0),
            ],
          ),
        ),
        Divider(),
        Container(
          width: MediaQuery.of(context).size.width,
          height: 65.0,
          padding: EdgeInsets.symmetric(horizontal: 15.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Icon(Icons.settings, size: 40.0, color: Colors.grey[700]),
                  SizedBox(width: 10.0),
                  Text('Cài đặt và quyền riêng tư', style: TextStyle(fontSize: 17.0)),
                ],
              ),
              Icon(Icons.arrow_drop_down, size: 30.0),
            ],
          ),
        ),
        Container(
          width: MediaQuery.of(context).size.width,
          height: 65.0,
          padding: EdgeInsets.symmetric(horizontal: 15.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  GestureDetector(
                    onTap: () {
                      UserRepositoryImpl(
                          inject<FirAuth>(),
                          inject<UserLocalDatasource>(),
                          inject<FirUploadPhoto>(),
                          inject<FirUserUpload>())
                          .logOut();
                        Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => LoginPage()),
                      );
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        Icon(Icons.exit_to_app, size: 40.0, color: Colors.grey[700]),
                        SizedBox(width: 10.0),
                        Text('Đăng xuất', style: TextStyle(fontSize: 17.0)),
                      ],
                    ),
                  ),
                ],
              )),
        Container(
          width: MediaQuery.of(context).size.width,
          height: 65.0,
          padding: EdgeInsets.symmetric(horizontal: 15.0),
          child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                GestureDetector(
                  onTap: () {
                    SystemChannels.platform.invokeMethod('SystemNavigator.pop');
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      Icon(Icons.close, size: 40.0, color: Colors.grey[700]),
                      SizedBox(width: 10.0),
                      Text('Thoát ứng dụng', style: TextStyle(fontSize: 17.0)),
                    ],
                  ),
                ),
              ],
            ),
          ),
      ],
    )));
  }
}

// child: RaisedButton(
// onPressed:() {
// FirAuth(FirebaseAuth.instance).signOut((){
// SystemChannels.platform
//     .invokeMethod('SystemNavigator.pop');
// SharedPreferences.getInstance().then((value) {
// value.clear();
// });
// });
// },
