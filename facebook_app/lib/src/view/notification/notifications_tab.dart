import 'package:facebook_app/src/data/model/notification/notification_friend.dart';
import 'package:facebook_app/src/viewmodel/home_view_model.dart';
import 'package:flutter/material.dart';

import 'components/notification_widget.dart';
class NotificationsTab extends StatelessWidget {
  final HomeProvide provide;

  const NotificationsTab(this.provide);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.fromLTRB(15.0, 15.0, 0.0, 15.0),
                child: Text('Notifications', style: TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold)),
              ),
              for(NotificationApp notification in provide.notifications) NotificationWidget(notification, provide.userEntity, provide)
            ],
          )
      ),
    );
  }
}

