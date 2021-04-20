import 'package:facebook_app/src/base/base.dart';
import 'package:facebook_app/src/viewmodel/chat_view_model.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:facebook_app/src/view/chat/chats/list_friend.dart';
import 'package:facebook_app/src/view/chat/discovery/list_discovery.dart';
import 'package:facebook_app/src/view/chat/people/list_people.dart';
import 'package:provider/provider.dart';

class HomeScreen extends PageProvideNode<ChatProvide> {
  @override
  Widget buildContent(BuildContext context) {
    return HomeScreenTmp(mProvider);
  }
}

class HomeScreenTmp extends StatefulWidget {
  final ChatProvide provide;

  const HomeScreenTmp(this.provide);

  @override
  State<StatefulWidget> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreenTmp>
    with SingleTickerProviderStateMixin {
  ChatProvide provide;

  @override
  void initState() {
    super.initState();
    provide = widget.provide; // set up listener here
  }

  int _selectedIndex = 0;
  static const TextStyle optionStyle =
  TextStyle(fontSize: 30, fontWeight: FontWeight.bold);

  List<Widget> _widgetOptions(ChatProvide provide) => <Widget>[
    ListFriend(),
    ListPeople(provide),
    ListDicovery(provide),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      child: Scaffold(
        body: Consumer<ChatProvide>(builder: (context, value, child) {
          return _widgetOptions(value).elementAt(_selectedIndex);
        }),
        bottomNavigationBar: BottomNavigationBar(
          selectedIconTheme: IconThemeData(color: Colors.black87),
          unselectedIconTheme: IconThemeData(color: Colors.grey.shade400),
          backgroundColor: Colors.white,
          elevation: 10.0,
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: new Icon(
                FontAwesomeIcons.solidComment,
                size: 24.0,
              ),
              title: Text(
                '',
                style: TextStyle(height: 0.0),
              ),
            ),
            BottomNavigationBarItem(
              icon: Icon(
                FontAwesomeIcons.userFriends,
                size: 24.0,
              ),
              title: Text(
                '',
                style: TextStyle(height: 0.0),
              ),
            ),
            // BottomNavigationBarItem(
            //   icon: Icon(
            //     FontAwesomeIcons.solidCompass,
            //     size: 24.0,
            //   ),
            //   title: Text(
            //     '',
            //     style: TextStyle(height: 0.0),
            //   ),
            // ),
          ],
          currentIndex: _selectedIndex,
          selectedItemColor: Colors.amber[800],
          onTap: _onItemTapped,
        ),
      ),
      onWillPop: _onWillPop,
    );
  }
  Future<bool> _onWillPop(){
    Navigator.pop(context);
    return Future.value(true);
  }
}
