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
import 'package:facebook_app/src/data/repository/user_repository_impl.dart';
import 'package:facebook_app/src/viewmodel/home_view_model.dart';

class ProfileProvide extends HomeProvide {
  List<Post> _userListPost = [];

  List<Post> get userListPost => _userListPost;

  List<String> _photos = [];

  List<String> get photos => _photos;

  List<Video> _videos = [];

  List<Video> get videos => _videos;

  void init() {
    userRepository
        .getCurrentUserRealTime(UserRepositoryImpl.currentUser.id)
        .listen((event) {
      userEntity = UserEntity.fromJson(event.data());
      notifyListeners();
    });
    getFriends(UserRepositoryImpl.currentUser);
    // getNotFriends(userEntity);
    getFriendsRequest(UserRepositoryImpl.currentUser);
    getFriendsWaitConfirm(UserRepositoryImpl.currentUser);
    getUserListPost(userEntity.id);
    getUserPhotos(userEntity.id);
    getUserVideos(userEntity.id);
  }

  ProfileProvide(
      PostRepository repository,
      PhotoRepository photoRepository,
      UserRepository userRepository,
      FriendRepository friendRepository,
      NotificationRepository notificationRepository)
      : super(repository, photoRepository, userRepository, friendRepository,
            notificationRepository);

  getUserListPost(String userId) {
    _userListPost.clear();
    return repository.getUserListPost(userId).listen((event) async {
      event.docChanges.forEach((element) async {
        DocumentReference documentReference = element.doc.data()['owner'];
        documentReference.get().then((value) {
          UserEntity userPost = UserEntity.fromJson(value.data());
          Post postRoot = Post.fromMap(element.doc.data(), userPost);
          postRoot.isLiked = checkLiked(postRoot.likes);
          if (element.type == DocumentChangeType.added) {
            _userListPost.insert(0, postRoot);
          } else if (element.type == DocumentChangeType.modified) {
            Post post = postRoot;
            int position = -1;
            position = _userListPost.indexWhere(
              (element) =>
                  (element.postId == post.postId) || element.postId == '-1',
            );
            if (position != -1)
              _userListPost[position] = post;
            else
              _userListPost.insert(0, post);
          } else if (element.type == DocumentChangeType.removed) {
            Post post = postRoot;
            _userListPost
                .removeWhere((element) => element.postId == post.postId);
          }
        });
        if (event.docChanges.length != 0) {
          notifyListeners();
        }
      });
    }, onError: (e) => {print("xu ly fail o day")});
  }

  updateAvatar(String pathAvatar) {
    userRepository.updateAvatar(pathAvatar, userEntity, () {});
    notifyListeners();
  }

  updateCover(String pathCoverImage) {
    userRepository.updateCoverImage(pathCoverImage, userEntity, () {});
    notifyListeners();
  }

  updateUser(UserEntity userEntity) {
    userRepository.updateUser(userEntity).listen((event) {}, onError: (error) {
      print(error);
    }).onDone(() {});
  }

  updateDescriptionUser(UserEntity userEntity, String description) {
    userRepository.updateDescriptionUser(userEntity, description).listen(
        (event) {
      print("loading");
    }, onError: (error) {
      print(error);
    }).onDone(() {
      print("done");
    });
  }

  getUserPhotos(String userId) =>
      photoRepository.getImagesByUser(userId).listen((event) {
        _photos.addAll(event);
        notifyListeners();
      });

  getUserVideos(String userId) =>
      photoRepository.getVideosByUser(userId).listen((event) {
        _videos.addAll(event);
        notifyListeners();
      });
}
