import 'package:flutter/material.dart';

import '../models/meal.dart';
import '../widgets/meal_item.dart';

class FavoritesScreen extends StatelessWidget {
  final List<Meal> meals;

  FavoritesScreen(this.meals);

  @override
  Widget build(BuildContext context) {
    if(meals.isEmpty){
      return Center(
        child: Text('You have not selected any favorite meals yet!'),
      );
    }else{
      return Container(
        child: ListView.builder(
          itemBuilder: (ctx, index) {
            return MealItem(
              id: meals[index].id,
              title: meals[index].title,
              imgURL: meals[index].imageUrl,
              duration: meals[index].duration,
              affordability: meals[index].affordability,
              complexity: meals[index].complexity,
            );
          },
          itemCount: meals.length,
        ),
      );
    }
  }
}