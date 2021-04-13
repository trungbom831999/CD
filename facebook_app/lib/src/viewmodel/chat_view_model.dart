import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:facebook_app/src/base/base.dart';
import 'package:facebook_app/src/data/base_type/message_type.dart';
import 'package:facebook_app/src/data/model/conservation.dart';
import 'package:facebook_app/src/data/model/friend.dart';
import 'package:facebook_app/src/data/model/messages.dart';
import 'package:facebook_app/src/data/model/user.dart';
import 'package:facebook_app/src/data/repository/chat_repository.dart';
import 'package:facebook_app/src/data/repository/friend_repository.dart';
import 'package:facebook_app/src/data/repository/photo_repository.dart';
import 'package:facebook_app/src/data/repository/user_repository.dart';
import 'package:facebook_app/src/ultils/string_ext.dart';

import '../data/model/user.dart';

class ChatProvide extends BaseProvide {
  final UserRepository userRepository;
  final FriendRepository friendRepository;
  final ChatRepository chatRepository;
  final PhotoRepository photoRepository;

  ChatProvide(this.userRepository, this.friendRepository, this.chatRepository,
      this.photoRepository) {
    userRepository.getCurrentUser().then((value) {
      userEntity = value;
      getFriends(value);
      getUsers();
      getConservations(value);
    });
  }

  UserEntity _userEntity = UserEntity.origin();

  UserEntity get userEntity => _userEntity;

  set userEntity(UserEntity userEntity) {
    _userEntity = userEntity;
    notifyListeners();
  }

  List<Friend> _friends = [];

  List<Friend> get friends => _friends;

  List<Conservation> _conservations = [];

  List<Conservation> get conservations => _conservations;

  List<Message> _messages = [];

  List<Message> get messages => _messages;

  List<UserEntity> _users = [];

  List<UserEntity> get users => _users;

  getFriends(UserEntity entity) =>
      friendRepository.getFriends(entity.id).listen((event) async {
        event.docChanges.forEach((element) async {
          DocumentReference documentReference =
          element.doc.data()['second_user'];
          await documentReference.get().then((value) {
            UserEntity second = UserEntity.fromJson(value.data());
            Friend friend = Friend.fromJson(element.doc.data(), entity, second);
            if (element.type == DocumentChangeType.added) {
              _friends.insert(0, friend);
            } else if (element.type == DocumentChangeType.modified) {
              int position = -1;
              position = _friends.indexWhere(
                      (element) => (element.userSecond == friend.userSecond));

              if (position != -1)
                _friends[position] = friend;
              else
                _friends.insert(0, friend);
            } else if (element.type == DocumentChangeType.removed) {
              _friends.removeWhere(
                      (element) => element.userSecond == friend.userSecond);
            }
          });
          if (event.docChanges.length != 0) {
            notifyListeners();
          }
        });
      }, onError: (e) => {print("xu ly fail o day")});

  getConservations(UserEntity entity) {
    _conservations.clear();
    chatRepository.getConservations(userEntity.id).listen((event) async {
      event.docChanges.forEach((element) async {
        DocumentReference documentReferenceFrom =
        element.doc.data()['current_message']['from'];
        DocumentReference documentReferenceTo =
        element.doc.data()['current_message']['to'];
        await documentReferenceFrom.get().then((value) {
          UserEntity from = UserEntity.fromJson(value.data());
          documentReferenceTo.get().then((value) {
            UserEntity to = UserEntity.fromJson(value.data());
            var conservation =
            Conservation.fromMap(element.doc.data(), from, to);
            print(conservation.currentMessage.message);
            if (element.type == DocumentChangeType.added) {
              print('add');
              print('from ${conservation.currentMessage.from.lastName} mess ${conservation.currentMessage}');
              _conservations.insert(0, conservation);
              notifyListeners();
            } else if (element.type == DocumentChangeType.modified) {
              print('modified');
              print('conservation ${conservation.currentMessage.from.lastName} ${conservation.currentMessage.to.lastName} ${conservation.currentMessage}');
              var index = -1;
              index = _conservations.indexWhere(
                    (element) =>
                (element.id == conservation.id) || element.id == '-1',
              );
              print('index $index');
              if(index == -1) _conservations.insert(0, conservation);
              else {
                _conservations.removeAt(index);
                _conservations.insert(0, conservation);
              }
              conservations.forEach((element) {
                // print('conservation ${element.currentMessage.from.lastName} ${element.currentMessage.to.lastName} ${element.currentMessage}');
              });
              notifyListeners();
            } else if (element.type == DocumentChangeType.removed) {
              _conservations
                  .removeWhere((element) => element.id == conservation.id);
              notifyListeners();
            }
          });
        });
      });
    }, onError: (e) => {print("xu ly fail o day")});
  }

  getUsers() {
    _users.clear();
    userRepository.getAllUsers().listen((event) async {
      event.docChanges.forEach((element) async {
        UserEntity entity = UserEntity.fromJson(element.doc.data());
        _users.add(entity);
      });
    }, onError: (e) => {print("xu ly fail o day")});
  }

  Future<void> getChatDetail(
      {Conservation conservation, UserEntity friend}) async {
    _messages.clear();
    String conservationId = '';
    UserEntity user = UserEntity.origin();
    if (friend != null) {
      conservationId = userEntity.id.encryptDecrypt(friend.id);
      user = friend;
    } else {
      conservationId = conservation.id;
      user = conservation.checkFriend(userEntity.id);
    }
    var document = FirebaseFirestore.instance
        .collection('conservations')
        .doc(conservationId);
    var ref = await document.get();
    if (ref.exists) {
      chatRepository.getChat(conservationId).listen((event) async {
        _messages = (event.data()['messages'] as List)
            .map((e) => convertToMessage(e, userEntity, user))
            .toList();
        print(_messages.length);
        notifyListeners();
      }, onError: (e) => {print("xu ly fail o day")});
    } else {
      FirebaseFirestore.instance
          .collection('conservations')
          .doc(conservationId)
          .set({
        "id": userEntity.id.encryptDecrypt(friend.id),
        "two_id":[userEntity.id, friend.id]
      });
      FirebaseFirestore.instance
          .collection('chats')
          .doc(conservationId)
          .set({});
      chatRepository.getChat(conservationId).listen((event) async {
        _messages = (event.data()['messages'] as List)
            .map((e) => convertToMessage(e, userEntity, friend))
            .toList();
        notifyListeners();
      }, onError: (e) => {print("xu ly fail o day")});
    }
  }

  Message convertToMessage(Map map, UserEntity first, UserEntity second) {
    DocumentReference documentReferenceFrom = map['from'];
    DocumentReference documentReferenceFirst =
    FirebaseFirestore.instance.collection("users").doc(first.id);
    if (documentReferenceFrom.path == documentReferenceFirst.path) {
      return Message.fromMap(map, first, second);
    }
    return Message.fromMap(map, second, first);
  }

  sendMessage(UserEntity to, {String path, String content}) {
    if (path != null) {
      photoRepository.uploadPhoto(userEntity.id, path, (path) {
        Message message = Message(
            userEntity, to, path, DateTime.now().toString(), MessageType.image);
        chatRepository.sendMessage(message, message.from.id, message.to.id);
      }, () {}, (progress) {});
      notifyListeners();
    }else{
      Message message = Message(
          userEntity, to, content, DateTime.now().toString(), MessageType.text);
      chatRepository.sendMessage(message, message.from.id, message.to.id);
      notifyListeners();
    }
  }
}
