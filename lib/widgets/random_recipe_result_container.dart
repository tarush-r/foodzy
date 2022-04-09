import 'package:flutter/material.dart';
import 'package:kjsce_hack_2022/models/recipeResultModel.dart';

class RandomRecipeResultContainer extends StatelessWidget {
  RandomRecipeResultModel recipe;

  RandomRecipeResultContainer({this.recipe});

  String removeAllHtmlTags(String htmlText) {
    RegExp exp = RegExp(r"<[^>]*>", multiLine: true, caseSensitive: true);

    return htmlText.replaceAll(exp, '');
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 160,
      margin: const EdgeInsets.all(5),
      padding: const EdgeInsets.all(5),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey,
            blurRadius: 5.0,
          ),
        ],
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        children: [
          //Image container
          Container(
            width: 160,
            height: 150,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
              image: DecorationImage(
                image: NetworkImage(
                    recipe.imageUrl ?? 'http://via.placeholder.com/350x150'),
                fit: BoxFit.cover,
              ),
            ),
          ),

          //Data
          Row(
            children: [
              Expanded(
                flex: 5,
                child: Text(
                  recipe.title,
                  maxLines: 2,
                  // overflow: TextOverflow.ellipsis,
                ),
              ),

              //VEG ICON
              Expanded(
                flex: 1,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        // Icon(
                        //   Icons.crop_square_sharp,
                        //   color: Colors.green,
                        //   size: 14,
                        // ),
                        // Icon(Icons.add),
                        // Icon(Icons.circle, color: Colors.green, size: 14),
                        // Icon(Icons.drag_handle_rounded),
                        Stack(
                          alignment: Alignment.center,
                          children: [
                            Icon(
                              Icons.crop_square_sharp,
                              color: Colors.green,
                              size: 22,
                            ),
                            Icon(Icons.circle, color: Colors.green, size: 12),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          Container(
              child: Row(
            children: [
              Icon(
                Icons.timer,
                color: Colors.red,
              ),
              Text(
                recipe.cookingTime.toString() + ' mins',
                style: TextStyle(color: Colors.black54.withOpacity(0.5)),
              )
            ],
          )),
          Container(
              child: Text(
            removeAllHtmlTags(recipe.description),
            overflow: TextOverflow.ellipsis,
            maxLines: 5,
            style: TextStyle(color: Colors.black54.withOpacity(0.5)),
          ))
        ],
      ),
    );
  }
}
