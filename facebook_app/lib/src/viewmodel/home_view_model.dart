import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:facebook_app/src/base/base.dart';
import 'package:facebook_app/src/data/base_type/friend_status.dart';
import 'package:facebook_app/src/data/base_type/notification_type.dart';
import 'package:facebook_app/src/data/model/comment.dart';
import 'package:facebook_app/src/data/model/friend.dart';
import 'package:facebook_app/src/data/model/notification/accept_friend_notification.dart';
import 'package:facebook_app/src/data/model/notification/comment_post_notification.dart';
import 'package:facebook_app/src/data/model/notification/like_post_notification.dart';
import 'package:facebook_app/src/data/model/notification/notification_friend.dart';
import 'package:facebook_app/src/data/model/notification/request_friend_notification.dart';
import 'package:facebook_app/src/data/model/post.dart';
import 'package:facebook_app/src/data/model/user.dart';
import 'package:facebook_app/src/data/model/video.dart';
import 'package:facebook_app/src/data/repository/friend_repository.dart';
import 'package:facebook_app/src/data/repository/notification_repository.dart';
import 'package:facebook_app/src/data/repository/photo_repository.dart';
import 'package:facebook_app/src/data/repository/post_repository.dart';
import 'package:facebook_app/src/data/repository/user_repository.dart';

class HomeProvide extends BaseProvide {
  final PostRepository repository;
  final PhotoRepository photoRepository;
  final UserRepository userRepository;
  final FriendRepository friendRepository;
  final NotificationRepository notificationRepository;
  UserEntity _userEntity = UserEntity.origin();

  //lay % tien trinh upload anh
  List<double> _progressPhoto;

  List<double> get progressPhoto => _progressPhoto;

  set progressPhoto(List list) {
    _progressPhoto = list;
    notifyListeners();
  }

//lay % tien trinh upload video
  double _progressVideo = 0;

  double get progressVideo => _progressVideo;

  set progressVideo(double progress) {
    _progressVideo = progress;
    notifyListeners();
  }

  List<Post> _listPost = [];

  List<Post> get listPost => _listPost;

  List<Post> tmpPosts = [];

  List<NotificationApp> _notifications = [];

  List<NotificationApp> get notifications => _notifications;

  List<Friend> _friends = [];

  List<Friend> get friends => _friends;

  // List<Friend> _notFriends = [];
  //
  // List<Friend> get notFriends => _notFriends;

  //Danh sách lời mời kết bạn chờ xác nhận (firstUser là người gửi lời mời kết bạn, currentUser gui)
  List<Friend> _friendWaitConfirm = [];

  List<Friend> get friendWaitConfirm => _friendWaitConfirm;

  //Danh sách lời mời kết bạn tới currentUser (firstUser là người gửi lời mời kết bạn)
  List<Friend> _friendRequest = [];

  List<Friend> get friendRequest => _friendRequest;

  List<Friend> _friendsPending = [];

  List<Friend> get friendsPending => _friendsPending;
  List<UserEntity> _users = [];

  List<UserEntity> get users => _users;

  bool _isTop = true;

  bool get isTop => _isTop;

  set isTop(bool isTop) {
    _isTop = isTop;
    if (_isTop) {
      if (tmpPosts.length > 0) {
        listPost.insertAll(0, tmpPosts);
        tmpPosts.clear();
        notifyListeners();
      }
    }
  }

  bool _loading = false;

  bool get loading => _loading;

  set loading(bool loading) {
    _loading = loading;
    notifyListeners();
  }

  bool _loadingImage = false;

  bool get loadingImage => _loadingImage;

  set loadingImage(bool loading) {
    _loadingImage = loading;
    notifyListeners();
  }

  bool _loadingVideo = false;

  bool get loadingVideo => _loadingVideo;

  set loadingVideo(bool loading) {
    _loadingVideo = loading;
    notifyListeners();
  }

  UserEntity get userEntity => _userEntity;

  set userEntity(UserEntity userEntity) {
    _userEntity = userEntity;
    notifyListeners();
  }

  HomeProvide(this.repository, this.photoRepository, this.userRepository,
      this.friendRepository, this.notificationRepository);

  init() {
    userRepository.getCurrentUser().then((value) {
      userEntity = value;
      // print('user Entity ${value.firstName}');
      _getListPost();
      getFriends(userEntity);
      getFriendsRequest(userEntity);
    //  getFriendsWaitConfirm(userEntity);
      getNotifications();
      getUsers();
    });
  }

  _createPost(Post post) {
    repository
        .createPost(post, userEntity.id)
        .listen((value){loading = true;}, onDone: (){loading = false;});
  }

  Stream<void> _updatePost(Post post) {
    repository
        .updatePost(post, userEntity.id)
        .listen((value){loading = true;}, onDone: (){loading = false;});
  }

  Future<void> upDatePost(Post post,
      {List<String> pathImages, String pathVideos}) async {
    // print(pathImages);
    post.modified = DateTime.now().toString();
    if (pathImages != null && pathImages.isNotEmpty) {
      loadingImage = true;
      _progressPhoto = new List(pathImages.length);
      pathImages.asMap().forEach((index, element) async {
        await photoRepository.uploadPhoto(userEntity.id, element, (urlPath) {
          loadingImage = false;
          // print(urlPath);
          post.images.add(urlPath);
          if (index == pathImages.length - 1) {
            _updatePost(post).listen((event) {
              print("xu ly upload post success o day");
            }, onError: (e) => {print("xu ly upload post fail o day")});
          }
        }, () {
          loadingImage = false;
          print('loi roi xu ly loi upload photo fail ơ đây nhá');
        }, (progress) {
          _progressPhoto[index] = progress;
          print(progress);
          progressPhoto = _progressPhoto;
        });
      });
    } else if (pathVideos != null && pathVideos.isNotEmpty) {
      loadingVideo = true;
      photoRepository.uploadVideo(userEntity.id, pathVideos, (urlPath) {
        loadingVideo = false;
        post.video.url = urlPath;
        _updatePost(post).listen((event) {
          print("xu ly upload post success o day");
        }, onError: (e) => {print("xu ly upload video fail o day")});
      }, () {
        loadingVideo = false;
        print('loi roi xu ly loi upload video fail ơ đây nhá');
      }, (progress) {});
    } else {
      _updatePost(post).listen((event) {
        print("xu ly upload post success o day");
      }, onError: (e) => {print("xu ly upload post fail o day")});
    }
  }

  Future<void> uploadPost(String content,
      {List<String> pathImages, String pathVideos}) async {
    // print(pathImages);
    Post post = Post("-1", content, DateTime.now().toString(),
        DateTime.now().toString(), [], [], [], Video.origin(), userEntity);
    if (pathImages != null && pathImages.isNotEmpty) {
      loadingImage = true;
      _progressPhoto = new List(pathImages.length);
      pathImages.asMap().forEach((index, element) async {
        await photoRepository.uploadPhoto(userEntity.id, element, (urlPath) {
          loadingImage = false;
          // print(urlPath);
          post.images.add(urlPath);
          if (index == pathImages.length - 1) {
            _createPost(post).listen((event) {
              print("xu ly upload post success o day");
            }, onError: (e) => {print("xu ly upload post fail o day")});
          }
        }, () {
          loadingImage = false;
          print('loi roi xu ly loi upload photo fail ơ đây nhá');
        }, (progress) {
          _progressPhoto[index] = progress;
          print(progress);
          progressPhoto = _progressPhoto;
        });
      });
    } else if (pathVideos != null && pathVideos.isNotEmpty) {
      loadingVideo = true;
      photoRepository.uploadVideo(userEntity.id, pathVideos, (urlPath) {
        loadingVideo = false;
        post.video.url = urlPath;
        _createPost(post).listen((event) {
          print("xu ly upload post success o day");
        }, onError: (e) => {print("xu ly upload video fail o day")});
      }, () {
        loadingVideo = false;
        print('loi roi xu ly loi upload video fail ơ đây nhá');
      }, (progress) {});
    } else {
      _createPost(post).listen((event) {
        print("xu ly upload post success o day");
      }, onError: (e) => {print("xu ly upload post fail o day")});
    }
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

  _getListPost() => repository.getListPost().listen((event) async {
        event.docChanges.forEach((element) async {
          DocumentReference documentReference = element.doc.data()['owner'];
          documentReference.get().then((value) {
            UserEntity userPost = UserEntity.fromJson(value.data());
            Post postRoot = Post.fromMap(element.doc.data(), userPost);
            postRoot.isLiked = checkLiked(postRoot.likes);
            if (element.type == DocumentChangeType.added) {
              _insertPost(postRoot);
            } else if (element.type == DocumentChangeType.modified) {
              Post post = postRoot;
              int position = -1;
              position = _listPost.indexWhere(
                (element) =>
                    (element.postId == post.postId) || element.postId == '-1',
              );
              int positionTmp = -1;
              positionTmp = tmpPosts.indexWhere(
                (element) =>
                    (element.postId == post.postId) || element.postId == '-1',
              );
              if (position != -1)
                _listPost[position] = post;
              else if (positionTmp != -1)
                tmpPosts[positionTmp] = post;
              else
                _insertPost(postRoot);
              notifyListeners();
            } else if (element.type == DocumentChangeType.removed) {
              Post post = postRoot;
              _listPost.removeWhere((element) => element.postId == post.postId);
            }
          });
          if (event.docChanges.length != 0) {
            notifyListeners();
          }
        });
      }, onError: (e) => {print("xu ly fail o day")});

  getFriends(UserEntity entity) {
    _friends.clear();
    friendRepository.getFriends(entity.id).listen((event) async {
      event.docChanges.forEach((element) async {
        DocumentReference documentReference = element.doc.data()['second_user'];
        await documentReference.get().then((value) {
          UserEntity second = UserEntity.fromJson(value.data());
          Friend friend = Friend.fromJson(element.doc.data(), entity, second);
          if (element.type == DocumentChangeType.added) {
            // print('add');
            _friends.insert(0, friend);
            notifyListeners();
          } else if (element.type == DocumentChangeType.modified) {
            // print('modified');
            int position = -1;
            position = _friends.indexWhere(
                (element) => (element.userSecond == friend.userSecond));
            if(friend.status == FriendStatus.none){
              _friends.remove(position);
            }
            if (position != -1)
              _friends[position] = friend;
            else
              _friends.insert(0, friend);
            notifyListeners();
          } else if (element.type == DocumentChangeType.removed) {
            _friends.removeWhere(
                (element) => element.userSecond == friend.userSecond);
            notifyListeners();
          }
        });
      });
    }, onError: (e) => {print("xu ly fail o day")});
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
              notifyListeners();
            } else if (element.type == DocumentChangeType.modified) {
              print('removed');
              int position = -1;
              position = _friendRequest.indexWhere(
                  (element) => (element.userSecond == friend.userSecond));
              if(friend.status == FriendStatus.none){
                _friendRequest.remove(position);
              }
              if (position != -1)
                _friendRequest[position] = friend;
              else
                _friendRequest.insert(0, friend);
              notifyListeners();
            } else if (element.type == DocumentChangeType.removed) {
              print('removed');
              _friendRequest.removeWhere(
                  (element) => element.userFirst.id == friend.userFirst.id);
              notifyListeners();

            }
          });
        });
      }, onError: (e) => {print("xu ly fail o day")});

  //lời mời kết bạn đã gui
  getFriendsWaitConfirm(UserEntity entity) =>
      friendRepository.getRequestedFriends(entity.id).listen((event) async {
        print('fiends cua ${entity.id}');
        event.docChanges.forEach((element) async {
          DocumentReference documentReference =
              element.doc.data()['second_user'];
          await documentReference.get().then((value) {
            UserEntity secondUser = UserEntity.fromJson(value.data());
            Friend friend =
                Friend.fromJson(element.doc.data(), entity, secondUser);
            if (element.type == DocumentChangeType.added) {
              _friendWaitConfirm.insert(0, friend);
              notifyListeners();
            } else if (element.type == DocumentChangeType.modified) {
              int position = -1;
              position = _friendWaitConfirm.indexWhere(
                  (element) => (element.userSecond == friend.userSecond));
              if(friend.status == FriendStatus.none){
                _friendWaitConfirm.remove(position);
              }
              if (position != -1)
                _friendWaitConfirm[position] = friend;
              else
                _friendWaitConfirm.insert(0, friend);
              notifyListeners();
            } else if (element.type == DocumentChangeType.removed) {
              _friendWaitConfirm.removeWhere(
                  (element) => element.userSecond == friend.userSecond);
              notifyListeners();
            }
            print('leng wait ${_friendWaitConfirm.length}');
          });
        });
      }, onError: (e) => {print("xu ly fail o day")});

  getNotifications() {
    print('vao notification');
    notificationRepository.getNotifications(userEntity.id).listen(
        (event) async {
      event.docChanges.forEach((element) async {
        DocumentReference documentReference = element.doc.data()['first_user'];
        await documentReference.get().then((value) async {
          UserEntity user = UserEntity.fromJson(value.data());
          // print(user.firstName);
          NotificationApp notification;
          var map = element.doc.data();
          NotificationType type =
              NotificationType.values[int.parse(map['type'].toString())];
          switch (type) {
            case NotificationType.acceptFriend:
              {
                notification = NotificationAcceptFriend(
                    map['id'],
                    user,
                    map['update_time'],
                    map['others'],
                    (map['receivers'] as List)
                        .map((e) => e.toString())
                        .toList());
                _insertNotification(element.type, notification);
                notifyListeners();
              }
              break;
            case NotificationType.requestFriend:
              {
                notification = NotificationRequestFriend(
                    map['id'],
                    user,
                    map['update_time'],
                    map['others'],
                    (map['receivers'] as List)
                        .map((e) => e.toString())
                        .toList());
                _insertNotification(element.type, notification);
                notifyListeners();
              }
              break;
            case NotificationType.likePost:
              {
                DocumentReference documentReference =
                    element.doc.data()['post'];
                documentReference.get().then((postMap) {
                  DocumentReference documentReferenceUser =
                      postMap.data()['owner'];
                  documentReferenceUser.get().then((value) {
                    UserEntity userPost = UserEntity.fromJson(value.data());
                    Post post = Post.fromMap(postMap.data(), userPost);
                    notification = NotificationLikePost(
                        map['id'],
                        post,
                        user,
                        map['update_time'],
                        map['others'],
                        (map['receivers'] as List)
                            .map((e) => e.toString())
                            .toList());
                    _insertNotification(element.type, notification);
                    notifyListeners();
                  });
                });
              }
              break;
            case NotificationType.commentPost:
              {
                DocumentReference documentReference =
                    element.doc.data()['post'];
                documentReference.get().then((postMap) {
                  DocumentReference documentReferenceUser =
                      postMap.data()['owner'];
                  documentReferenceUser.get().then((value) {
                    UserEntity userPost = UserEntity.fromJson(value.data());
                    Post post = Post.fromMap(postMap.data(), userPost);
                    notification = NotificationCommentPost(
                        map['id'],
                        post,
                        user,
                        map['update_time'],
                        map['others'],
                        (map['receivers'] as List)
                            .map((e) => e.toString())
                            .toList());
                    _insertNotification(element.type, notification);
                    notifyListeners();
                  });
                });
              }
              break;
          }
        });
      });
    }, onError: (e) => {print("xu ly fail o day")});
  }

  void updateLike(Post post) {
    // print(post.isLiked);
    if (post.isLiked) {
      post.likes.removeWhere((element) => element.id == userEntity.id);
      repository.updateDisLikePost(post, userEntity);
    } else {
      post.likes.add(userEntity);
      repository.updateLikePost(post, userEntity);
    }
    post.isLiked = !post.isLiked;
  }

  void addComment(Post post, String content) {
    Comment comment = Comment(userEntity, content);
    post.comments.add(comment);
    repository.updateComment(post, comment);
  }

  _insertPost(Post post) {
    if (isTop) {
      _listPost.insert(0, post);
    } else {
      tmpPosts.add(post);
    }
    notifyListeners();
  }

  _insertNotification(DocumentChangeType type, NotificationApp notification) {
    if (type == DocumentChangeType.added) {
      _notifications.insert(0, notification);
    } else if (type == DocumentChangeType.modified) {
      int position = -1;
      position = _notifications
          .indexWhere((element) => (element.id == notification.id));
      if (position != -1)
        _notifications[position] = notification;
      else
        _notifications.insert(0, notification);
    }
  }

  bool checkLiked(List<UserEntity> users) {
    if (users.length == 0) return false;
    return users.firstWhere((element) => element.id == userEntity.id,
            orElse: () => null) !=
        null;
  }

  bool checkFriend(String idSecond) {
    if (idSecond == userEntity.id) return true;
    Friend fr = friends.firstWhere((element) {
      return (element.userSecond.id == idSecond);
    }, orElse: () => null);
    if (fr != null) return true;
    return false;
  }

  bool checkRequestFriend(String idSecond) {
    Friend fr = friendRequest.firstWhere((element) {
      return (element.userSecond.id == idSecond);
    }, orElse: () => null);
    if (fr != null)
      return true;
    else
      return false;
  }

  bool checkWaitingFriend(String idSecond) {
    Friend fr = friendWaitConfirm.firstWhere((element) {
      return (element.userSecond.id == idSecond);
    }, orElse: () => null);
    if (fr != null)
      return true;
    else
      return false;
  }

  int checkStatusFriend(String idSecond) {
    if (checkFriend(idSecond))
      return 1; //da la ban
    else if (checkRequestFriend(idSecond))
      return 2; //dang gui loi toi currentUser
    else if (checkWaitingFriend(idSecond))
      return 3; //currentUser gui loi moi
    else
      return 4; //ko la ban
  }
}
