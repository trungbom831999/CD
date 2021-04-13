import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:facebook_app/src/data/model/user.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract class UserRepository {
  Stream<UserCredential> signIn(String email, String password);

  void signUp(
      UserEntity user, Function onSuccess, Function(String code) onError);

  Future<void> setCurrentUser(UserEntity userEntity);

  Future<UserEntity> getCurrentUser();

  Future<void> updateAvatar(
      String pathAvatar, UserEntity userEntity, Function onError);

  Future<void> updateCoverImage(
      String pathCover, UserEntity userEntity, Function onError);

  Stream<void> updateUser(UserEntity userEntity);

  Stream<void> updateDescriptionUser(
      UserEntity userEntity, String description);

  Stream<QuerySnapshot> getAllUsers();

  Stream<DocumentSnapshot> getCurrentUserRealTime(String userId);
  setSaveLogin();
  bool getSaveLogin();
  void logOut();
}
