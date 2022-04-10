import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:kjsce_hack_2022/providers/food_scanner_provider.dart';
import 'package:kjsce_hack_2022/screens/detect_recipe_screen.dart';
import 'package:provider/provider.dart';

class FoodScannerScreen extends StatefulWidget {
  @override
  State<FoodScannerScreen> createState() => _FoodScannerScreenState();
}

class _FoodScannerScreenState extends State<FoodScannerScreen> {
  @override
  Widget build(BuildContext context) {
    return Consumer<FoodScannerProvider>(
        builder: (ctx, foodScannerProvider, child) {
      return Scaffold(
        floatingActionButton: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            FloatingActionButton.extended(
              heroTag: 'btn1',
              onPressed: () {
                foodScannerProvider.pickImage(ImageSource.camera, context);
              },
              backgroundColor: Colors.deepPurple,
              label: Text('Camera'),
              icon: Icon(Icons.camera_alt),
            ),
            FloatingActionButton.extended(
              heroTag: 'btn2',
              backgroundColor: Colors.deepPurple,
              onPressed: () {
                foodScannerProvider.pickImage(ImageSource.gallery, context);
              },
              label: Text('Gallery'),
              icon: Icon(Icons.photo_album),
            ),
          ],
        ),
      );
    });
  }
}
