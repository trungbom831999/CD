import 'package:facebook_app/src/viewmodel/home_view_model.dart';
import 'package:flutter/material.dart';

class ChangeCoverImageWidget extends StatefulWidget {
  final HomeProvide provide;

  ChangeCoverImageWidget({this.provide});

  @override
  State<StatefulWidget> createState() {
    return _ChangeCoverImageState(this.provide);
  }
}

class _ChangeCoverImageState extends State<ChangeCoverImageWidget> {
  String content = "";
  final HomeProvide provide;

  _ChangeCoverImageState(this.provide);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.9,
      decoration: new BoxDecoration(
        color: Colors.white,
        borderRadius: new BorderRadius.only(
          topLeft: const Radius.circular(10),
          topRight: const Radius.circular(10),
        ),
      ),
      padding: EdgeInsets.all(20),
      child: Column(
        children: <Widget>[
          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: <Widget>[
                    CircleAvatar(
                      backgroundImage: NetworkImage(provide.userEntity.avatar),
                      radius: 20.0,
                    ),
                    SizedBox(width: 7.0),
                    Text(
                        '${provide.userEntity.firstName} ${provide.userEntity.lastName}',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 17.0)),
                    SizedBox(height: 5.0),
                  ],
                ),
                TextButton(
                    onPressed: () {
                      provide.uploadPost(content,);
                      Navigator.pop(context);
                    },
                    child: Text(
                      'ĐĂNG',
                      style: TextStyle(
                          fontSize: 20,
                          color: content.isEmpty ? Colors.grey : Colors.blue),
                    )),
              ],
            ),
          ),
          SizedBox(height: 20.0),
          TextField(
            maxLines: null,
            minLines: 4,
            textInputAction: TextInputAction.next,
            style: TextStyle(fontSize: 18, color: Colors.black),
            onChanged: (text) {
              setState(() {
                content = text;
              });
            },
            decoration: InputDecoration(
                border: InputBorder.none, hintText: 'Bạn đang nghĩ gì?'),
          ),
          SizedBox(height: 10.0),
          Divider(height: 30.0),
        ],
      ),
    );
  }
}
