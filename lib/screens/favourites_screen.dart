import 'package:flutter/material.dart';
import 'package:sixth/models/meals.dart';
import 'package:sixth/widgets/MealWidget.dart';
class Favourites extends StatelessWidget {
  List<Meal> _favourites;
  Favourites(this._favourites);
  @override
  Widget build(BuildContext context) {
    return _favourites.length==0?Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text('No Favourites Till Now!',style: TextStyle(fontSize: 20),),
        SizedBox(height: 30,),
        Center(child: InkWell(
          onTap: (){
            Navigator.pushReplacementNamed(context, '/');
          },
          child: CircleAvatar(
            radius: 30,
            child: Image(
              image: AssetImage('assets/images/favourites.png'),
              height: 100,
              width: 100,
            ),
          ),
        )),
        Text('Click To Choose',style: TextStyle(fontSize: 17),)
      ],
    ):ListView.builder(
        itemCount: _favourites.length,
        itemBuilder: (ctx,index) {
          return MealWidget(
            id: _favourites[index].id,
            url: _favourites[index].imageUrl,
            title: _favourites[index].title,
            affordability: _favourites[index].affordability,
            complexity: _favourites[index].complexity,
            veg: _favourites[index].isVegetarian,
          );
        }
    );
  }
}
