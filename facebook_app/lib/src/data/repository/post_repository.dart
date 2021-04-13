import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:facebook_app/src/data/model/comment.dart';
import 'package:facebook_app/src/data/model/post.dart';
import 'package:facebook_app/src/data/model/user.dart';

abstract class PostRepository {
  Stream<void> createPost(Post post, String userId);

  Stream<void> updatePost(Post post, String userId);

  Stream<void> updateLikePost(Post post, UserEntity userEntity);

  Stream<void> updateDisLikePost(Post post, UserEntity userEntity);

  Stream<void> updateComment(Post post, Comment comment);

  Stream<QuerySnapshot> getListPost();

  Stream<QuerySnapshot> getUserListPost(String userId);
}
