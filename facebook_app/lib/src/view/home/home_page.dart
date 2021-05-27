import 'package:facebook_app/src/base/base.dart';
import 'package:facebook_app/src/view/friend/friends_tab.dart';
import 'package:facebook_app/src/view/menu/menu_tab.dart';
import 'package:facebook_app/src/view/notification/notifications_tab.dart';
import 'package:facebook_app/src/view/profile/profile_tab.dart';
import 'package:facebook_app/src/view/search/search_widget2.dart';
import 'package:facebook_app/src/view/watch/watch_tab.dart';
import 'package:facebook_app/src/viewmodel/home_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import '../../../chat.dart';
import 'home_tab.dart';

class HomePage extends PageProvideNode<HomeProvide> {
  @override
  Widget buildContent(BuildContext context) {
    return HomePageTmp(mProvider);
  }
}

class HomePageTmp extends StatefulWidget {
  final HomeProvide provide;

   HomePageTmp(this.provide){
   provide.init();
  }

  @override
  State<StatefulWidget> createState() => _HomePageState();
}

class _HomePageState extends State<HomePageTmp>
    with SingleTickerProviderStateMixin {
  HomeProvide _provide;
  TabController _tabController;
  var _controller = ScrollController();
  bool _isScroll = true;

  @override
  initState() {
    super.initState();
    _provide = widget.provide;
    _tabController = TabController(vsync: this, length: 6);
    // set up listener here
    _controller.addListener(() {
      print('vi tri ${_controller.position}');
      if (_controller.position.pixels != 0) {
        _provide.isTop = false;
      }
      if (_controller.position.atEdge) {
        if (_controller.position.pixels == 0) {
          // you are at top position
          _provide.isTop = true;
        } else {
          // you are at bottom position
          print('bottom');
        }
      }
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
          physics: ScrollPhysics(),
          controller: _controller,
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return <Widget>[
              SliverAppBar(
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Text('facebook',
                            style: TextStyle(
                                color: Colors.blueAccent,
                                fontSize: 27.0,
                                fontWeight: FontWeight.bold)),
                      ],
                    ),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: <Widget>[
                          IconButton(
                              onPressed: (){
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => searchFriend(_provide)),
                                );
                              },
                              icon: Icon(Icons.search, color: Colors.black)),
                          SizedBox(width: 15.0),
                          IconButton(
                            icon: Icon(FontAwesomeIcons.facebookMessenger),
                            color: Colors.black,
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => App(_provide)),
                              );
                            },
                          ), // xu ly tai day
                        ]),
                  ],
                ),
                pinned: true,
                floating: true,
                backgroundColor: Colors.white,
                forceElevated: innerBoxIsScrolled,
                snap: true,
                bottom: TabBar(
                  indicatorColor: Colors.blueAccent,
                  controller: _tabController,
                  unselectedLabelColor: Colors.grey,
                  labelColor: Colors.blueAccent,
                  tabs: [
                    Tab(icon: Icon(Icons.home, size: 30.0)),
                    Tab(icon: Icon(Icons.people, size: 30.0)),
                    Tab(icon: Icon(Icons.ondemand_video, size: 30.0)),
                    Tab(icon: Icon(Icons.account_circle, size: 30.0)),
                    Tab(icon: Icon(Icons.notifications, size: 30.0)),
                    Tab(icon: Icon(Icons.menu, size: 30.0))
                  ],
                ),
              ),
            ];
          },
          body: Consumer<HomeProvide>(builder: (context, value, child) {
            return TabBarView(controller: _tabController, children: [
              HomeTab(value),
              FriendsTab(value),
              WatchTab(value),
              ProfileTab(),
              NotificationsTab(value),
              MenuTab(value)
            ]);
          })),
    );
  }
}
