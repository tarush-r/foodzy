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
                          child: GridView.builder(
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                childAspectRatio: 2,
                              ),
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
                                    padding: const EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(10),
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.grey.withOpacity(0.5),
                                            blurRadius: 5.0,
                                          ),
                                        ]),
                                    child: Row(
                                      children: [
                                        Container(
                                          height: double.infinity,
                                          width: 70,
                                          margin: const EdgeInsets.only(right: 5),
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(10),
                                            gradient: LinearGradient(
                                              begin: Alignment.topRight,
                                              end: Alignment.bottomLeft,
                                              colors: [
                                                Colors.blue,
                                                Colors.red,
                                              ],
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          child: Text(
                                            foodScannerProvider
                                                    .extractedRecipes[index]
                                                ['title'],
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                );
                              })
                          // ListView.builder(
                          //   shrinkWrap: true,
                          //   itemCount:
                          //       foodScannerProvider.extractedRecipes.length,
                          //   itemBuilder: (context, index) {
                          //     return GestureDetector(
                          //       onTap: () {
                          //         Navigator.push(
                          //             context,
                          //             MaterialPageRoute(
                          //                 builder: (context) =>
                          //                     RecipeDetailScreen(
                          //                         foodScannerProvider
                          //                                 .extractedRecipes[
                          //                             index]['id'])));
                          //       },
                          //       child: Container(
                          //         margin: const EdgeInsets.all(5),
                          //         padding: const EdgeInsets.all(5),
                          //         child: Row(
                          //           children: [
                          //             Expanded(
                          //               child: Text(
                          //                 foodScannerProvider
                          //                     .extractedRecipes[index]['title'],
                          //                 overflow: TextOverflow.ellipsis,
                          //               ),
                          //             )
                          //           ],
                          //         ),
                          //       ),
                          //     );
                          //   },
                          // ),
                          ),
            ],
          ),
        ),
      );
    });
  }
}
