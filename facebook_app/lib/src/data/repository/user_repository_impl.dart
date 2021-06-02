import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:facebook_app/src/data/model/user.dart';
import 'package:facebook_app/src/data/source/local/user_local_data.dart';
import 'package:facebook_app/src/data/source/remote/fire_base_auth.dart';
import 'package:facebook_app/src/data/source/remote/fire_base_storage.dart';
import 'package:facebook_app/src/data/source/remote/fire_base_user_storage.dart';
import 'package:facebook_app/src/ultils/connect.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'user_repository.dart';

class UserRepositoryImpl implements UserRepository {
  final FirAuth _firAuth;
  final FirUploadPhoto firPhoto;
  final FirUserUpload firUserUpload;
  final UserLocalDatasource _localDatasource;
  static UserEntity currentUser;

  UserRepositoryImpl(
      this._firAuth, this._localDatasource, this.firPhoto, this.firUserUpload){
  }

  @override
  void signUp(
      UserEntity user, Function onSuccess, Function(String code) onError) {
    _firAuth.signUp(user.firstName, user.lastName, user.avatar, user.birthday,
        user.email, user.phone, user.password, user.genre, onSuccess, onError);
  }

  @override
  Stream<UserCredential> signIn(String email, String password) {
    return _firAuth.signIn(email, password);
  }

  @override
  Future<UserEntity> getCurrentUser() async {
    bool isNetworkAvailable = await isAvailableInternet();
    if (isNetworkAvailable) {
      UserEntity entity = await _firAuth.curentUser();
      if (entity != null) setCurrentUser(entity);
      currentUser = entity;
      return entity;
    }
    return Future.value(_localDatasource.getCurrentUserLocal());
  }

  @override
  Future<void> setCurrentUser(UserEntity userEntity) {
    return _localDatasource.setCurrentUser(userEntity);
  }

  @override
  void logOut() {
    _localDatasource.clearUser();
    _firAuth.signOut(() {});
  }

  @override
  Future<void> updateAvatar(
      String pathAvatar, UserEntity userEntity, Function onError) {
    return firPhoto.uploadFile(pathAvatar, (urlPath) {
      userEntity.avatar = urlPath;
      _firAuth.updateUser(userEntity);
      firUserUpload.uploadImage(userEntity.id, urlPath);
    }, onError, (progress) => null);
  }

  @override
  Future<void> updateCoverImage(
      String pathCover, UserEntity userEntity, Function onError) {
    return firPhoto.uploadFile(pathCover, (urlPath) {
      userEntity.coverImage = urlPath;
      _firAuth.updateUser(userEntity);
      firUserUpload.uploadImage(userEntity.id, urlPath);
    }, onError, (progress) => null);
  }

  @override
  Stream<void> updateUser(UserEntity userEntity) {
    _firAuth.updateUser(userEntity);
  }

  @override
  Stream<void> updateDescriptionUser(
      UserEntity userEntity, String description) {
    _firAuth.updateDescriptionUser(userEntity, description);
  }

  @override
  Stream<QuerySnapshot> getAllUsers() => _firAuth.getAllUsers();

  @override
  Stream<DocumentSnapshot> getCurrentUserRealTime(String userId) =>
      _firAuth.getUserRealTime(userId);

  @override
  bool getSaveLogin() {
    return _localDatasource.getSaveLogin();
  }

  @override
  setSaveLogin() {
    _localDatasource.setSaveLogin();
  }
}
