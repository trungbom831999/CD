import 'package:facebook_app/src/data/model/user.dart';
import 'package:facebook_app/src/viewmodel/home_view_model.dart';
import 'package:flutter/material.dart';
import 'package:facebook_app/src/view/chat/people/widgets/personSearch.dart';

int a = 0;
List<String> arr1 = List();
List<String> arr2 = List();
List<UserEntity> _list = List();
List<UserEntity> list2 = List();

class searchFriend extends StatefulWidget {
  final HomeProvide provide;
  final border = OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(90.0)),
      borderSide: BorderSide(
        color: Colors.grey.shade200,
      ));

  searchFriend(this.provide);

  _searchFriendState createState() => _searchFriendState(provide);
}

class _searchFriendState extends State<searchFriend> {
  String content = "";
  ScrollController _controller;
  bool _isScroll = false;
  HomeProvide provide;
  Widget appBarTitle = new Text(
    "",
    style: new TextStyle(color: Colors.white),
  );
  Icon actionIcon = new Icon(
    Icons.search,
    color: Colors.white,
  );
  final key = new GlobalKey<ScaffoldState>();
  final TextEditingController _searchQuery = new TextEditingController();
  bool _IsSearching;

  _searchFriendState(this.provide) {
    arr1 = List();
    arr1.add("á");
    arr1.add("à");
    arr1.add("ả");
    arr1.add("ã");
    arr1.add("ạ");
    arr1.add("â");
    arr1.add("ấ");
    arr1.add("ầ");
    arr1.add("ẩ");
    arr1.add("ẫ");
    arr1.add("ậ");
    arr1.add("ă");
    arr1.add("ắ");
    arr1.add("ằ");
    arr1.add("ẳ");
    arr1.add("ẵ");
    arr1.add("ặ");
    arr1.add("đ");
    arr1.add("é");
    arr1.add("è");
    arr1.add("ẻ");
    arr1.add("ẹ");
    arr1.add("ẽ");
    arr1.add("ê");
    arr1.add("ế");
    arr1.add("ề");
    arr1.add("ể");
    arr1.add("ễ");
    arr1.add("ệ");
    arr1.add("í");
    arr1.add("ì");
    arr1.add("ỉ");
    arr1.add("ĩ");
    arr1.add("ị");
    arr1.add("ó");
    arr1.add("ò");
    arr1.add("ỏ");
    arr1.add("õ");
    arr1.add("ọ");
    arr1.add("ô");
    arr1.add("ố");
    arr1.add("ồ");
    arr1.add("ổ");
    arr1.add("ỗ");
    arr1.add("ộ");
    arr1.add("ơ");
    arr1.add("ớ");
    arr1.add("ờ");
    arr1.add("ở");
    arr1.add("ỡ");
    arr1.add("ợ");
    arr1.add("ú");
    arr1.add("ù");
    arr1.add("ủ");
    arr1.add("ũ");
    arr1.add("ụ");
    arr1.add("ư");
    arr1.add("ứ");
    arr1.add("ừ");
    arr1.add("ử");
    arr1.add("ữ");
    arr1.add("ự");
    arr1.add("ý");
    arr1.add("ỳ");
    arr1.add("ỷ");
    arr1.add("ỹ");
    arr1.add("ỵ");
    arr2 = List();
    arr2.add("a");
    arr2.add("a");
    arr2.add("a");
    arr2.add("a");
    arr2.add("a");
    arr2.add("a");
    arr2.add("a");
    arr2.add("a");
    arr2.add("a");
    arr2.add("a");
    arr2.add("a");
    arr2.add("a");
    arr2.add("a");
    arr2.add("a");
    arr2.add("a");
    arr2.add("a");
    arr2.add("a");
    arr2.add("d");
    arr2.add("e");
    arr2.add("e");
    arr2.add("e");
    arr2.add("e");
    arr2.add("e");
    arr2.add("e");
    arr2.add("e");
    arr2.add("e");
    arr2.add("e");
    arr2.add("e");
    arr2.add("e");
    arr2.add("i");
    arr2.add("i");
    arr2.add("i");
    arr2.add("i");
    arr2.add("i");
    arr2.add("o");
    arr2.add("o");
    arr2.add("o");
    arr2.add("o");
    arr2.add("o");
    arr2.add("o");
    arr2.add("o");
    arr2.add("o");
    arr2.add("o");
    arr2.add("o");
    arr2.add("o");
    arr2.add("o");
    arr2.add("o");
    arr2.add("o");
    arr2.add("o");
    arr2.add("o");
    arr2.add("o");
    arr2.add("u");
    arr2.add("u");
    arr2.add("u");
    arr2.add("u");
    arr2.add("u");
    arr2.add("u");
    arr2.add("u");
    arr2.add("u");
    arr2.add("u");
    arr2.add("u");
    arr2.add("u");
    arr2.add("y");
    arr2.add("y");
    arr2.add("y");
    arr2.add("y");
    arr2.add("y");
  }

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
    provide = widget.provide;
    _controller = ScrollController();
    _controller.addListener(_scrollListener);
    super.initState();
    _list = provide.users;
    list2 = provide.users;
    _IsSearching = false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildBar(context),
      backgroundColor: Colors.white,
      body: Container(
        decoration: BoxDecoration(color: Colors.white),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(top: 5, left: 16.0),
              child: Text(
                "Gợi ý",
                style: TextStyle(
                  color: Colors.grey.shade600,
                  fontSize: 14.0,
                ),
                textAlign: TextAlign.left,
              ),
            ),
            Expanded(
              child: ListView.builder(
                padding: EdgeInsets.only(top: 10.0),
                controller: _controller,
                itemCount: list2.length,
                itemBuilder: (context, index) {
                  return personSearch(
                    provide,
                    list2[index],
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }


  Widget buildBar(BuildContext context) {
    return new AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
        backgroundColor: Colors.white,
        title: TextField(
              controller: _searchQuery,
              onChanged: (text) {
                setState(() {
                  content = _searchQuery.text;
                  if (content.isEmpty || content == null) {
                    list2 = provide.users;
                  } else {
                    list2 = List();
                    for (int i = 0; i < provide.users.length; i++) {
                      String name = RemoveUnicode(provide.users[i].firstName +
                          " " +
                          provide.users[i].lastName);
                      String s = RemoveUnicode(content);
                      if (name.toLowerCase().contains(s)) {
                        list2.add(provide.users[i]);
                      }
                    }
                  }
                  for (int i = 0; i < list2.length; i++) {
                    print("abc+${list2[i].lastName}");
                  }
                });
              },
              decoration: InputDecoration(
                  hintText: "Tìm kiếm",
                  border: InputBorder.none,
                  hintStyle: TextStyle(color: Colors.grey))),
        actions: <Widget>[
          new IconButton(
            icon: actionIcon,
            onPressed: () {
              setState(() {
                if (this.actionIcon.icon == Icons.search) {
                  this.actionIcon = new Icon(
                    Icons.close,
                    color: Colors.white,
                  );
                  _handleSearchStart();
                } else {
                  _handleSearchEnd();
                }
              });
            },
          ),
        ]);
  }

  void _handleSearchStart() {
    setState(() {
      _IsSearching = true;
    });
  }

  void _handleSearchEnd() {
    setState(() {
      this.actionIcon = new Icon(
        Icons.search,
        color: Colors.white,
      );
      this.appBarTitle = new Text(
        "Tìm kiếm",
        style: new TextStyle(color: Colors.white),
      );
      _IsSearching = false;
      _searchQuery.clear();
    });
  }
}

String RemoveUnicode(String text) {
  for (int i = 0; i < arr1.length; i++) {
    for (int j = 0; j < text.length; j++) {
      if (text[j] == arr1[i]) {
        text =
            text.substring(0, j) + arr2[i] + text.substring(j + 1, text.length);
      } else if (text[j].toUpperCase() == arr1[i].toUpperCase()) {
        text = text.substring(0, j) +
            arr2[i].toUpperCase() +
            text.substring(j + 1, text.length);
      }
    }
    // String s= arr1[i];
    // RegExp nameExp = new RegExp("\r${s}");
    // RegExp nameExp2 = new RegExp("\r${s.toUpperCase()}");
    // text = text.replaceAll(nameExp,arr2[i]);
    // text = text.replaceAll(nameExp2 ,arr2[i].toUpperCase());
  }
  print("$text abc");
  return text;
}
