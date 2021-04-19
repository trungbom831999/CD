import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:date_format/date_format.dart';
import 'package:facebook_app/src/data/model/user.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:rxdart/rxdart.dart';

class FirAuth {
  final FirebaseAuth _firebaseAuth;

  FirAuth(this._firebaseAuth);

  Stream<UserCredential> signIn(String email, String password) {
    return Stream.fromFuture(_firebaseAuth.signInWithEmailAndPassword(
        email: email, password: password));
  }

  Future<void> signOut(Function signOut) {
    _firebaseAuth.signOut().then((value) {
      signOut();
    });
  }

  Future<void> signUp(
      String firstName,
      String lastName,
      String avatar,
      String birthday,
      String email,
      String phone,
      String password,
      String genre,
      Function onSuccess,
      Function(String code) onError) {
    return _firebaseAuth
        .createUserWithEmailAndPassword(email: email, password: password)
        .then((value) {
      print('vao day roi');
      print(value.user.uid);
      _createUser(
          UserEntity(value.user.uid, firstName, lastName, '', birthday, email,
              phone, password, genre),
          value.user.uid,
          onSuccess);
    }).catchError((err) {
      print('vào lỗi rồi');
      print(err);
      onError(err.code);
    });
  }

   Stream<void> updateUser(UserEntity userEntity) {
    Future<void> future = FirebaseFirestore.instance
        .collection("users")
        .doc(userEntity.id)
        .update(userEntity.userToMap());
    return Stream.fromFuture(future);
  }

  Stream<void> updateDescriptionUser(UserEntity userEntity, String description) {
    Future<void> future = FirebaseFirestore.instance
        .collection("users")
        .doc(userEntity.id)
        .update({
      'description': description
    });
    return Stream.fromFuture(future);
  }

  Future<UserEntity> curentUser() async {
    User user = await _firebaseAuth.currentUser;
    UserEntity userEntity;
    CollectionReference users = FirebaseFirestore.instance.collection('users');
    if (user != null) {
      await users.doc(user.uid).get().then((value) {
        userEntity = UserEntity.fromJson(value.data());
      }).catchError((onError){
        print(onError);
      });
    }
    return userEntity;
  }

  Stream<QuerySnapshot> getAllUsers() =>
      FirebaseFirestore.instance
          .collection('users')
          .snapshots(includeMetadataChanges: true);

  Stream<DocumentSnapshot> getUserRealTime(String userId) =>
      FirebaseFirestore.instance
          .collection('users')
          .doc(userId)
          .snapshots(includeMetadataChanges: true);

  _createUser(UserEntity user, String document, Function onSuccess) {
    user.avatar = "https://1.bp.blogspot.com/-A7UYXuVWb_Q/XncdHaYbcOI/AAAAAAAAZhM/hYOevjRkrJEZhcXPnfP42nL3ZMu4PvIhgCLcBGAsYHQ/s1600/Trend-Avatar-Facebook%2B%25281%2529.jpg";
    user.coverImage ="https://www.gocbao.com/wp-content/uploads/2020/04/anh-bia-phong-canh-dep-25.jpg";
    var db = FirebaseFirestore.instance;
    db
        .collection("users")
        .doc(document)
        .set(user.userToMap())
        .catchError((onError) {
      print(onError);
    }).then((value) {
      onSuccess();
      FirebaseFirestore.instance.collection("images").doc(document).set({
        'my_images':[]
      });
      FirebaseFirestore.instance.collection("videos").doc(document).set({
        'my_videos':[]
      });
    });
  }
}
