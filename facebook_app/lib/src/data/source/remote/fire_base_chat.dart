import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:facebook_app/src/data/model/messages.dart';
import 'package:facebook_app/src/ultils/string_ext.dart';

class FirChat {
  final FirebaseFirestore _firestore;

  FirChat(this._firestore);

  Future<void> sendMessage(Message message, String userIdFrom,
      String userIdTo) async {
    var document =
    _firestore.collection('chats').doc(userIdFrom.encryptDecrypt(userIdTo));
    print("path ${userIdFrom.encryptDecrypt(userIdTo)}");
    var usersRef = await document.get();
    Future<void> future = null;
    if (usersRef.exists) {
      print('ton tai');
      future = document.update({
        'messages': FieldValue.arrayUnion([
          message.toMap(_firestore.doc('users/' + userIdFrom),
              _firestore.doc('users/' + userIdTo))
        ])
      }).then((value) {
        print('xong roi nay');
        _updateCurrentMessage(message, userIdFrom, userIdTo);
      });
    } else {
      print('khong ton tai');
      future = document.set({
        'messages': [
          message.toMap(_firestore.doc('users/' + userIdFrom),
              _firestore.doc('users/' + userIdTo))
        ]
      }).then((value) {
        _updateCurrentMessage(message, userIdFrom, userIdTo);
      });
    }
    return future;
  }

  Future<void> _updateCurrentMessage(Message message, String userIdFrom,
      String userIdTo) async {
    print('di vao day conservation');
    var from = _firestore.doc('users/' + userIdFrom);
    var to = _firestore.doc('users/' + userIdTo);
    var document = _firestore.collection('conservations').doc(
        userIdFrom.encryptDecrypt(userIdTo));
    var usersRef =
    await document.get();
    Future<void> future = null;
    if (usersRef.exists) {
      print('exits conservation');
      future = document
          .update({
        'current_message': message.toMap(from, to)});
    } else {
      print('non exists conservation');
      future = document
          .set({
        'id': userIdFrom.encryptDecrypt(userIdTo),
        'two_id': [userIdFrom, userIdTo],
        'current_message': message.toMap(from, to)});
    }
    return future;
  }

  Stream<QuerySnapshot> getConservations(String userId) =>
      _firestore
          .collection('conservations')
          .where('two_id', arrayContains: userId)
          .snapshots(includeMetadataChanges: true);

  Stream<DocumentSnapshot> getChat(String conservationId) =>
      _firestore
          .collection('chats')
          .doc(conservationId)
          .snapshots(includeMetadataChanges: true);
}
