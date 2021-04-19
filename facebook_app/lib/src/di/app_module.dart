import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartin/dartin.dart';
import 'package:facebook_app/src/data/repository/chat_repository.dart';
import 'package:facebook_app/src/data/repository/chat_repository_impl.dart';
import 'package:facebook_app/src/data/repository/friend_repository.dart';
import 'package:facebook_app/src/data/repository/friend_repository_impl.dart';
import 'package:facebook_app/src/data/repository/notification_repository.dart';
import 'package:facebook_app/src/data/repository/notification_repository_impl.dart';
import 'package:facebook_app/src/data/repository/photo_repository.dart';
import 'package:facebook_app/src/data/repository/photo_repository_impl.dart';
import 'package:facebook_app/src/data/repository/post_repository.dart';
import 'package:facebook_app/src/data/repository/post_repository_impl.dart';
import 'package:facebook_app/src/data/repository/user_repository.dart';
import 'package:facebook_app/src/data/repository/user_repository_impl.dart';
import 'package:facebook_app/src/data/source/local/user_local_data.dart';
import 'package:facebook_app/src/data/source/remote/fire_base_auth.dart';
import 'package:facebook_app/src/data/source/remote/fire_base_chat.dart';
import 'package:facebook_app/src/data/source/remote/fire_base_friend.dart';
import 'package:facebook_app/src/data/source/remote/fire_base_notification.dart';
import 'package:facebook_app/src/data/source/remote/fire_base_post.dart';
import 'package:facebook_app/src/data/source/remote/fire_base_storage.dart';
import 'package:facebook_app/src/data/source/remote/fire_base_user_storage.dart';
import 'package:facebook_app/src/ultils/share_prefs.dart';
import 'package:facebook_app/src/viewmodel/chat_view_model.dart';
import 'package:facebook_app/src/viewmodel/friend_profile_view_model.dart';
import 'package:facebook_app/src/viewmodel/friend_view_model.dart';
import 'package:facebook_app/src/viewmodel/home_view_model.dart';
import 'package:facebook_app/src/viewmodel/login_view_model.dart';
import 'package:facebook_app/src/viewmodel/profile_view_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

const testScope = DartInScope('test');

//viewmodel

final viewModelModule = Module([
  factory<LoginProvide>(({params}) => LoginProvide(get())),
  factory<HomeProvide>(({params}) => HomeProvide(get(), get(), get(), get(), get())),
  factory<ProfileProvide>(
          ({params}) => ProfileProvide(get(), get(), get(), get(), get())),
  factory<ProfileFriendProvide>(
          ({params}) => ProfileFriendProvide(get(), get(), get(), get(), get(), params.get(0))),
  factory<FriendProvide>(
          ({params}) => FriendProvide(get(), get(), get(), get(), get())),
  single<ChatProvide>(({params}) => ChatProvide(get(), get(), get(), get())),
]);

final repoModule = Module([
  factory<UserRepository>(
          ({params}) => UserRepositoryImpl(get(), get(), get(), get())),
  factory<PostRepository>(({params}) => PostRepositoryImpl(get(), get(), get())),
  factory<PhotoRepository>(({params}) => PhotoRepositoryImpl(get(), get())),
  factory<FriendRepository>(({params}) => FriendRepositoryImpl(get(), get())),
  factory<ChatRepository>(({params}) => ChatRepositoryImpl(get(), get())),
  factory<NotificationRepository>(({params}) => NotificationRepositoryImpl(get())),
]);

//remote
final remoteModule = Module([
  factory<FirAuth>(({params}) => FirAuth(get())),
  factory<FirPost>(({params}) => FirPost(get())),
  factory<FirUploadPhoto>(({params}) => FirUploadPhoto(get())),
  factory<FirUserUpload>(({params}) => FirUserUpload(get())),
  factory<FirFriend>(({params}) => FirFriend(get())),
  factory<FirChat>(({params}) => FirChat(get())),
  factory<FirNotification>(({params}) => FirNotification(get())),
]);

final firebase = Module([
  factory<FirebaseAuth>(({params}) => FirebaseAuth.instance),
  factory<FirebaseFirestore>(({params}) => FirebaseFirestore.instance),
  factory<FirebaseStorage>(({params}) => FirebaseStorage.instance),
]);

final localModule = Module([
  single<SpUtil>(({params}) => spUtil),
  single<UserLocalDatasource>(({params}) => UserLocalDatasource(get())),
]);

final appModule = [
  viewModelModule,
  repoModule,
  firebase,
  remoteModule,
  localModule
];

SpUtil spUtil;

init() async {
  spUtil = await SpUtil.getInstance();
  print('vao day roi $spUtil');
  // DartIn start
  startDartIn(appModule);
}
