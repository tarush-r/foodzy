import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:kjsce_hack_2022/screens/recipe_detail_screen.dart';
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
  final String apiKey = "52b9a1ca78ac4edd9bc3721fba500496";
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
      recipes
          .add(RandomRecipeResultModel.fromMap(jsonDecode(response.body)[i]));
    }
    return recipes;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () async {
          recipeList = await getRecipeFromIngredients(ingredientsList);
          setState(() {});
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
                  border: OutlineInputBorder(),
                  hintText: "Enter ingredients",
                  suffixIcon: IconButton(
                    icon: Icon(Icons.send),
                    onPressed: () {
                      setState(() {
                        if (controller.text.length > 0) {
                          ingredientsList.add(controller.text);
                          controller.clear();
                          print(ingredientsList);
                        } else {
                          ScaffoldMessenger.of(context)
                              .showSnackBar(const SnackBar(
                            content: Text("Text is empty"),
                          ));
                        }
                      });
                    },
                  )),
            ),
            Padding(
              padding: const EdgeInsets.all(2.0),
              child: Wrap(
                children: [
                  for (String item in ingredientsList)
                    Chip(
                      label: Text(
                        item,
                        style: TextStyle(
                            fontStyle: FontStyle.italic, color: Colors.white),
                      ),
                      //elevation: 20,
                      padding: EdgeInsets.all(8),
                      backgroundColor: Colors.deepOrangeAccent,
                      deleteIcon: Icon(
                        Icons.clear,
                        size: 15.0,
                      ),
                      onDeleted: () {
                        setState(() {
                          ingredientsList.remove(item);
                        });
                      },
                    ),
                ],
              ),
            ),
            Expanded(
              child: ListView.builder(
                shrinkWrap: true,
                scrollDirection: Axis.vertical,
                itemCount: recipeList.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  RecipeDetailScreen(recipeList[index].id)));
                    },
                    child: Container(
                      margin: EdgeInsets.all(5),
                      height: 150,
                      width: double.maxFinite,
                      child: Card(
                          elevation: 0.0,
                          color: Colors.white,
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  child: Column(
                                    children: [
                                      Text(
                                        recipeList[index].title,
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 17),
                                      ),
                                      /*Text("Missing Ingredients: ${recipeList[index].missedIngredients}",
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
                                    ),*/
                                    ],
                                  ),
                                ),
                                Container(
                                  width: 150,
                                  //margin: EdgeInsets.all(10),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(20),
                                    child: Image(
                                      image: NetworkImage(
                                          recipeList[index].imageUrl),
                                    ),
                                  ),
                                ),
                                /*CircleAvatar(
                                backgroundImage: NetworkImage(recipeList[index].imageUrl),
                                radius: 50,
                              ), */
                              ],
                            ),
                          )),
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
