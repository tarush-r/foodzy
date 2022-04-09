class RandomRecipeResultModel {
  int id;
  String title;
  String imageUrl;
  String description;
  bool isVegetarian;
  int cookingTime;
  List ingredients;
  int missedIngredients;
  int unusedIngredients;

  RandomRecipeResultModel({
    this.id,
    this.title,
    this.imageUrl,
    this.description,
    this.isVegetarian,
    this.cookingTime,
    this.ingredients,
    this.missedIngredients,
    this.unusedIngredients,
  });

  factory RandomRecipeResultModel.fromMap(Map doc) {
    return RandomRecipeResultModel(
      id: doc['id'],
      title: doc['title'],
      description: doc['summary'],
      imageUrl: doc['image'],
      isVegetarian: doc['vegetarian'],
      cookingTime: doc['readyInMinutes'],
      ingredients: doc['extended_ingredients'],
      missedIngredients: doc['missedIngredientCount'],
      unusedIngredients: doc['usedIngredientCount'],
    );
  }
}