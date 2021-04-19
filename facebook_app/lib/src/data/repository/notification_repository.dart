import 'package:cloud_firestore/cloud_firestore.dart';

abstract class NotificationRepository {
  Stream<QuerySnapshot> getNotifications(String userId);
}
