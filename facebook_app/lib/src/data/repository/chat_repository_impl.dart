import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:facebook_app/src/data/model/messages.dart';
import 'package:facebook_app/src/data/source/remote/fire_base_auth.dart';
import 'package:facebook_app/src/data/source/remote/fire_base_chat.dart';

import 'chat_repository.dart';

class ChatRepositoryImpl implements ChatRepository {
  final FirChat _firChat;
  final FirAuth _firAuth;
  ChatRepositoryImpl(this._firChat, this._firAuth);

  @override
  Stream<DocumentSnapshot> getChat(String conservationId) =>
   _firChat.getChat(conservationId);

  @override
  Stream<QuerySnapshot> getConservations(String userId) => _firChat.getConservations(userId);

  @override
  Future<void> sendMessage(Message message, String userIdFrom, String userIdTo) {
   return _firChat.sendMessage(message, userIdFrom, userIdTo);
  }

}
