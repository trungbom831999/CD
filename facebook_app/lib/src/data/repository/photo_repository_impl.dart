
import 'package:facebook_app/src/data/model/video.dart';
import 'package:facebook_app/src/data/repository/photo_repository.dart';
import 'package:facebook_app/src/data/source/remote/fire_base_storage.dart';
import 'package:facebook_app/src/data/source/remote/fire_base_user_storage.dart';

class PhotoRepositoryImpl extends PhotoRepository {
  FirUploadPhoto firPhoto;
  FirUserUpload firUserUpload;

  PhotoRepositoryImpl(this.firPhoto, this.firUserUpload);

  @override
  Future<void> uploadPhoto(
      String idOwner,
      String filePath,
      Function(String urlPath) onSuccess,
      Function onError,
      Function(double) onProgress) {
    firPhoto.uploadFile(filePath, (url) {
      firUserUpload.uploadImage(idOwner, url);
      onSuccess(url);
    }, onError, onProgress);
  }

  @override
  Future<void> uploadVideo(
          String idOwner,
          String filePath,
          Function(String urlPath) onSuccess,
          Function onError,
          Function(double) onProgress) =>
      firPhoto.uploadVideo(filePath, (url) {
        firUserUpload.uploadVideo(idOwner, Video(url, ""));
        onSuccess(url);
      }, onError, onProgress);

  @override
  Stream<List<String>> getImagesByUser(String userId) {
    return firUserUpload.getImagesByUserId(userId).map((event) =>
        ((event.data()['my_images']) as List)
            .map((e) => e.toString())
            .toList());
  }

  @override
  Stream<List<Video>> getVideosByUser(String userId) {
    return firUserUpload.getVideos(userId).map((map) =>
        (map['my_videos'] as List).map((e) => Video.fromJson(e)).toList());
  }
}
