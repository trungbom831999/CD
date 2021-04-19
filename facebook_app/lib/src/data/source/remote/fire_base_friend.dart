import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:facebook_app/src/data/base_type/friend_status.dart';
import 'package:facebook_app/src/data/model/friend.dart';
import 'package:facebook_app/src/ultils/string_ext.dart';

class FirFriend {
  final FirebaseFirestore _firestore;

  FirFriend(this._firestore);

  createRequestFriend(
      String idUserFirst, String idUserSecond, Function onError) {
    _createRequest(idUserFirst, idUserSecond, FriendStatus.pendingConfirm.index)
        .catchError((error) => onError());
    _createRequest(idUserSecond, idUserFirst, FriendStatus.pending.index)
        .catchError((error) => onError());
  }

  acceptRequest(Friend friend, Function onError) {
    _acceptRequest(friend.userFirst.id, friend.userSecond.id)
        .catchError((error) => onError());
    _acceptRequest(friend.userSecond.id, friend.userFirst.id)
        .catchError((error) => onError());
  }

  deleteRequest(Friend friend, Function onError) {
    _deleteRequest(friend.userFirst.id, friend.userSecond.id)
        .catchError((error) => onError());
    _deleteRequest(friend.userSecond.id, friend.userFirst.id)
        .catchError((error) => onError());
  }

  Stream<QuerySnapshot> getFriends(String id) {
    DocumentReference first = _firestore.doc('users/' + id);
    return _firestore
        .collection('friends')
        .where('first_user', isEqualTo: first)
        .where('status', isEqualTo: FriendStatus.accepted.index)
        .snapshots(includeMetadataChanges: true);
  }

  Stream<QuerySnapshot> getNotFriends(String id) {
    DocumentReference first = _firestore.doc('users/' + id);
    return _firestore
        .collection('friends')
        .where('first_user', isEqualTo: first)
        .where('status', isNotEqualTo: FriendStatus.accepted.index)
        .snapshots(includeMetadataChanges: true);
  }

  //loi moi ket ban
  Stream<QuerySnapshot> getRequestFriends(String id) {
    DocumentReference first = _firestore.doc('users/' + id);
    return _firestore
        .collection('friends')
        .where('first_user', isEqualTo: first)
        .where('status', isEqualTo: FriendStatus.pending.index)
        .snapshots(includeMetadataChanges: true);
  }

// danh sach da gui loi moi ket ban
  Stream<QuerySnapshot> getRequestedFriends(String id) {
    DocumentReference first = _firestore.doc('users/' + id);
    return _firestore
        .collection('friends')
        .where('first_user', isEqualTo: first)
        .where('status', isEqualTo: FriendStatus.pendingConfirm.index)
        .snapshots(includeMetadataChanges: true);
  }

  Future<void> _createRequest(
      String idUserFirst, String idUserSecond, int status) {
    return _firestore
        .collection("friends")
        .doc(idUserFirst.xorString(idUserSecond))
        .set({
      'first_user': _firestore.doc('users/' + idUserFirst),
      'second_user': _firestore.doc('users/' + idUserSecond),
      'created': DateTime.now().toString(),
      'modified': DateTime.now().toString(),
      'status': status
    });
  }

  Future<void> _acceptRequest(String idUserFirst, String idUserSecond) async {
    print('vao accepted $idUserFirst $idUserSecond');
    var ref = await _firestore
        .collection("friends")
        .doc(idUserFirst.xorString(idUserSecond))
        .get();
    print(ref.exists);
    return _firestore
        .collection("friends")
        .doc(idUserFirst.xorString(idUserSecond))
        .update({
      'modified': DateTime.now().toString(),
      'status': FriendStatus.accepted.index
    });
  }

  Future<void> _deleteRequest(String idUserFirst, String idUserSecond) async {
    print('vao delete $idUserFirst $idUserSecond');
    var ref = await _firestore
        .collection("friends")
        .doc(idUserFirst.xorString(idUserSecond))
        .get();
    print(ref.exists);
    return _firestore
        .collection("friends")
        .doc(idUserFirst.xorString(idUserSecond))
        .update({
      'modified': DateTime.now().toString(),
      'status': FriendStatus.none.index
    });
  }
}
