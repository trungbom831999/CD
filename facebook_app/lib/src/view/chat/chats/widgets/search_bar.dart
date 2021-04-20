import 'package:facebook_app/src/view/chat/chats/widgets/searchFriend.dart';
import 'package:facebook_app/src/viewmodel/chat_view_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SearchBar extends StatefulWidget {
  final ChatProvide provide;
  SearchBar(this.provide);
  @override
  _SearchBarState createState() => _SearchBarState(provide);
}

class _SearchBarState extends State<SearchBar> {
  ChatProvide provide;
  _SearchBarState(this.provide);
  void initState() {
    provide = widget.provide;
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => searchFriend(provide),
        ),
      ),
      child: Container(
        height: 45.0,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(21),
          color: Colors.grey.shade200,
        ),
        child: Row(
          children: <Widget>[
            Container(width: 10.0,),
            Icon(Icons.search),
            Container(width: 8.0,),
            Expanded(
              child: TextField(
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: "Tìm kiếm",
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}