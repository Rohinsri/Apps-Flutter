import 'package:flutter/material.dart';
import 'package:sixth/dummydata.dart';
import 'package:sixth/models/meals.dart';
import 'package:sixth/screens/MealCategory.dart';
import 'package:sixth/screens/RecipeScreen.dart';
import 'package:sixth/screens/filter_screen.dart';
import 'package:sixth/screens/tabs_screen.dart';
void main() =>runApp(MyApp());
class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}
class _MyAppState extends State<MyApp> {
  Map<String,bool> _filter={
    'gluten':false,
    'lactose':false,
    'vegan':false,
    'veg':false,
  };
  List<Meal> _favourites=[];
  List<Meal> _availableMeals=DUMMY_MEALS;
  void _setFilter(Map<String,bool> filterData){
    setState(() {
      _filter=filterData;
      _availableMeals=DUMMY_MEALS.where((x){
        if(_filter['gluten']&&!x.isGlutenFree){
          return false;
        }
        if(_filter['lactose']&&!x.isLactoseFree){
          return false;
        }
        if(_filter['vegan']&&!x.isVegan){
          return false;
        }
        if(_filter['veg']&&!x.isVegetarian){
          return false;
        }
          return true;
      }).toList();
    });
  }
  void addFavourite(Meal meal){
    setState(() {
      if(!_favourites.contains(meal)){
        _favourites.add(meal);
      }
    });
  }
  bool isFavourite(Meal meal){
    if(!_favourites.contains(meal)){
      return false;
    }
    return true;
  }
  void removeFavourite(Meal meal){
    setState(() {
      if(_favourites.contains(meal)){
        _favourites.remove(meal);
      }
    });
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.teal,
        accentColor: Colors.tealAccent,
        fontFamily: 'Raleway',
      ),
      initialRoute: '/',
      routes: {
        '/': (ctx) => TabScreen(_favourites),
        '/MealCategory': (ctx) => MealCategory(_availableMeals),
        '/Recipe':(ctx)=>RecipeScreen(addFavourite: addFavourite,isFavourite: isFavourite,removeFavourite: removeFavourite,),
        '/Filter': (ctx) => FilterScreen(currentFilters:_filter,setfilter: _setFilter),
      },
    );
  }
}

