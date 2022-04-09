import 'package:flutter/material.dart';
import 'package:kjsce_hack_2022/providers/food_scanner_screen.dart';
import 'package:provider/provider.dart';

class DetectRecipeScreen extends StatefulWidget {
  @override
  State<DetectRecipeScreen> createState() => _DetectRecipeScreenState();
}

class _DetectRecipeScreenState extends State<DetectRecipeScreen> {
  @override
  Widget build(BuildContext context) {
    return Consumer<FoodScannerProvider>(
        builder: (ctx, foodScannerProvider, child) {
      return Scaffold(
        body: Column(
          children: [
            foodScannerProvider.downloadUrl == null
                ? Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                          image: NetworkImage(foodScannerProvider.downloadUrl)),
                    ),
                  )
                : Center(child: CircularProgressIndicator()),
          ],
        ),
      );
    });
  }
}
