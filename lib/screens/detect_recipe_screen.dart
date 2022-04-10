import 'package:flutter/material.dart';
import 'package:kjsce_hack_2022/providers/food_scanner_provider.dart';
import 'package:kjsce_hack_2022/screens/recipe_detail_screen.dart';
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
      return SafeArea(
        child: Scaffold(
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerFloat,
          floatingActionButton: FloatingActionButton.extended(
            backgroundColor: Colors.deepPurple,
              onPressed: () {
                if (foodScannerProvider.downloadUrl != null) {
                  foodScannerProvider
                      .extractRecipe(foodScannerProvider.downloadUrl);
                }
              },
              label: Text('Extract Recipe')),
          body: Column(
            children: [
              foodScannerProvider.downloadUrl != null
                  ? Container(
                      width: double.infinity,
                      height: 300,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                            fit: BoxFit.cover,
                            image:
                                NetworkImage(foodScannerProvider.downloadUrl)),
                      ),
                    )
                  : Center(child: CircularProgressIndicator()),
              foodScannerProvider.extractingRecipe == true
                  ? Container(
                      child: CircularProgressIndicator(),
                    )
                  : !foodScannerProvider.recipeAlreadyExtracted
                      ? Container()
                      : Expanded(
                          child: ListView.builder(
                            shrinkWrap: true,
                            itemCount:
                                foodScannerProvider.extractedRecipes.length,
                            itemBuilder: (context, index) {
                              return GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              RecipeDetailScreen(
                                                  foodScannerProvider
                                                          .extractedRecipes[
                                                      index]['id'])));
                                },
                                child: Container(
                                  margin: const EdgeInsets.all(5),
                                  padding: const EdgeInsets.all(5),
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: Text(
                                          foodScannerProvider
                                              .extractedRecipes[index]['title'],
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
            ],
          ),
        ),
      );
    });
  }
}
