import 'package:facebook_app/routes/routes.dart';
import 'package:facebook_app/src/data/model/user.dart';
import 'package:facebook_app/src/view/chat/profile/profile_firendv1.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'app_bar_network_rounded_image.dart';

class MessengerAppBarAction extends StatefulWidget {
  List<Widget> actions = List<Widget>(0);
  String title;
  bool isScroll;
  bool isBack;
  String subTitle;
  String imageUrl;
  final UserEntity friend;
  MessengerAppBarAction(
      this.friend,{
        this.actions,
        this.title = '',
        this.isScroll,
        this.isBack,
        this.subTitle,
        this.imageUrl,
      });

  @override
  _MessengerAppBarActionState createState() => _MessengerAppBarActionState(this.friend);
}

class _MessengerAppBarActionState extends State<MessengerAppBarAction> {
  final UserEntity friend;
  _MessengerAppBarActionState(this.friend);
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 90.0,
      padding: EdgeInsets.only(right: 12.0, top: 25.0),
      decoration: BoxDecoration(color: Colors.white, boxShadow: [
        BoxShadow(
          color: widget.isScroll ? Colors.black12 : Colors.white,
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
                padding: EdgeInsets.only(left: 10.0),
                child: InkWell(
                  onTap: () {
                    Routes.goBack(context);
                  },
                  child: Icon(
                    FontAwesomeIcons.arrowLeft,
                    size: 20.0,
                    color: Colors.black,
                  ),
                ),
              ),
              Container(
                width: 16.0,
              ),
              Row(
                  children: <Widget>[
                    InkWell(
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ProfilePageFriendV1(friend),
                        ),
                      ),
                      child: AppBarNetworkRoundedImage(
                        imageUrl: widget.imageUrl,
                      ),
                    )
                  ]
              ),
              SizedBox(
                width: 10.0,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    width: 120.0,
                    child: Text(
                      widget.title,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 15.0,
                        fontWeight: FontWeight.w700,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Text(
                    widget.subTitle,
                    style: TextStyle(color: Colors.grey, fontSize: 11.0),
                  )
                ],
              )
            ],
          ),
          Container(
            child: Row(
              children: widget.actions
                  .map((c) => Container(
                padding: EdgeInsets.only(left: 20.0),
                child: c,
              ))
                  .toList(),
            ),
          )
        ],
      ),
    );
  }
}
