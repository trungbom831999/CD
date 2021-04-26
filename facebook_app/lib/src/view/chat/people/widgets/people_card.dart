import 'package:facebook_app/src/data/model/friend.dart';
import 'package:flutter/material.dart';

class PeopleCard extends StatefulWidget {

  final List<Friend> friends;
  final int indexItem;
  PeopleCard(this.friends, this.indexItem);
  _PeopleCardState createState() => _PeopleCardState(friends, indexItem);
}

class _PeopleCardState extends State<PeopleCard> {
  final List<Friend> friends;
  final int indexItem;
  _PeopleCardState(this.friends, this.indexItem);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 600.0,
      margin: EdgeInsets.only(
        right: 8.0,
        left: 8.0,
        bottom: 16.0,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        image: DecorationImage(
          image: indexItem == 0 ? NetworkImage(friends[indexItem].userFirst.avatar) :
          NetworkImage(friends[indexItem-1].userSecond.avatar),
          fit: BoxFit.cover,
        ),
      ),
      child: Container(
        padding: EdgeInsets.all(16.0),
        height: 100.0,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15.0),
          gradient: LinearGradient(
            colors: [
              Colors.black.withOpacity(.6),
              Colors.black.withOpacity(.3),
            ],
            stops: [0.1, 0.9],
            begin: Alignment.bottomCenter,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              width: 50.0,
              height: 50.0,
              decoration: BoxDecoration(
                color: Colors.transparent,
                borderRadius: BorderRadius.circular(25.0),
                border: Border.all(
                  width: 2.0,
                  color: Colors.transparent,
                ),
              ),
              child: Container(
                width: 46.0,
                height: 46.0,
                margin: EdgeInsets.all(5.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(23.0),
                  image: DecorationImage(
                    image: indexItem == 0 ? NetworkImage(friends[indexItem].userFirst.avatar) :
                    NetworkImage(friends[indexItem-1].userSecond.avatar),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            Text(
              indexItem == 0 ? 'Thêm tin mới' :
              friends[indexItem-1].userSecond.firstName + " " + friends[indexItem-1].userSecond.lastName,
              style: TextStyle(
                color: Colors.white,
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            )
          ],
        ),
      ),
    );
  }
}
