import 'package:facebook_app/src/components/infinite_scroll.dart';
import 'package:facebook_app/src/data/model/post.dart';
import 'package:facebook_app/src/viewmodel/home_view_model.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:facebook_app/src/ultils/string_ext.dart';

import 'comment_list.dart';


class CreateCommentWidget extends StatefulWidget {
  final HomeProvide provide;
  final Post post;

  CreateCommentWidget({this.post, this.provide});

  @override
  State<StatefulWidget> createState() {
    return _CreateCommentState(this.post, this.provide);
  }
}

class _CreateCommentState extends State<CreateCommentWidget> {
  String content = "";
  var myController = TextEditingController();
  String cont=" ";
  final HomeProvide provide;
  final Post post;
  _CreateCommentState(this.post, this.provide);
  ScrollController _scrollController = new ScrollController();
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      height: MediaQuery.of(context).size.height * 0.95,
      decoration: new BoxDecoration(
        color: Colors.white,
        borderRadius: new BorderRadius.only(
          topLeft: const Radius.circular(10),
          topRight: const Radius.circular(10),
        ),
      ),
      // padding: EdgeInsets.all(20),
      child: SingleChildScrollView(

        child: Column(
          children: <Widget>[
            Container(
              padding:  EdgeInsets.only(top: 15.0, bottom: 15.0, left: 15.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: <Widget>[
                      Icon(FontAwesomeIcons.thumbsUp,
                          size: 15.0, color: Colors.blue),
                      Text(' ${post.likes.length}'),
                    ],
                  ),
                ],
              ),
            ),
            Divider(height: 10.0),
            Container(

              height: MediaQuery.of(context).size.height * 0.8,
              child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: post.comments.length,
                  itemBuilder: (context, index) {
                    InfiniteScroll();
                    return CommentWidget(
                      comment: post.comments[post.comments.length-index-1],
                      provide: provide,
                    );
                  }),
            ),
            // Spacer(),
            Visibility(
              visible: provide.checkFriend(post.owner.id),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                ),
                padding: EdgeInsets.only( bottom: 15.0),
                child: Row(
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 8.0),
                      child: IconButton(
                        icon: Icon(
                          FontAwesomeIcons.image,
                          size: 25.0,
                          color: Colors.lightBlue,
                        ),
                        onPressed: () {},
                      ),
                    ),
                    Expanded(
                      child: Container(
                        child: TextField(
                          controller: myController,
                          onChanged: (text) {
                            setState(() {
                              int n = myController.text.length;
                              if(n>=2&&myController.text[n-1]==" ") {
                                cont = myController.text;
                                cont = cont.getMyTextSpace();
                                if(myController.text!=cont){
                                  myController.text=cont;
                                  myController.selection = TextSelection.fromPosition(
                                    TextPosition(offset: myController.text.length),
                                  );
                                }
                              }
                              content = myController.text;
                            });
                          },
                          textInputAction: TextInputAction.send,
                          onEditingComplete: () {
                            String mess = content;
                            if(mess != null && mess != "" ) {
                              provide.addComment(post, content);
                              myController.text="";
                              content ="";

                            }
                          },
                          decoration: InputDecoration(
                              contentPadding: EdgeInsets.all(10.0),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(25),
                                borderSide: BorderSide(
                                  width: 0,
                                  style: BorderStyle.none,
                                ),
                              ),
                              hintText: 'Viết bình luận',
                              filled: true,
                              fillColor: Colors.grey.shade200,
                              hintStyle: TextStyle(
                                fontSize: 16.0,
                                fontWeight: FontWeight.w500,
                                color: Colors.grey[600],
                              ),
                              suffixIcon: Icon(
                                FontAwesomeIcons.solidSmileBeam,
                                size: 25.0,
                                color: Colors.lightBlue,
                              )),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 8.0),
                      child: IconButton(
                        onPressed: () {
                          String mess = content;
                          if(mess != null && mess != "" ) {
                            provide.addComment(post, content);
                            myController.text="";
                            content ="";
                          }
                          // Navigator.pop(context);
                        },
                        icon: Icon(
                          FontAwesomeIcons.paperPlane,
                          size: 25.0,
                          color: Colors.lightBlue,
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
