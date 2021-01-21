import 'package:flutter/material.dart';
import '../category_data.dart';

class MealDetail extends StatelessWidget {
  static const routeName = '/meal-detail';
  final Function isFavorite;
  final Function toggleFavorite;

  MealDetail(this.isFavorite,this.toggleFavorite);

  Widget buildSectionTitle(BuildContext ctx, text) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: Text(
        text,
        style: Theme.of(ctx).textTheme.headline6,
      ),
    );
  }

  Widget buildContainer(Widget listBuilder) {
    return Container(
      height: 150,
      width: 300,
      margin: EdgeInsets.all(10),
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.white,
        border: Border.all(color: Colors.grey),
      ),
      child: listBuilder,
    );
  }

  @override
  Widget build(BuildContext context) {
    final mealId = ModalRoute.of(context).settings.arguments as String;
    final selectedMeal = DUMMY_MEALS.firstWhere((meal) {
      return meal.id == mealId;
    });
    return Scaffold(
        appBar: AppBar(
          title: Text(selectedMeal.title),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                child: Image.network(
                  selectedMeal.imageUrl,
                  height: 300,
                  width: double.infinity,
                ),
              ),
              buildSectionTitle(context, 'Ingredients'),
              buildContainer(
                ListView.builder(
                  itemBuilder: (ctx, index) {
                    return Card(
                      color: Theme.of(context).accentColor,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: 5,
                          horizontal: 10,
                        ),
                        child: Text(selectedMeal.ingredients[index]),
                      ),
                    );
                  },
                  itemCount: selectedMeal.ingredients.length - 1,
                ),
              ),
              buildSectionTitle(context, 'Steps'),
              buildContainer(
                ListView.builder(
                  itemBuilder: (ctx, index) {
                    return Column(
                      children: [
                        ListTile(
                          leading: CircleAvatar(
                            child: Text(
                              '#${index + 1}',
                            ),
                          ),
                          title: Text(selectedMeal.steps[index]),
                        ),
                        Divider()
                      ],
                    );
                  },
                  itemCount: selectedMeal.steps.length - 1,
                ),
              ),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          // child: Icon(Icons.delete),
          child: Icon(
            isFavorite(mealId)? Icons.star: Icons.star_border,
          ),
          onPressed: () {
            // Navigator.of(context).pop(mealId);
            toggleFavorite(mealId);
          },
        ));
  }
}
