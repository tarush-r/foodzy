import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:kjsce_hack_2022/widgets/textfields.dart';
import 'package:http/http.dart' as http;
import 'package:kjsce_hack_2022/models/ingredientRecipe.dart';

class GetIngredients extends StatefulWidget {
  @override
  _GetIngredientsState createState() => _GetIngredientsState();
}

class _GetIngredientsState extends State<GetIngredients> {
  List<String> ingredientsList = [];
  final controller = TextEditingController();
  final String apiKey = "21725763e0f44f30a833ef19fd9a0a2e";
  final String apiURL = "https://api.spoonacular.com/recipes/findByIngredients";
  List<RandomRecipeResultModel> recipeList = [];
  bool pressed = false;

  Future<List<RandomRecipeResultModel>> getRecipeFromIngredients(
      List<String> ingredients) async {
    String ingredientsString = "";
    for (int i = 0; i < ingredients.length; i++) {
      ingredientsString += ',' + ingredients[i];
    }
    List<RandomRecipeResultModel> recipes = [];
    final response = await http.get(Uri.parse(
        apiURL + "?apiKey=" + apiKey + "&ingredients=" + ingredientsString));
    for (int i = 0; i < jsonDecode(response.body).length; i++) {
      recipes.add(
          RandomRecipeResultModel.fromMap(jsonDecode(response.body)[i]));
    }
    return recipes;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () async {
          recipeList = await getRecipeFromIngredients(ingredientsList);
          setState(() {

          });
          print(recipeList[0].title);
        },
        backgroundColor: Colors.deepPurple,
        label: Text('Get Recipes'),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 60.0),
        child: Column(
          children: [
            TextField(
              controller: controller,
              decoration: InputDecoration(
                  hintText: "Enter ingredients",
                  suffixIcon: IconButton(
                    icon: Icon(Icons.send),
                    onPressed: () {
                      setState(() {
                        if (controller.text.length > 0) {
                          ingredientsList.add(controller.text);
                          controller.clear();
                          print(ingredientsList);
                        }
                        else {
                          ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text("Text is empty"),
                              ));
                        }
                      });
                    },
                  )
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(2.0),
              child: Wrap(
                children: [
                  for( String item in ingredientsList) Chip(
                    label: Text(item),
                    deleteIcon: Icon(Icons.clear),
                    onDeleted: () {
                      setState(() {
                        ingredientsList.remove(item);
                      });
                    },
                  ),
                ],
              ),
            ),
            Container(
              height: MediaQuery
                  .of(context)
                  .size
                  .height * 0.68,
              child: ListView.builder(
                shrinkWrap: true,
                scrollDirection: Axis.vertical,
                itemCount: recipeList.length,
                itemBuilder: (context, index) {
                  return Container(
                    padding: EdgeInsets.all(5),
                    height: 150,
                    width: double.maxFinite,
                    child: Card(
                      elevation: 2.0,
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CircleAvatar(
                            backgroundImage: NetworkImage(recipeList[index].imageUrl),
                              radius: 50,
                            ),
                            Expanded(
                              child: Column(
                                children: [
                                    Text(recipeList[index].title,
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 17
                                      ),
                                    ),
                                  Text("Missing Ingredients: ${recipeList[index].missedIngredients}",
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                          fontWeight: FontWeight.w300,
                                          fontSize: 13
                                      ),
                                    ),
                                  Text("Unused Ingredients: ${recipeList[index].unusedIngredients}",
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                        fontWeight: FontWeight.w300,
                                        fontSize: 13
                                    ),
                                  ),
                                ],
                              ),
                            ),

                          ],
                        ),
                      )
                    ),
                  );
                },
              ),
            ),

          ],
        ),

      ),
    );
  }
}