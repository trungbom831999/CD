import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:facebook_app/src/data/model/friend.dart';
import 'package:facebook_app/src/data/model/post.dart';
import 'package:facebook_app/src/data/model/user.dart';
import 'package:facebook_app/src/data/model/video.dart';
import 'package:facebook_app/src/data/repository/friend_repository.dart';
import 'package:facebook_app/src/data/repository/notification_repository.dart';
import 'package:facebook_app/src/data/repository/photo_repository.dart';
import 'package:facebook_app/src/data/repository/post_repository.dart';
import 'package:facebook_app/src/data/repository/user_repository.dart';
import 'package:facebook_app/src/viewmodel/home_view_model.dart';

class FriendProvide extends HomeProvide {
  //Danh sách lời mời kết bạn chờ xác nhận (firstUser là người gửi lời mời kết bạn, currentUser gui)
  List<Friend> _friendWaitConfirm = [];

  List<Friend> get friendWaitConfirm => _friendWaitConfirm;

  //Danh sách lời mời kết bạn tới currentUser (firstUser là người gửi lời mời kết bạn)
  List<Friend> _friendRequest = [];

  List<Friend> get friendRequest => _friendRequest;

  FriendProvide(
      PostRepository repository,
      PhotoRepository photoRepository,
      UserRepository userRepository,
      FriendRepository friendRepository,
      NotificationRepository notificationRepository)
      : super(repository, photoRepository, userRepository, friendRepository,
            notificationRepository){
    userRepository.getCurrentUser().then((value){
      userEntity = value;
      getFriendsRequest(value);
    });
  }

  //lời mời kết bạn đã nhan
  getFriendsRequest(UserEntity entity) =>
      friendRepository.getRequestFriends(entity.id).listen((event) async {
        event.docChanges.forEach((element) async {
          DocumentReference documentReference =
              element.doc.data()['second_user'];
          await documentReference.get().then((value) {
            UserEntity second = UserEntity.fromJson(value.data());
            Friend friend = Friend.fromJson(element.doc.data(), entity, second);
            if (element.type == DocumentChangeType.added) {
              _friendRequest.insert(0, friend);
            } else if (element.type == DocumentChangeType.modified) {
              print('removed');
              int position = -1;
              position = _friendRequest.indexWhere(
                  (element) => (element.userSecond == friend.userSecond));
              if (position != -1)
                _friendRequest[position] = friend;
              else
                _friendRequest.insert(0, friend);
            } else if (element.type == DocumentChangeType.removed) {
              print('removed');
              _friendRequest.removeWhere(
                  (element) => element.userFirst.id == friend.userFirst.id);
            }
          });
          if (event.docChanges.length != 0) {
            notifyListeners();
          }
        });
      }, onError: (e) => {print("xu ly fail o day")});

  //lời mời kết bạn đã gui
  getFriendsWaitConfirm(UserEntity entity) =>
      friendRepository.getRequestedFriends(entity.id).listen((event) async {
        event.docChanges.forEach((element) async {
          DocumentReference documentReference =
              element.doc.data()['second_user'];
          await documentReference.get().then((value) {
            UserEntity firstUser = UserEntity.fromJson(value.data());
            Friend friend =
                Friend.fromJson(element.doc.data(), firstUser, entity);
            if (element.type == DocumentChangeType.added) {
              _friendWaitConfirm.insert(0, friend);
            } else if (element.type == DocumentChangeType.modified) {
              int position = -1;
              position = _friendWaitConfirm.indexWhere(
                  (element) => (element.userSecond == friend.userSecond));
              if (position != -1)
                _friendWaitConfirm[position] = friend;
              else
                _friendWaitConfirm.insert(0, friend);
            } else if (element.type == DocumentChangeType.removed) {
              _friendWaitConfirm.removeWhere(
                  (element) => element.userSecond == friend.userSecond);
            }
          });
          if (event.docChanges.length != 0) {
            notifyListeners();
          }
        });
      }, onError: (e) => {print("xu ly fail o day")});

  //tao fr
  createRequest(UserEntity userEntity, String idSecondUser) {
    print('create fr');
    friendRepository.createRequestFriend(userEntity, idSecondUser, () {});
    notifyListeners();
  }

  //dong y ket ban
  acceptRequest(Friend friend) {
    print('accrpt fr');
    friendRepository.acceptRequest(friend, () {});
    notifyListeners();
  }

  //huy ket ban
  deleteRequest(Friend friend) {
    print('delete fr');
    friendRepository.deleteRequest(friend, () {});
    notifyListeners();
  }
}
