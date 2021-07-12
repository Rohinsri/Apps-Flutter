import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:sixth/dummydata.dart';
class RecipeScreen extends StatefulWidget {
  final Function addFavourite;
  final Function isFavourite;
  final Function removeFavourite;
  RecipeScreen({this.addFavourite,this.isFavourite,this.removeFavourite});
  @override
  _RecipeScreenState createState() => _RecipeScreenState();
}
class _RecipeScreenState extends State<RecipeScreen> {
  @override
  Widget build(BuildContext context) {
    int isFavourite=0;
    final data=ModalRoute.of(context).settings.arguments as Map<String,String>;
    final id=data['id'];
    final dish=DUMMY_MEALS.firstWhere((element) => element.id==id);
    return Scaffold(
      appBar: AppBar(
        title: Text(dish.title),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(8.0,4.0,8.0,4.0),
          child: Card(
            elevation: 30,
            shape:RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
            ),
            child:Column(
              crossAxisAlignment: CrossAxisAlignment.start,
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
                        image:NetworkImage(dish.imageUrl),
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
                          dish.title,
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
                  child:Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Column(
                      children: <Widget>[
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            FlatButton(onPressed: (){
                              setState(() {
                                if(widget.isFavourite(dish)){
                                  widget.removeFavourite(dish);
                                }
                                else{
                                  widget.addFavourite(dish);
                                }
                              });
                                },
                                color: widget.isFavourite(dish)?Colors.white:Theme.of(context).accentColor,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30),),
                                child: Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Image(
                                        image: AssetImage('assets/images/favourites.png'),
                                        height: 40,
                                        width: 40,
                                      ),
                                      SizedBox(width: 20,),
                                      Text(widget.isFavourite(dish)?'Remove From Favourites':'Add To Favourites!',
                                        style: TextStyle(
                                          fontSize: 20,
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                            ),
                            SizedBox(height: 40,),
                            Text('Characterstics:',
                                style:TextStyle(
                                  fontSize: 20,
                                )
                            ),
                            SizedBox(height:13),
                            Row(
                              children: <Widget>[
                                SizedBox(width: 13,),
                                Icon(
                                    Icons.check_box,
                                  size: 15,
                                  color: Colors.grey[600],
                                ),
                                SizedBox(width: 13,),
                                Text((dish.isGlutenFree)?'Gluten Free ':'Contains Gluten',
                                    style:TextStyle(
                                      fontSize: 15,
                                      color: Colors.grey[600],
                                    )
                                ),
                              ],
                            ),
                            SizedBox(height:8),
                            Row(
                              children: <Widget>[
                                SizedBox(width: 13,),
                                Icon(
                                  (dish.isVegan)?Icons.check_box:Icons.check_box_outline_blank_rounded,
                                  size: 15,
                                  color: Colors.grey[600],
                                ),
                                SizedBox(width: 13,),
                                Text('Vegan ',
                                    style:TextStyle(
                                      fontSize: 15,
                                      color: Colors.grey[600],
                                    )
                                ),
                              ],
                            ),
                            SizedBox(height:8),
                            Row(
                              children: <Widget>[
                                SizedBox(width: 13,),
                                CircleAvatar(
                                  backgroundColor: (dish.isVegetarian)?Colors.green:Colors.red,
                                  radius: 7,
                                ),
                                SizedBox(width: 13,),
                                Text((dish.isVegetarian)?'Veg':'Non-Veg',
                                    style:TextStyle(
                                      fontSize: 15,
                                      color: Colors.grey[600],
                                    )
                                ),
                              ],
                            ),
                            SizedBox(height:8),
                            Row(
                              children: <Widget>[
                                SizedBox(width: 13,),
                                Icon(
                                    Icons.schedule,
                                    size:15,
                                    color:Colors.grey[600]
                                ),
                                SizedBox(width: 13,),
                                Text('Takes '+dish.duration.toString()+' mins to cook!',
                                    style:TextStyle(
                                        fontSize: 15,
                                        color:Colors.grey[700]
                                    )
                                ),
                              ],
                            ),
                            SizedBox(height:25),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text('Ingredients:',
                                  style:TextStyle(
                                    fontSize: 20,
                                  )
                                ),
                                SizedBox(height: 13,),
                                Container(
                                  height: (dish.ingredients.length+1)*30.0,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    border: Border.all(
                                      color: Colors.grey[400],
                                    width: 0.5
                                    ),
                                  ),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.all(Radius.circular(20)),
                                    child:ListView.builder(
                                        itemCount:dish.ingredients.length,
                                        itemBuilder: (ctx,index){
                                          return Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.all(10),
                                                child: Text(dish.ingredients[index],
                                                    style:TextStyle(
                                                      color: Colors.grey[700],
                                                      fontSize: 15,
                                                    )
                                                ),
                                              ),
                                              Divider(),
                                            ],
                                          );
                                        }),
                                  )
                                )
                              ],
                            ),
                            SizedBox(height:25),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text('Steps:',
                                    style:TextStyle(
                                      fontSize: 20,
                                    )
                                ),
                                SizedBox(height: 13,),
                                Container(
                                  height: (dish.steps.length+1)*33.0,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    border: Border.all(
                                        color: Colors.grey[400],
                                        width: 0.5
                                    ),
                                  ),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(20)
                                    ),
                                    child: ListView.builder(
                                        itemCount:dish.steps.length,
                                        itemBuilder: (ctx,index){
                                          return Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.all(10),
                                                child: Text(dish.steps[index],
                                                    style:TextStyle(
                                                      color: Colors.grey[700],
                                                      fontSize: 15,
                                                    )
                                                ),
                                              ),
                                              Divider(),
                                            ],
                                          );
                                        }),
                                  ),
                                )
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
