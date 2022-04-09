import 'dart:convert';
import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:kjsce_hack_2022/screens/detect_recipe_screen.dart';
import 'package:uuid/uuid.dart';
import 'package:http/http.dart' as http;

class FoodScannerProvider with ChangeNotifier {
  ImagePicker picker = ImagePicker();
  File _imageFile;
  String downloadUrl;

  List extractedRecipes = [];
  bool extractingRecipe = false;
  bool recipeAlreadyExtracted = false;

  Future pickImage(ImageSource imageSource, BuildContext context) async {
    _imageFile = null;
    downloadUrl = null;
    recipeAlreadyExtracted = false;
    final pickedFile = await picker.getImage(source: imageSource);
    if (pickedFile == null) {
      return;
    }
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => DetectRecipeScreen()),
    );
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
        FirebaseStorage.instance.ref().child("${Uuid().v4()}");
    String _downloadURL;

    UploadTask uploadTask = storageReference.putFile(_imageFile);

    _downloadURL = await (await uploadTask).ref.getDownloadURL();
    downloadUrl = _downloadURL;
    // return _downloadURL;
  }

  extractRecipe(String imageUrl) async {
    extractedRecipes = [];
    extractingRecipe = true;
    notifyListeners();
    print(imageUrl);
    // imageUrl =
    //     'https://firebasestorage.googleapis.com/v0/b/kjsce-hack-2022.appspot.com/o/cake_photo.jpg?alt=media&token=1507366c-98b2-447b-b05b-73eb8f1c2bc2';
    String apiEndPoint =
        'https://api.spoonacular.com/food/images/analyze?imageUrl=$imageUrl&apiKey=d815a43f7a2644dd890a44d5f835d21d';

    var response = await http.get(Uri.parse(apiEndPoint));
    var decodedResponse = json.decode(response.body);
    print(decodedResponse['recipes']);
    for(int i = 0;i< decodedResponse['recipes'].length;i++){
      extractedRecipes.add(decodedResponse['recipes'][i]);
    }
    extractingRecipe = false;
    recipeAlreadyExtracted = true;
    notifyListeners();
  }
}
