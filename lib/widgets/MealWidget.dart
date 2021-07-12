import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../models/meals.dart';
class MealWidget extends StatelessWidget {
  final String id;
  final String url;
  final String title;
  final Complexity complexity;
  final Affordability affordability;
  final bool veg;
  final Function removeMeal;
  String get comp{
    if(complexity==Complexity.Simple){
      return 'Simple';
    }
    else if(complexity==Complexity.Challenging){
      return 'Challenging';
    }
    else{
      return 'Hard';
    }
  }
  String get afford{
    if(affordability==Affordability.Affordable){
      return 'Affordable';
    }
    else if(affordability==Affordability.Pricey){
      return 'Costly';
    }
    else{
      return 'Luxurious';
    }
  }
  MealWidget({this.id,this.url,this.title,this.complexity,this.affordability,this.veg, this.removeMeal});
  void selectRecipe(BuildContext ctx){
    Navigator.pushNamed(ctx,'/Recipe',arguments: {
      'id':id,
    }).then((ids){
      removeMeal(ids);
    });
  }
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: ()=>selectRecipe(context),
      child:Padding(
        padding: const EdgeInsets.fromLTRB(8.0,4.0,8.0,4.0),
        child: Card(
          elevation: 30,
          shape:RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
          child:Column(
            children: <Widget>[
              Stack(
                children: <Widget>[
                  ClipRRect(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30),
                    ),
                    child: Image(
                      height: 250,
                        width: double.infinity,
                        image:NetworkImage(url),
                      fit: BoxFit.cover,
                    ),
                  ),
                  Positioned(
                    bottom: 20,
                    right: 10,
                    child: Container(
                      width: 220,

                      color: Colors.black54,
                      padding: const EdgeInsets.all(17),
                      child: Text(
                        title,
                        softWrap: true,
                        overflow: TextOverflow.fade,
                        style: TextStyle(
                          fontSize: 22,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              ClipRRect(
                borderRadius: BorderRadius.only(
                  bottomRight: Radius.circular(30),
                  bottomLeft: Radius.circular(30),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 12,
                    horizontal: 8,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Icon(
                            Icons.schedule
                          ),
                          SizedBox(width:5),
                          Text(comp)
                        ],
                      ),
                      Row(
                        children: <Widget>[
                          CircleAvatar(
                            backgroundColor: (veg)?Colors.green:Colors.red,
                            radius: 8,
                          ),
                          SizedBox(width:7),
                          Text((veg)?'Veg':'Non-Veg'),
                        ],
                      ),
                      Row(
                        children: <Widget>[
                          Icon(
                            Icons.attach_money,
                          ),
                          SizedBox(width:3),
                          Text(afford),
                        ],
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      )
    );
  }
}
