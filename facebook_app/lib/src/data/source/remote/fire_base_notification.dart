import 'dart:convert';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:facebook_app/src/data/model/comment.dart';
import 'package:facebook_app/src/data/model/notification/accept_friend_notification.dart';
import 'package:facebook_app/src/data/model/notification/comment_post_notification.dart';
import 'package:facebook_app/src/data/model/notification/like_post_notification.dart';
import 'package:facebook_app/src/data/model/notification/request_friend_notification.dart';
import 'package:facebook_app/src/data/model/post.dart';
import 'package:facebook_app/src/data/model/user.dart';


class FirNotification {
  final FirebaseFirestore _firestore;

  FirNotification(this._firestore);

  Future<void> createNotificationFriend(
      UserEntity userFirst, String idUserSecond) {
    var notification = NotificationAcceptFriend(
      _getRandString(6),
        userFirst, DateTime.now().toString(), 0, [idUserSecond]);
    return _firestore
        .collection('notification')
        .add(notification.toMap(_firestore.doc('users/' + userFirst.id)));
  }

  Future<void> createNotificationRequestFriend(
      UserEntity userFirst, String idUserSecond) {
    var notification = NotificationRequestFriend(
        _getRandString(6),
        userFirst, DateTime.now().toString(), 0, [idUserSecond]);
    return _firestore
        .collection('notification')
        .add(notification.toMap(_firestore.doc('users/' + userFirst.id)));
  }

  Future<void> updateNotificationLikePost(
      Post post, UserEntity userFirst) async {
    var ref =
        await _firestore.collection('notification').doc(post.postId).get();
    Future<void> future = null;
    var now = DateTime.now().toString();
    var receiver = post.comments.map((e) => e.user.id).toList();
    receiver.add(post.owner.id);
    var notification = NotificationLikePost(_getRandString(6),post, userFirst, now, 0, receiver);
    if (ref.exists) {
      future = _firestore.collection('notification').doc(post.postId).update({
        "first_user": _firestore.doc('users/' + userFirst.id),
        "others": FieldValue.increment(1),
        "receivers": receiver,
      });
    } else {
      future = _firestore.collection('notification').doc(post.postId).set(
          notification.toMap(_firestore.doc('users/' + userFirst.id),
              post: _firestore.doc('posts/' + post.postId)));
    }
    return future;
  }

  Future<void> updateNotificationDisLikePost(
      Post post, UserEntity userFirst) async {
    var ref =
        await _firestore.collection('notification').doc(post.postId).get();
    Future<void> future = null;
    var now = DateTime.now().toString();
    if (ref.exists) {
      future = _firestore.collection('notification').doc(post.postId).update({
        "others": FieldValue.increment(-1),
        "update_time": now,
      });
    }
    return future;
  }

  Future<void> updateNotificationCommentPost(Post post, Comment comment) async {
    var ref =
        await _firestore.collection('notification').doc(post.postId).get();
    Future<void> future = null;
    var now = DateTime.now().toString();
    var receiver = post.comments.map((e) => e.user.id);
    var notification = NotificationCommentPost(
        _getRandString(6), post, comment.user, now, 0, receiver);
    if (ref.exists) {
      future = _firestore.collection('notification').doc(post.postId).update({
        "first_user": _firestore.doc('users/' + comment.user.id),
        "others": FieldValue.increment(1),
        "update_time": now,
        "receivers": receiver,
      });
    } else {
      future = _firestore.collection('notification').doc(post.postId).set(
          notification.toMap(_firestore.doc('users/' + comment.user.id),
              post: _firestore.doc('posts/' + post.postId)));
    }
    return future;
  }

  Stream<QuerySnapshot> getNotifications(String userId) => _firestore
      .collection('notification')
      .where('receivers', arrayContains: userId)
      .snapshots(includeMetadataChanges: true);
}

String _getRandString(int len) {
  var random = Random.secure();
  var values = List<int>.generate(len, (i) => random.nextInt(255));
  return base64UrlEncode(values);
}
