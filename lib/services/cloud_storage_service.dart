import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';

class CloudStorageService {
  static final CloudStorageService instance = CloudStorageService();

  late FirebaseStorage _storage;
  late Reference _baseRef;

  String _profileImages = "profile_images";

  CloudStorageService() {
    _storage = FirebaseStorage.instanceFor(bucket: 'gs://chartify-76d98.appspot.com');
    _baseRef = _storage.ref();
  }

  // Future<TaskSnapshot>? uploadUserImage(String uid, File image) async {
  //   try {
  //     await _baseRef
  //         .child(_profileImages)
  //         .child(uid)
  //         .putFile(image);
  //   } catch (e) {
  //     print(e);
  //   }throw(e){};
  // }

  Future<String?> uploadUserImage(String uid, File imageFile) async {
    try {
      // FirebaseStorage storage = FirebaseStorage.instance;
      // Adjust the reference path as needed
      Reference ref = _storage.ref().child('user_images/$uid/profile.jpg');
      UploadTask uploadTask = ref.putFile(imageFile);
      TaskSnapshot snapshot = await uploadTask;
      String downloadURl = await snapshot.ref.getDownloadURL();
      return downloadURl;
    } catch (e) {
      print("Error uploading image: $e");
      return null;
    }
  }
}
