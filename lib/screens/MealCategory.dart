import 'package:flutter/material.dart';
import 'package:sixth/dummydata.dart';
import 'package:sixth/models/meals.dart';
import 'package:sixth/widgets/MealWidget.dart';
class MealCategory extends StatefulWidget {
  List<Meal> _availableMeals;
  MealCategory(this._availableMeals);
  @override
  _MealCategoryState createState() => _MealCategoryState();
}

class _MealCategoryState extends State<MealCategory> {
  String title;
  String id;
  List<Meal> mealcategory;
  bool _loaded=false;
  @override
  void initState() {
    super.initState();
  }
  @override
  void didChangeDependencies() {
    if(!_loaded){
      final data=ModalRoute.of(context).settings.arguments as Map<String,String>;
      title=data['title'];
      final id=data['id'];
      mealcategory=widget._availableMeals.where((element){
        return element.categories.contains(id);
      }).toList();
    }
    super.didChangeDependencies();
  }
  void _removeMeal(String mid){
    setState(() {
      mealcategory.removeWhere((element) => element.id==mid);
    });
  }
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        elevation: 20,
      ),
      body:ListView.builder(
          itemCount: mealcategory.length,
          itemBuilder: (ctx,index){
        return MealWidget(
          id: mealcategory[index].id,
          url:mealcategory[index].imageUrl,
          title:mealcategory[index].title,
          affordability: mealcategory[index].affordability,
          complexity: mealcategory[index].complexity,
          veg: mealcategory[index].isVegetarian,
          removeMeal: _removeMeal,
        );
      }
      )
    );
  }
}
