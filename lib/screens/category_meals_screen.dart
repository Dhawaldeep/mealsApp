import 'package:flutter/material.dart';

import '../models/meal.dart';
import '../widgets/meal_item.dart';

import '../category_data.dart';

class CategoryMealsScreen extends StatefulWidget {
  // final String id;
  // final String title;

  // CategoryMealsScreen(this.id, this.title);

  static const routeName = '/category-meals';

  final List<Meal> availableMeals;

  CategoryMealsScreen(this.availableMeals);

  @override
  _CategoryMealsScreenState createState() => _CategoryMealsScreenState();
}

class _CategoryMealsScreenState extends State<CategoryMealsScreen> {
  String _categoryTitle;
  List<Meal> _categoryMeals;
  var _isInitialized = false;

  // _removeMeal(String mealId){
  //   setState(() {
  //     _categoryMeals.removeWhere((meal) => meal.id == mealId);
  //   });
  // }

  @override
  void didChangeDependencies() {
    if(!_isInitialized){
      final routeArgs =
          ModalRoute.of(context).settings.arguments as Map<String, String>;
      _categoryTitle = routeArgs['title'];
      final categoryId = routeArgs['id'];
      _categoryMeals = DUMMY_MEALS.where((meal) {
        return meal.categories.contains(categoryId);
      }).toList();
      _isInitialized = true;
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_categoryTitle),
      ),
      body: ListView.builder(
        itemBuilder: (ctx, index) {
          return MealItem(
            id: _categoryMeals[index].id,
            title: _categoryMeals[index].title,
            imgURL: _categoryMeals[index].imageUrl,
            duration: _categoryMeals[index].duration,
            affordability: _categoryMeals[index].affordability,
            complexity: _categoryMeals[index].complexity,
            // removeItem: _removeMeal,
          );
        },
        itemCount: _categoryMeals.length,
      ),
    );
  }
}
