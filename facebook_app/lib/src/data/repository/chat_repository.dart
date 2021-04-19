import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:facebook_app/src/data/model/messages.dart';

abstract class ChatRepository {
  Future<void> sendMessage(Message message, String userIdFrom, String userIdTo);

  Stream<QuerySnapshot> getConservations(String userId);

  Stream<DocumentSnapshot> getChat(String conservationId);

}
