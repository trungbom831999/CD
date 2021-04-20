import 'package:facebook_app/routes/routes.dart';
import 'package:facebook_app/src/base/base.dart';
import 'package:facebook_app/src/viewmodel/chat_view_model.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:facebook_app/src/data/model/user.dart';
import 'package:facebook_app/src/view/chat/profile/profile_firend_compactv1.dart';
import 'package:facebook_app/src/view/chat/profile/profile_firend.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

class ProfilePageFriendV1 extends PageProvideNode<ChatProvide> {
  final UserEntity friend;
  ProfilePageFriendV1(this.friend);
  @override
  Widget buildContent(BuildContext context) {
    return ProfilePageFriendV1Tmp(mProvider, friend);
  }
}
class ProfilePageFriendV1Tmp extends StatefulWidget {
 final UserEntity friend;
  final ChatProvide provide;
  const ProfilePageFriendV1Tmp(this.provide, this.friend);

  @override
  State<StatefulWidget> createState() => _ProfilePageFriendV1State(friend);
}


class _ProfilePageFriendV1State extends State<ProfilePageFriendV1Tmp>
    with SingleTickerProviderStateMixin {
  ChatProvide _provide;
 final UserEntity friend;
  _ProfilePageFriendV1State(this.friend);
  bool _isScroll = false;
  ScrollController _controller;

  _scrollListener() {
    if (_controller.offset > 0) {
      this.setState(() {
        _isScroll = true;
      });
    } else {
      this.setState(() {
        _isScroll = false;
      });
    }
  }

  void initState() {
    _controller = ScrollController();
    _controller.addListener(_scrollListener);
    super.initState();
    _provide = widget.provide;
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: NotificationListener<OverscrollIndicatorNotification>(
        onNotification: (overscroll) {
          overscroll.disallowGlow();
        },
        child: Container(
          decoration: BoxDecoration(color: Colors.white),
          child: Column(
            children: <Widget>[
              _buildAppBar(),
              Expanded(
                child: SingleChildScrollView(
                  controller: _controller,
                  child: Column(
                    children: <Widget>[
                      SizedBox(height: 10.0),
                      Center(
                        child: Container(
                          width: 100.0,
                          height: 100.0,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(80.0),
                            image: DecorationImage(
                              image: NetworkImage(friend.avatar),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 10.0),
                      Center(
                        child: Text(
                          friend.firstName +" "+ friend.lastName,
                          style: TextStyle(
                            fontSize: 22.0,
                            color: Colors.black,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[

                          SizedBox(width: 10.0),
                          GestureDetector(
                              onTap: (){
                              },
                              child: Center(
                                child: Column(
                                  children: [
                                    Center(
                                      child: Container(
                                        margin: const EdgeInsets.only(top: 20.0, left: 20.0, right: 10.0),
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 15.0, vertical: 10.0),
                                        decoration: BoxDecoration(
                                          color: Colors.grey[300],
                                          shape: BoxShape.circle,
                                        ),
                                        child: Icon(FontAwesomeIcons.phoneAlt),
                                      ),
                                    ),

                                    Center(
                                      child: Text(
                                        "Âm thanh",
                                        style: TextStyle(
                                          color: Colors.grey.shade600,
                                          fontSize: 12.0,
                                        ),
                                      ),

                                    ),
                                  ],

                                ),


                              )
                          ),
                          GestureDetector(
                              onTap: (){
                              },
                              child: Center(
                                child: Column(
                                  children: [
                                    Center(
                                      child: Container(
                                        margin: const EdgeInsets.only(top: 20.0, left: 10.0, right: 10.0),
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 15.0, vertical: 10.0),
                                        decoration: BoxDecoration(
                                          color: Colors.grey[300],
                                          shape: BoxShape.circle,
                                        ),
                                        child: Icon(FontAwesomeIcons.video),
                                      ),
                                    ),

                                    Center(
                                      child: Text(
                                        "Video",
                                        style: TextStyle(
                                          color: Colors.grey.shade600,
                                          fontSize: 12.0,
                                        ),
                                      ),

                                    ),
                                  ],

                                ),


                              )
                          ),
                          GestureDetector(
                              onTap: (){
                                showMaterialModalBottomSheet(
                                  context: context,
                                  backgroundColor: Colors.transparent,
                                  builder: (context) => ProfilePageFriendCompactV1(friend),
                                );
                              },
                              child: Center(
                                child: Column(
                                  children: [
                                    Center(
                                      child: Container(
                                        margin: const EdgeInsets.only(top: 20.0, left: 10.0, right: 10.0),
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 15.0, vertical: 10.0),
                                        decoration: BoxDecoration(
                                          color: Colors.grey[300],
                                          shape: BoxShape.circle,
                                        ),
                                        child: Icon(Icons.person),
                                      ),
                                    ),

                                    Center(
                                      child: Text(
                                        "Trang cá nhân",
                                        style: TextStyle(
                                          color: Colors.grey.shade600,
                                          fontSize: 12.0,
                                        ),
                                      ),

                                    ),
                                  ],

                                ),


                              )
                          ),
                          GestureDetector(
                              onTap: (){
                              },
                              child: Center(
                                child: Column(
                                  children: [
                                    Center(
                                      child: Container(
                                        margin: const EdgeInsets.only(top: 20.0, left: 0.0, right: 20.0),
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 15.0, vertical: 10.0),
                                        decoration: BoxDecoration(
                                          color: Colors.grey[300],
                                          shape: BoxShape.circle,
                                        ),
                                        child: Icon(FontAwesomeIcons.bell),
                                      ),
                                    ),

                                    Center(
                                      child: Text(
                                        "Tắt",
                                        style: TextStyle(
                                          color: Colors.grey.shade600,
                                          fontSize: 12.0,
                                        ),
                                      ),

                                    ),
                                  ],

                                ),


                              )
                          ),
                        ],
                      ),
                      _buildSettingItem3('Chủ đề', '', false, FontAwesomeIcons.circle, Colors.blue),
                      _buildSettingItem3('Biểu tượng cảm xúc', '', false, FontAwesomeIcons.solidThumbsUp, Colors.blue),
                      _buildSettingItem('Biệt danh', '', false,Colors.purpleAccent,Colors.white),
                      _buildTitleSetting('hành động khác'),
                      _buildSettingItem3('Xem ảnh & video', '', false, FontAwesomeIcons.image, Colors.black),
                      _buildSettingItem3('Tìm kiếm trong cuộc trò chuyện', '', false, FontAwesomeIcons.search,Colors.black),
                      _buildSettingItem3('Đi đến cuộc trò chuyện bí mật', '', false, FontAwesomeIcons.lock,Colors.black),
                      _buildSettingItem3('Tạo nhóm với ' + friend.firstName, '', false, FontAwesomeIcons.users, Colors.black),
                      _buildTitleSetting('Quyền riên tư'),
                      _buildSettingItem2('Thông báo', 'Bật', false,Colors.lightGreenAccent.shade400),
                      _buildSettingItem3('Bỏ qua tin nhắn', '', false, Icons.account_circle_outlined, Colors.black),
                      _buildSettingItem(' Chặn', '', false,Colors.purpleAccent,Colors.white),
                      _buildSettingItem2('Có gì đó không ổn', 'Góp ý và báo cáo cuộc trò chuyện', false,Colors.lightGreenAccent.shade400),

                      SizedBox(height: 16.0)
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  _buildAppBar() {
    return Container(
      height: 90.0,
      padding: EdgeInsets.only(right: 12.0, top: 16.0),
      decoration: BoxDecoration(color: Colors.white, boxShadow: [
        BoxShadow(
          color: _isScroll ? Colors.black12 : Colors.white,
          offset: Offset(0.0, 1.0),
          blurRadius: 10.0,
        ),
      ]),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Row(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(left: 16.0),
                child: InkWell(
                  onTap: () {
                    Routes.goBack(context);
                  },
                  child: Icon(
                    FontAwesomeIcons.arrowLeft,
                    size: 15.0,
                    color: Colors.black,
                  ),
                ),
              ),
              SizedBox(
                width: 10.0,
              ),
              Container(
                child: Text(
                  '',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold),
                ),
              )
            ],
          ),
          Container(
            child: Row(
              children: <Widget>[
                PopupMenuButton<Choice>(

                  itemBuilder: (BuildContext context) {
                    return choices.map((Choice choice) {
                      return PopupMenuItem<Choice>(
                        value: choice,
                        child: Text(choice.name),
                      );
                    }).toList();
                  },
                ),
                // Container(
                //   padding: EdgeInsets.only(left: 20.0),
                //   child: Icon(
                //     Icons.more_vert,
                //
                //     color: Colors.black,
                //     size: 20.0,
                //   ),
                //
                // ),
              ],
            ),
          )
        ],
      ),
    );
  }

  _buildTitleSetting(title) {
    return Container(

      padding: EdgeInsets.symmetric(
        horizontal: 16.0,
        vertical: 10.0,
      ),
      width: double.infinity,
      decoration: BoxDecoration(
          color: Colors.transparent,
          border: Border(
          )),

      child: Text(

        title,
        style: TextStyle(
          color: Colors.grey,
          fontSize: 14.0,
        ),
      ),
    );
  }

  _buildSettingItem(title, subtitle, isBorderBottom,color1,color2) {
    return Container(
      margin: EdgeInsets.only(left: 16.0),
      padding: EdgeInsets.only(
        top: 12.0,
        bottom: 12.0,
        right: 10.0,
      ),
      decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              width: isBorderBottom ? 0.5 : 0.0,
              color: isBorderBottom ? Colors.grey.shade300 : Colors.transparent,
            ),
          )),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Row(
            children: <Widget>[
              // Container(
              //   width: 35,
              //   height: 35,
              //   decoration: BoxDecoration(
              //     borderRadius: BorderRadius.circular(80.0),
              // color: color1,
              // image: DecorationImage(
              //   image: NetworkImage(provide.userEntity.avatar),
              //   fit: BoxFit.cover,
              // ),
              // ),
              // child: Icon(
              //   // icon,
              //   //FontAwesomeIcons.chevronRight,
              //   color: color2,
              //   size: 18.0,
              // ),
              // ),
              // Icon(
              //   icon,
              //   //FontAwesomeIcons.chevronRight,
              //   color: Colors.grey.shade500,
              //   size: 18.0,
              // ),
              SizedBox(width: 10.0),
              Text(
                  title,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16.0,
                  )
              ),
            ],
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text(
                subtitle,
                style: TextStyle(
                  color: Colors.grey.shade600,
                  fontSize: 15.0,
                ),
              ),
              SizedBox(width: 10.0),
              // Icon(
              //   FontAwesomeIcons.chevronRight,
              //   color: Colors.grey.shade500,
              //   size: 18.0,
              // )
            ],
          )
        ],
      ),
    );
  }
}

_buildSettingItem2(title, subtitle, isBorderBottom,color1) {
  return Container(
    margin: EdgeInsets.only(left: 16.0),
    padding: EdgeInsets.only(
      top: 12.0,
      bottom: 12.0,
      right: 10.0,
    ),
    decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            width: isBorderBottom ? 0.5 : 0.0,
            color: isBorderBottom ? Colors.grey.shade300 : Colors.transparent,
          ),
        )),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Row(
          children: <Widget>[
            // Container(
            //   width: 35,
            //   height: 35,
            //   decoration: BoxDecoration(
            //     borderRadius: BorderRadius.circular(80.0),
            //     color: color1,
            //     // image: DecorationImage(
            //     //   image: NetworkImage(provide.userEntity.avatar),
            //     //   fit: BoxFit.cover,
            //     // ),
            //   ),
            //   child: Icon(
            //     icon,
            //     //FontAwesomeIcons.chevronRight,
            //     color: Colors.white,
            //     size: 18.0,
            //   ),
            // ),
            SizedBox(width: 10.0),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                    title,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 16.0,
                    )
                ),
                SizedBox(width: 10.0),
                Text(
                  subtitle,
                  style: TextStyle(
                    color: Colors.grey.shade600,
                    fontSize: 14.0,
                  ),
                ),
              ],
            ),
          ],
        ),
      ],
    ),
  );
}

_buildSettingItem3(title, subtitle, isBorderBottom, icon2, color1) {
  return Container(
    margin: EdgeInsets.only(left: 16.0),
    padding: EdgeInsets.only(
      top: 12.0,
      bottom: 12.0,
      right: 10.0,
    ),
    decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            width: isBorderBottom ? 0.5 : 0.0,
            color: isBorderBottom ? Colors.grey.shade300 : Colors.transparent,
          ),
        )),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Row(
          children: <Widget>[
            // Container(
            //   width: 35,
            //   height: 35,
            //   decoration: BoxDecoration(
            //     borderRadius: BorderRadius.circular(80.0),
            // color: color1,
            // image: DecorationImage(
            //   image: NetworkImage(provide.userEntity.avatar),
            //   fit: BoxFit.cover,
            //     // ),
            //   ),
            // child: Icon(
            //   icon1,
            //   //FontAwesomeIcons.chevronRight,
            //   color: Colors.white,
            //   size: 18.0,
            //   // ),
            // ),
            SizedBox(width: 10.0),
            Text(
                title,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 16.0,
                )
            ),
          ],
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text(
              subtitle,
              style: TextStyle(
                color: Colors.grey.shade600,
                fontSize: 15.0,
              ),
            ),
            SizedBox(width: 10.0),
            Icon(
              icon2,
              // color: Colors.grey.shade300,
              color: color1,
              size: 18.0,
            )
          ],
        )
      ],
    ),
  );
}