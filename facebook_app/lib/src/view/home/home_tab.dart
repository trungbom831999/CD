import 'package:facebook_app/src/components/online_widget.dart';
import 'package:facebook_app/src/components/separator_widget.dart';
import 'package:facebook_app/src/components/stories_widget.dart';
import 'package:facebook_app/src/components/write_something_widget.dart';
import 'package:facebook_app/src/view/post/post_widget.dart';
import 'package:facebook_app/src/viewmodel/home_view_model.dart';
import 'package:flutter/material.dart';

class HomeTab extends StatelessWidget {
  final HomeProvide provide;

  const HomeTab(this.provide);

  @override
  Widget build(BuildContext context) {
    return  ListView(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      children: <Widget>[
        WriteSomethingWidget(provide: provide,),
        SeparatorWidget(),
        OnlineWidget(),
        SeparatorWidget(),
        StoriesWidget(),
        ListView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: provide.listPost.length,
            itemBuilder: (context, index) {
              return PostWidget(
                post: provide.listPost[index],
                provide: provide,
              );
            }),
      ],
    );
  }
}

