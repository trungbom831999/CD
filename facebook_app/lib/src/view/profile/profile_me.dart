import 'package:facebook_app/src/base/base.dart';
import 'package:facebook_app/src/components/black_background_show_image.dart';
import 'package:facebook_app/src/components/separator_widget.dart';
import 'package:facebook_app/src/components/write_something_widget.dart';
import 'package:facebook_app/src/view/friend/components/list_friend.dart';
import 'package:facebook_app/src/view/post/post_widget_profile.dart';
import 'package:facebook_app/src/viewmodel/profile_view_model.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import 'component/friend_grid.dart';
import 'component/setting_profile.dart';

class ProfileMe extends PageProvideNode<ProfileProvide> {
  @override
  Widget buildContent(BuildContext context) {
    return ProfilePageTmp(mProvider);
  }
}

class ProfilePageTmp extends StatefulWidget {
  final ProfileProvide provide;

  ProfilePageTmp(this.provide) {
    provide.init();
  }

  @override
  State<StatefulWidget> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePageTmp>
    with SingleTickerProviderStateMixin {
  ProfileProvide provide;

  @override
  void initState() {
    super.initState();
    provide = widget.provide;
  }

  @override
  Widget build(BuildContext context) {
    // print('profile me');
    return Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(
            color: Colors.black, //change your color here
          ),
          title: Text(
            provide.userEntity.firstName + " " + provide.userEntity.lastName,
            style: TextStyle(color: Colors.black.withOpacity(1.0)),
          ),
          backgroundColor: Colors.white,
        ),

        // var images = buildFriends();
        body: SingleChildScrollView(
            child: Consumer<ProfileProvide>(builder: (context, value, child) {
          return Column(
            children: <Widget>[
              Container(
                height: 450.0,
                child: Stack(
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(top: 15.0, left: 10, right: 10),
                      child: new Stack(
                          // fit: StackFit.loose,
                          alignment: AlignmentDirectional.bottomEnd,
                          children: <Widget>[
                        GestureDetector(
                          onTap: () {
                            showModalBottomSheet(
                                context: context,
                                builder: (builder) {
                                  return new Container(
                                    // height: 350.0,
                                    color: Color(0xFF737373),
                                    child: new Container(
                                        decoration: new BoxDecoration(
                                            color: Colors.white,
                                            borderRadius: new BorderRadius
                                                .only(
                                                topLeft:
                                                const Radius.circular(
                                                    10.0),
                                                topRight:
                                                const Radius.circular(
                                                    10.0))),
                                        child: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          children: <Widget>[
                                            ListTile(
                                              leading: Icon(
                                                Icons.image,
                                                color: Colors.black,
                                              ),
                                              title: Text('Xem ảnh bìa'),
                                              onTap: () {
                                                Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          BlackBackgroundShowImage(value
                                                              .userEntity
                                                              .coverImage)),
                                                );
                                              },
                                            ),
                                            _createTile(
                                                context,
                                                'Tải ảnh lên',
                                                Icon(
                                                  Icons.upload_sharp,
                                                  color: Colors.black,
                                                ),
                                                _changeCoverImage),
                                          ],
                                        )),
                                  );
                                });
                          },
                          child: Container(
                              width: MediaQuery.of(context).size.width - 30,
                              height: 200.0,
                              decoration: new BoxDecoration(
                                  image: DecorationImage(
                                      image: NetworkImage(
                                          value.userEntity.coverImage),
                                      fit: BoxFit.cover),
                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(10.0),
                                      topRight: Radius.circular(10.0)))),
                        ),
                        GestureDetector(
                            onTap: () {
                              showModalBottomSheet(
                                  context: context,
                                  builder: (builder) {
                                    return new Container(
                                      // height: 350.0,
                                      color: Color(0xFF737373),
                                      child: new Container(
                                          decoration: new BoxDecoration(
                                              color: Colors.white,
                                              borderRadius: new BorderRadius
                                                  .only(
                                                  topLeft: const Radius
                                                      .circular(10.0),
                                                  topRight: const Radius
                                                      .circular(10.0))),
                                          child: Column(
                                            mainAxisSize:
                                            MainAxisSize.min,
                                            children: <Widget>[
                                              ListTile(
                                                leading: Icon(
                                                  Icons.image,
                                                  color: Colors.black,
                                                ),
                                                title:
                                                Text('Xem ảnh bìa'),
                                                onTap: () {
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            BlackBackgroundShowImage(value
                                                                .userEntity
                                                                .coverImage)),
                                                  );
                                                },
                                              ),
                                              _createTile(
                                                  context,
                                                  'Tải ảnh lên',
                                                  Icon(
                                                    Icons.upload_sharp,
                                                    color: Colors.black,
                                                  ),
                                                  _changeCoverImage),
                                            ],
                                          )),
                                    );
                                  });
                            },
                            child: CircleAvatar(
                              backgroundColor:Color(0xa0fafafa) ,
                              radius: 21.0,
                              child: new Icon(
                                Icons.camera_alt,
                                color: Colors.black,
                                size: 20.0,
                              ),
                            ))
                      ]),
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.only(top: 20.0),
                          child:
                              new Stack(fit: StackFit.loose, children: <Widget>[
                            new Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                new GestureDetector(
                                  onTap: () {
                                    showModalBottomSheet(
                                        context: context,
                                        builder: (builder) {
                                          return new Container(
                                            // height: 350.0,
                                            color: Color(0xFF737373),
                                            child: new Container(
                                                decoration: new BoxDecoration(
                                                    color: Colors.white,
                                                    borderRadius: new BorderRadius
                                                            .only(
                                                        topLeft: const Radius
                                                            .circular(10.0),
                                                        topRight: const Radius
                                                            .circular(10.0))),
                                                child: Column(
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  children: <Widget>[
                                                    ListTile(
                                                      leading: Icon(
                                                        Icons.image,
                                                        color: Colors.black,
                                                      ),
                                                      title: Text(
                                                          'Xem ảnh đại diện'),
                                                      onTap: () {
                                                        Navigator.push(
                                                          context,
                                                          MaterialPageRoute(
                                                              builder: (context) =>
                                                                  BlackBackgroundShowImage(value
                                                                      .userEntity
                                                                      .avatar)),
                                                        );
                                                      },
                                                    ),
                                                    _createTile(
                                                        context,
                                                        'Chọn ảnh đại diện',
                                                        Icon(
                                                          Icons.upload_sharp,
                                                          color: Colors.black,
                                                        ),
                                                        _changeAvatar),
                                                  ],
                                                )),
                                          );
                                        });
                                  },
                                  child: Container(
                                      width: 200.0,
                                      height: 200.0,
                                      margin: EdgeInsets.only(top: 50.0),
                                      decoration: new BoxDecoration(
                                        border: Border.all(
                                            width: 5,
                                            color: Theme.of(context)
                                                .scaffoldBackgroundColor),
                                        shape: BoxShape.circle,
                                        image: new DecorationImage(
                                          image: NetworkImage(
                                              value.userEntity.avatar),
                                          fit: BoxFit.cover,
                                        ),
                                      )),
                                ),
                              ],
                            ),
                            Padding(
                                padding:
                                    EdgeInsets.only(top: 200.0, left: 140.0),
                                child: new Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    new GestureDetector(
                                        onTap: () {
                                          showModalBottomSheet(
                                              context: context,
                                              builder: (builder) {
                                                return new Container(
                                                  // height: 350.0,
                                                  color: Color(0xFF737373),
                                                  child: new Container(
                                                      decoration: new BoxDecoration(
                                                          color: Colors.white,
                                                          borderRadius: new BorderRadius
                                                                  .only(
                                                              topLeft: const Radius
                                                                      .circular(
                                                                  10.0),
                                                              topRight: const Radius
                                                                      .circular(
                                                                  10.0))),
                                                      child: Column(
                                                        mainAxisSize:
                                                            MainAxisSize.min,
                                                        children: <Widget>[
                                                          ListTile(
                                                            leading: Icon(
                                                              Icons.image,
                                                              color:
                                                                  Colors.black,
                                                            ),
                                                            title: Text(
                                                                'Xem ảnh đại diện'),
                                                            onTap: () {
                                                              Navigator.push(
                                                                context,
                                                                MaterialPageRoute(
                                                                    builder: (context) =>
                                                                        BlackBackgroundShowImage(value
                                                                            .userEntity
                                                                            .avatar)),
                                                              );
                                                            },
                                                          ),
                                                          _createTile(
                                                              context,
                                                              'Chọn ảnh đại diện',
                                                              Icon(
                                                                Icons
                                                                    .upload_sharp,
                                                                color: Colors
                                                                    .black,
                                                              ),
                                                              _changeAvatar),
                                                        ],
                                                      )),
                                                );
                                              });
                                        },
                                        child: CircleAvatar(
                                          backgroundColor:Color(0xa0fafafa) ,
                                          radius: 21.0,
                                          child: new Icon(
                                            Icons.camera_alt,
                                            color: Colors.black,
                                            size: 20.0,
                                          ),
                                        )),
                                  ],
                                )),
                          ]),
                        ),
                        SizedBox(height: 20.0),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text(
                                value.userEntity.firstName +
                                    " " +
                                    value.userEntity.lastName,
                                style: TextStyle(
                                    fontSize: 24.0,
                                    fontWeight: FontWeight.bold)),
                            SizedBox(
                              width: 5.0,
                            ),
                            Icon(
                              Icons.check_circle,
                              color: Colors.blueAccent,
                            )
                          ],
                        ),
                        if (value.userEntity.description != "")
                          SizedBox(height: 5.0),
                        if (value.userEntity.description != "")
                          Text(
                            value.userEntity.description,
                            style:
                                TextStyle(fontSize: 16.0, color: Colors.grey),
                            textAlign: TextAlign.center,
                          ),
                        SizedBox(height: 15.0),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            Container(
                              height: 40.0,
                              width: MediaQuery.of(context).size.width - 80,
                              decoration: BoxDecoration(
                                  color: Colors.blue,
                                  borderRadius: BorderRadius.circular(5.0)),
                              child: Center(
                                  child: Text('Thêm vào tin',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16.0))),
                            ),
                            GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            SettingProfile(value)),
                                  );
                                },
                                child: Container(
                                  height: 40.0,
                                  width: 45.0,
                                  decoration: BoxDecoration(
                                      color: Colors.grey[300],
                                      borderRadius: BorderRadius.circular(5.0)),
                                  child: Icon(Icons.more_horiz),
                                ))
                          ],
                        )
                      ],
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(15.0, 0.0, 15.0, 0.0),
                child: Divider(height: 40.0),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 15.0),
                child: Column(
                  children: <Widget>[
                    if (value.userEntity.city != "")
                      Row(
                        children: <Widget>[
                          Icon(Icons.home, color: Colors.grey, size: 30.0),
                          SizedBox(width: 10.0),
                          Text("Sống tại ", style: TextStyle(fontSize: 16.0)),
                          Text(value.userEntity.city,
                              style: TextStyle(
                                  fontSize: 16.0, fontWeight: FontWeight.bold))
                        ],
                      ),
                    if (value.userEntity.city != "") SizedBox(height: 15.0),
                    if (value.userEntity.city != "")
                      Row(
                        children: <Widget>[
                          Icon(Icons.location_on,
                              color: Colors.grey, size: 30.0),
                          SizedBox(width: 10.0),
                          Text("Đến từ ", style: TextStyle(fontSize: 16.0)),
                          Text(value.userEntity.city,
                              style: TextStyle(
                                  fontSize: 16.0, fontWeight: FontWeight.bold))
                        ],
                      ),
                    SizedBox(height: 15.0),
                    Row(
                      children: <Widget>[
                        Icon(Icons.more_horiz, color: Colors.grey, size: 30.0),
                        SizedBox(width: 10.0),
                        Text('Xem thêm thông tin',
                            style: TextStyle(fontSize: 16.0))
                      ],
                    ),
                    SizedBox(height: 15.0),
                    Container(
                      height: 40.0,
                      decoration: BoxDecoration(
                        color: Colors.lightBlueAccent.withOpacity(0.25),
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                      child: Center(
                          child: GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          SettingProfile(value)),
                                );
                              },
                              child: Text('Chỉnh sửa trang cá nhân',
                                  style: TextStyle(
                                      color: Colors.blue,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16.0)))),
                    ),
                  ],
                ),
              ),
              Divider(height: 40.0),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 15.0),
                child: Column(
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text('Bạn bè',
                                style: TextStyle(
                                    fontSize: 22.0,
                                    fontWeight: FontWeight.bold)),
                            SizedBox(height: 6.0),
                            Text(value.friends.length.toString() + ' người bạn',
                                style: TextStyle(
                                    fontSize: 16.0, color: Colors.grey[800])),
                          ],
                        ),
                        // Text('Tìm bạn bè',
                        //     style:
                        //         TextStyle(fontSize: 16.0, color: Colors.blue)),
                      ],
                    ),
                    Center(
                      child: FriendGrid(
                          friends: value.friends,
                          onImageClicked: null,
                          onExpandClicked: null),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ListUserFriend(
                                  value.userEntity)),
                        );
                      },
                      child: Container(
                        margin: EdgeInsets.symmetric(vertical: 15.0),
                        height: 40.0,
                        decoration: BoxDecoration(
                          color: Colors.grey[300],
                          borderRadius: BorderRadius.circular(5.0),
                        ),
                        child: Center(
                            child: Text('Xem tất cả bạn bè',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16.0))),
                      ),
                    ),
                  ],
                ),
              ),
              SeparatorWidget(),
              WriteSomethingWidget(
                provide: value,
              ),
              ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: value.userListPost.length,
                  itemBuilder: (context, index) {
                    return PostWidgetProfile(
                        post: value.userListPost[index], provide: value);
                  }),
            ],
          );
        })));
  }

  ListTile _createTile(
      BuildContext context, String name, Icon icon, Function action) {
    return ListTile(
      leading: icon,
      title: Text(name),
      onTap: () {
        Navigator.pop(context);
        action();
      },
    );
  }

  _action1() {
    print('nhấn xem');
  }

  _changeAvatar() {
    print('change avatar');
    ImagePicker().getImage(source: ImageSource.gallery).then((path) {
      provide.updateAvatar(path.path);
    });
  }

  _changeCoverImage() {
    print('change cover img');
    ImagePicker().getImage(source: ImageSource.gallery).then((path) {
      provide.updateCover(path.path);
    });
  }
}
