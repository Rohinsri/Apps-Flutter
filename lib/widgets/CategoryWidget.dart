import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sixth/screens/MealCategory.dart';
class CategoryWidget extends StatelessWidget {
  final String id;
  final String title;
  final Color color;
  CategoryWidget(this.id,this.title,this.color);
  void selectCategory(BuildContext ctx){
    Navigator.pushNamed(ctx,'/MealCategory',arguments: {
      'id':id,
      'title':title,
    });
  }
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: ()=>selectCategory(context),
      splashColor: Colors.black,
      borderRadius: BorderRadius.circular(20.0),
      child: Card(
        elevation: 20,
        shadowColor: Colors.black,
        shape:RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
        child: Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            gradient:  LinearGradient(
              colors: [
                color.withOpacity(0.7),
                color,
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            )
          ),
          child: Text(
                title,
              style: TextStyle(
                fontSize: 23.0,
                color: Colors.white,
                fontFamily: 'Raleway',
              ),
            ),
        ),
      ),
    );
  }
}
