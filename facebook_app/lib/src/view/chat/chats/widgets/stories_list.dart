import 'package:facebook_app/src/data/model/friend.dart';
import 'package:facebook_app/src/viewmodel/chat_view_model.dart';
import 'package:flutter/material.dart';
import 'package:facebook_app/src/view/chat/chat_detail/chat_detailv2.dart';

class StoriesList extends StatefulWidget {
  final ChatProvide provide;
  StoriesList(this.provide);
  @override
  _StoriesListState createState() => _StoriesListState(provide);
}
class _StoriesListState extends State<StoriesList> {
  final ChatProvide provide;
  _StoriesListState(this.provide);
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemBuilder: (context, index) {
        if (index == 0) {
          return AddToYourStoryButton();
        } else {
          return StoryListItem(
              provide,
              provide.friends[index-1] );
        }
      },
      itemCount: provide.friends.length+1,
    );
  }
}

class StoryListItem extends StatefulWidget {
  final Friend friends;

  final ChatProvide provide;
  StoryListItem(this.provide, this.friends);

  @override
  State<StatefulWidget> createState() {
    return _StoryListItemState(provide , friends);
  }
}

class _StoryListItemState extends State<StoryListItem> {
  final ChatProvide provide;
  final Friend friends;
  _StoryListItemState(this.provide, this.friends);
  _buildBorder() {
    if (true) {
      return Border.all(color: Colors.white, width: 3);
    } else {
      return Border.all(color: Colors.blue, width: 3);
    }
  }

  _getTextStyle() {
    if (true) {
      return _viewedStoryListItemTextStyle();
    } else {
      return _notViewedStoryListItemTextStyle();
    }
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ChatDetail(friends.userSecond),
          ),
        );
      },
      child: Row(
        children: <Widget>[
          Column(
            children: <Widget>[
              Container(
                height: 60.0,
                width: 60.0,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30.0),
                  border: _buildBorder(),
                ),
                child: Container(
                  width: 60.0,
                  height: 60.0,
                  margin: EdgeInsets.all(2.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25.0),
                    image: DecorationImage(
                      image: NetworkImage(friends.userSecond.avatar),  // ảnh đại diện
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 8.0),
              Container(
                width: 60.0,
                child: Text(
                  friends.userSecond.firstName + " " + friends.userSecond.lastName,         // tên bạn
                  overflow: TextOverflow.ellipsis,
                  softWrap: true,
                  textAlign: TextAlign.center,
                  style: _getTextStyle(),
                ),
              ),
            ],
          ),
          SizedBox(width: 12.0)
        ],
      ),
    );
  }
}

class AddToYourStoryButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 16.0),
      child: Row(
        children: <Widget>[
          Column(
            children: [
              Container(
                  height: 60,
                  width: 60,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.grey.shade200,
                    // borderRadius: BorderRadius.circular(5.0)
                  ),
                  child: Icon(
                    Icons.add,
                    size: 35.0,
                  )),
              SizedBox(height: 8.0),
              Text('Your story', style: _viewedStoryListItemTextStyle()),
            ],
          ),
          SizedBox(width: 12.0)
        ],
      ),
    );
  }
}

_notViewedStoryListItemTextStyle() {
  return TextStyle(
      fontSize: 12, color: Colors.black, fontWeight: FontWeight.bold);
}

_viewedStoryListItemTextStyle() {
  return  TextStyle(fontSize: 9, color: Colors.black, fontWeight: FontWeight.bold, );
  //TextStyle(fontSize: 8, color: Colors.grey);
}
