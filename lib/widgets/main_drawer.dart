import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
class MainDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child:Column(
        children: <Widget>[
          Container(
            width:double.infinity,
            color: Colors.amber,
            height: 130,
            child:Center(
                child: Text('The Hot Potato!',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 35,
                    fontWeight: FontWeight.bold,
                  ),
                )),
          ),
          FlatButton(onPressed: (){
            Navigator.of(context).pushReplacementNamed('/');
          },
            splashColor: Colors.teal[100],
              minWidth: double.infinity,
              height: 60,
              child: Row(
                children: <Widget>[
                  Icon(
                    Icons.fastfood,
                    size: 30,
                    color: Colors.teal,
                  ),
                  SizedBox(width: 20,),
                  Text('Home',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 25,
                    ),
                  ),
                ],
              ),
          ),
          FlatButton(onPressed: (){
            Navigator.of(context).pushReplacementNamed('/Filter');
          },
            splashColor: Colors.teal[100],
            minWidth: double.infinity,
            height: 60,
            child: Row(
              children: <Widget>[
                Icon(
                  Icons.filter_list_alt,
                  size: 30,
                  color: Colors.teal,
                ),
                SizedBox(width: 20,),
                Text('Filter',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 25,
                  ),
                ),
              ],
            ),
          ),
        ],
      )
    );
  }
}
