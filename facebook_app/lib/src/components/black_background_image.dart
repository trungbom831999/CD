import 'package:facebook_app/src/data/model/post.dart';
import 'package:facebook_app/src/viewmodel/home_view_model.dart';
import 'package:flutter/material.dart';

class BlackBackgroundScreen extends StatelessWidget {
  final Post post;
  final HomeProvide provide;
  final int index;

  BlackBackgroundScreen({this.post, this.provide, this.index});


  @override
  Widget build(BuildContext context) {
    print("index============$index");
    return Container(
      decoration: new BoxDecoration(
        color: Colors.black,
      ),
      child: Column(
        children: <Widget>[
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            decoration: BoxDecoration(
              image: DecorationImage(
                fit: BoxFit.fitWidth,
                image: NetworkImage(post.images[index]),
              ),
            ),
          )
          // SizedBox(height: 20.0),
        ],
      ),
    );
  }
}
