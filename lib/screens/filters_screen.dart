import 'package:flutter/material.dart';
import '../widgets/main_drawer.dart';

class FiltersScreen extends StatefulWidget {
  static const routeName = '/filters';

  final Map<String, bool> filterData;
  final Function saveFilters;

  FiltersScreen(this.filterData,this.saveFilters);

  @override
  _FiltersScreenState createState() => _FiltersScreenState();
}

class _FiltersScreenState extends State<FiltersScreen> {
  bool _glutenFree = false;
  bool _isVegan = false;
  bool _isVegetarian = false;
  bool _isLactoseFree = false;

  @override
  initState(){
    _glutenFree = widget.filterData['gluten'];
    _isVegan = widget.filterData['vegan'];
    _isVegetarian = widget.filterData['vegetarian'];
    _isLactoseFree = widget.filterData['lactose'];
    super.initState();
  }

  _buildSwitch(
      String title, String desc, bool currentValue, Function updateValue) {
    return SwitchListTile(
      title: Text(title),
      subtitle: Text(desc),
      value: currentValue,
      onChanged: updateValue,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Filters'),
        actions: [
          IconButton(icon: Icon(Icons.save), onPressed: () =>widget.saveFilters({
            'gluten': _glutenFree,
            'vegan': _isVegan,
            'vegetarian': _isVegetarian,
            'lactose': _isLactoseFree,
          }))
        ],
      ),
      drawer: MainDrawer(),
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.all(20),
            child: Text(
              'Adjust ypur meal selection',
              style: Theme.of(context).textTheme.headline6,
            ),
          ),
          Expanded(
            child: ListView(
              children: [
                _buildSwitch(
                  'Gluten-free',
                  'Only include gluten free meals',
                  _glutenFree,
                  (val) {
                    setState(
                      () {
                        _glutenFree = val;
                      },
                    );
                  },
                ),
                _buildSwitch(
                  'Is vegan',
                  'Only include vegan meals',
                  _isVegan,
                  (val) {
                    setState(
                      () {
                        _isVegan = val;
                      },
                    );
                  },
                ),
                _buildSwitch(
                  'Is vegetarian',
                  'Only include vegetarian meals',
                  _isVegetarian,
                  (val) {
                    setState(
                      () {
                        _isVegetarian = val;
                      },
                    );
                  },
                ),
                _buildSwitch(
                  'Lactose-free',
                  'Only include lactose free meals',
                  _isLactoseFree,
                  (val) {
                    setState(
                      () {
                        _isLactoseFree = val;
                      },
                    );
                  },
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
