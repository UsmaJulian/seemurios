import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:path_provider/path_provider.dart';
import 'package:seemur/src/utilities/constants.dart';
import 'package:uuid/uuid.dart';

class StorageService {

  static Future<String> uploadUserProfileImage(String _url,
      File imageFile) async {
    print(_url);
    String photoId = Uuid().v4();
    File image = await compressImage(photoId, imageFile);

    /*if (_url.isNotEmpty) {
      print(_url);
      // Updating user profile image
      RegExp exp = RegExp(r'^userProfile_(.*).jpg');
      photoId = exp.firstMatch(_url)[1];
    }*/

    StorageUploadTask uploadTask = storageRef
        .child('images/users/userProfile_$photoId.jpg')
        .putFile(image);
    StorageTaskSnapshot storageSnap = await uploadTask.onComplete;
    String downloadUrl = await storageSnap.ref.getDownloadURL();
    return downloadUrl;
  }

  static Future<File> compressImage(String photoId, File image) async {
    final tempDir = await getTemporaryDirectory();
    final path = tempDir.path;
    File compressedImageFile = await FlutterImageCompress.compressAndGetFile(
      image.absolute.path,
      '$path/img_$photoId.jpg',
      quality: 70,
    );
    return compressedImageFile;
  }


}
