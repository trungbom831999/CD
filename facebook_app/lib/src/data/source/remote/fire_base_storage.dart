import 'dart:io';
import 'dart:math';
import 'package:firebase_storage/firebase_storage.dart';

class FirUploadPhoto {
  final FirebaseStorage _firebaseStorage;

  FirUploadPhoto(this._firebaseStorage);

  Future<void> uploadFile(String filePath, Function(String urlPath) onSuccess,
      Function onError, Function(double progress) onProgress) async {
    File file = File(filePath);
    print(file);
    Reference storageReference =
        _firebaseStorage.ref('images/${Random.secure().nextDouble()}.jpg');
    try {
      UploadTask uploadTask = storageReference.putFile(file);
      uploadTask.snapshotEvents.listen((event) {
        print('progress ${event.bytesTransferred.toDouble()}');
        onProgress(
            event.bytesTransferred.toDouble() / event.totalBytes.toDouble());
      });
      uploadTask.whenComplete(() => {
            storageReference.getDownloadURL().then((fileURL) {
              onSuccess(fileURL);
            })
          });
    } on FirebaseException catch (e) {
      onError();
    }
  }

  uploadVideo(String filePath, Function(String urlPath) onSuccess,
      Function onError, Function(double progress) onProgress) {
    File file = File(filePath);
    Reference storageReference =
        _firebaseStorage.ref('videos/${Random.secure().nextDouble()}.mp4');
    try {
      UploadTask uploadTask = storageReference.putFile(file);
      uploadTask.snapshotEvents.listen((event) {
        onProgress(
            event.bytesTransferred.toDouble() / event.totalBytes.toDouble());
      });
      uploadTask.whenComplete(() => {
            storageReference.getDownloadURL().then((fileURL) {
              onSuccess(fileURL);
            })
          });
    } on FirebaseException catch (e) {
      onError();
    }
  }
}
