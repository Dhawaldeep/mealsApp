import 'package:flutter/material.dart';


import './category_data.dart';
import './models/meal.dart';

import './screens/filters_screen.dart';
import './screens/tabs_screen.dart';
import './screens/meal_detail_screen.dart';
import './screens/category_meals_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  List<Meal> _availableMeals = [];
  List<Meal> _favoriteMeals = [];
  Map<String, bool> _filterData = {
    'gluten': false,
    'lactose': false,
    'vegetarian': false,
    'vegan': false,
  };

  @override
  void initState() {
    setState(() {
      _availableMeals = DUMMY_MEALS;
    });
    super.initState();
  }

  _filterMeals(Map<String, bool> filterData){
    setState(() {
      _filterData = filterData;
      _availableMeals = DUMMY_MEALS.where((meal){
        if(filterData['gluten'] && !meal.isGlutenFree){
          return false;
        }
        if(filterData['lactose'] && !meal.isLactoseFree){
          return false;
        }
        if(filterData['vegetarian'] && !meal.isVegetarian){
          return false;
        }
        if(filterData['vegan'] && !meal.isVegan){
          return false;
        }
        return true;
      }).toList();
    });
  }

  _toggleFavorite(String id){
    int index = _favoriteMeals.indexWhere((meal) => meal.id == id);
    setState(() {
      if(index>-1){
        _favoriteMeals.removeAt(index);
      }else{
        _favoriteMeals.add(
          _availableMeals.singleWhere((meal) => meal.id == id)
        );
      }
    });
  }
  
  _isFavorite(String id){
    return _favoriteMeals.any((meal) => meal.id == id);
  }


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'DeliMeals',
        theme: ThemeData(
          primarySwatch: Colors.pink,
          accentColor: Colors.amber,
          canvasColor: Color.fromRGBO(255, 254, 229, 1),
          fontFamily: 'Raleway',
          textTheme: ThemeData.light().textTheme.copyWith(
              bodyText1: TextStyle(
                color: Color.fromRGBO(20, 51, 51, 1),
              ),
              bodyText2: TextStyle(
                color: Color.fromRGBO(20, 51, 51, 1),
              ),
              headline6: TextStyle(
                  fontSize: 20,
                  fontFamily: 'RobotoCondensed',
                  fontWeight: FontWeight.bold)),
        ),
        initialRoute: '/',
        routes: {
          '/': (ctx) => TabsScreen(_favoriteMeals),
          CategoryMealsScreen.routeName: (ctx) => CategoryMealsScreen(_availableMeals),
          MealDetail.routeName: (ctx) => MealDetail(_isFavorite, _toggleFavorite),
          FiltersScreen.routeName: (ctx) => FiltersScreen(_filterData,_filterMeals),
        });
  }
}
