import 'package:facebook_app/src/components/online_widget.dart';
import 'package:facebook_app/src/components/separator_widget.dart';
import 'package:facebook_app/src/components/stories_widget.dart';
import 'package:facebook_app/src/components/write_something_widget.dart';
import 'package:facebook_app/src/view/post/post_widget.dart';
import 'package:facebook_app/src/viewmodel/home_view_model.dart';
import 'package:flutter/material.dart';

class HomeTab extends StatelessWidget {
  final HomeProvide value;

  HomeTab(this.value);

  @override
  Widget build(BuildContext context) {
    print('loading ${value.loading}');
    return NotificationListener<ScrollNotification>(
      onNotification: (scrollInfo) {
        if (!value.loading &&
            scrollInfo.metrics.pixels == scrollInfo.metrics.maxScrollExtent) {
          print('bottom roi');
          value.isBottom = true;
        }
        return true;
      },
      child: SingleChildScrollView(
        child: Column(
          // shrinkWrap: true,
          // physics: NeverScrollableScrollPhysics(),
          children: <Widget>[
            WriteSomethingWidget(
              provide: value,
            ),
            SeparatorWidget(),
            OnlineWidget(),
            SeparatorWidget(),
            StoriesWidget(),
            for (int i = 0; i < value.maxPost; i++)
              PostWidget(
                post: value.listPost[i],
                provide: value,
              ),
            ListView.builder(
                shrinkWrap: true,
                itemCount: value.maxPost + 1,
                itemBuilder: (context, index) {
                  if (index == value.maxPost)
                    return Container(
                      height: value.loading || value.maxPost == 0 ? 64.0 : 0,
                      // height: 64,
                      padding: EdgeInsets.only(bottom: 18),
                      color: Colors.transparent,
                      child: Center(child: CircularProgressIndicator()),
                    );
                  return PostWidget(
                    post: value.listPost[index],
                    provide: value,
                  );
                }),
          ],
        ),
      ),
    );
  }
}
