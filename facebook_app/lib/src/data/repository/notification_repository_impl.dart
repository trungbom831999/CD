import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:facebook_app/src/data/source/remote/fire_base_notification.dart';

import 'notification_repository.dart';

class NotificationRepositoryImpl extends NotificationRepository {
  final FirNotification _firNotification;

  NotificationRepositoryImpl(this._firNotification);

  @override
  Stream<QuerySnapshot> getNotifications(String userId) =>
      _firNotification.getNotifications(userId);
}
