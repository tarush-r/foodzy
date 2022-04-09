import 'package:flutter/material.dart';
import 'package:kjsce_hack_2022/screens/detect_recipe_screen.dart';

class FoodScannerScreen extends StatefulWidget {
  @override
  State<FoodScannerScreen> createState() => _FoodScannerScreenState();
}

class _FoodScannerScreenState extends State<FoodScannerScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          FloatingActionButton.extended(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => DetectRecipeScreen()),
              );
            },
            label: Text('Camera'),
            icon: Icon(Icons.camera_alt),
          ),
          FloatingActionButton.extended(
            onPressed: () {},
            label: Text('Gallery'),
            icon: Icon(Icons.photo_album),
          ),
        ],
      ),
    );
  }
}
