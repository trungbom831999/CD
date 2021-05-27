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
    print('length ${value.listPost.length} max trong nay ${value.maxPost}');
    return NotificationListener<ScrollNotification>(
      onNotification: (scrollInfo) {
        if (!value.loading &&
            scrollInfo.metrics.pixels == scrollInfo.metrics.maxScrollExtent) {
          print('bottom roi');
          value.isBottom = true;
        }
        return true;
      },
      child: RefreshIndicator(
        onRefresh: () async {
          value.getListPost();
        },
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              WriteSomethingWidget(
                provide: value,
              ),
              SeparatorWidget(),
              // OnlineWidget(),
              Visibility(
                  visible: value.loadingImage || value.loadingVideo,
                  child: LinearProgressIndicator()),
              Visibility(
                  visible: value.loadingImage || value.loadingVideo,
                  child: SeparatorWidget()),
              // StoriesWidget(),
              for (int i = 0; i < value.maxPost; i++)
                PostWidget(
                  post: value.listPost[i],
                  provide: value,
                ),
            ],
          ),
        ),
      ),
    );
  }
}
