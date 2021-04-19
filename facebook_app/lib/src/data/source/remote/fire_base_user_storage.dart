import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:facebook_app/src/data/model/video.dart';

class FirUserUpload {
  final FirebaseFirestore _firestore;

  FirUserUpload(this._firestore);

  Stream<void> uploadImage(String idOwner, String url) {
    Future<void> future = _firestore.collection("images").doc(idOwner).update({
      'my_images': FieldValue.arrayUnion([url])
    }).catchError((onError) => {print('loi o day $onError')});
    return Stream.fromFuture(future);
  }

  Stream<void> uploadVideo(String idOwner, Video video) {
    Future<void> future = _firestore.collection("videos").doc(idOwner).update({
      'my_videos': FieldValue.arrayUnion([video.toMap()])
    });
    return Stream.fromFuture(future);
  }

  Stream<DocumentSnapshot> getImagesByUserId(String userId) {
    print('userid $userId');
    return Stream.fromFuture(
        _firestore.collection("images").doc(userId).get());
  }

  Stream<DocumentSnapshot> getVideos(String userId) {
    return Stream.fromFuture(
        _firestore.collection("videos").doc(userId).get());
  }
}
