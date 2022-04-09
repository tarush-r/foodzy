import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uuid/uuid.dart';

class FoodScannerProvider with ChangeNotifier {
  ImagePicker picker = ImagePicker();
  File _imageFile;
  String downloadUrl;

  Future pickImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.camera);

    _imageFile = File(pickedFile.path);
    await uploadPic();
    notifyListeners();
  }

  // Future uploadImageToFirebase(BuildContext context) async {
  //   Reference firebaseStorageRef =
  //       FirebaseStorage.instance.ref().child('uploads/${Uuid().v4()}');
  //   UploadTask uploadTask = firebaseStorageRef.putFile(_imageFile);
  //   TaskSnapshot taskSnapshot = await uploadTask.whenComplete((taskSnapshot) {
  //     taskSnapshot.ref.getDownloadURL().then(
  //           (value) => print("Done: $value"),
  //         );
  //   });
  // }

  Future<void> uploadPic() async {

    final Reference storageReference =
        FirebaseStorage.instance.ref().child("images/${Uuid().v4()}");
    String _downloadURL;

    UploadTask uploadTask = storageReference.putFile(_imageFile);

    _downloadURL = await (await uploadTask).ref.getDownloadURL();
    downloadUrl = _downloadURL;
    // return _downloadURL;
   }
}
