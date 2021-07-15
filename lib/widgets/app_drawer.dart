import 'package:flutter/material.dart';
import 'package:seventh/providers/auth.dart';
import 'package:seventh/screens/order_screen.dart';
import 'package:seventh/screens/user_product.dart';
import 'package:provider/provider.dart';
class AppDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: <Widget>[
          AppBar(
            title: Text('Hello Guys!'),
            automaticallyImplyLeading: false,
          ),
          ListTile(
            leading: Icon(Icons.shop,size: 30,),
            title: Text('Shop',style:TextStyle(fontSize: 20)),
            onTap: (){
              Navigator.pushReplacementNamed(context, '/');
            },
          ),
          Divider(color:Colors.blueGrey,),
          ListTile(
            leading: Icon(Icons.payment,size: 30,),
            title: Text('Orders',style:TextStyle(fontSize: 20)),
            onTap: (){
              Navigator.pushReplacementNamed(context, OrderScreen.routeName);
            },
          ),
          Divider(color:Colors.blueGrey,),
          ListTile(
            leading: Icon(Icons.shopping_bag,size: 30,),
            title: Text('Your Products',style:TextStyle(fontSize: 20)),
            onTap: (){
              Navigator.pushReplacementNamed(context, UserProductScreen.routeName);
            },
          ),
          Divider(color:Colors.blueGrey,),
          ListTile(
            leading: Icon(Icons.logout,size: 30,),
            title: Text('Logout',style:TextStyle(fontSize: 20)),
            onTap: (){
              Navigator.of(context).pop();
              Navigator.pushReplacementNamed(context, '/');
              Provider.of<Auth>(context,listen: false).logout();
            },
          ),
          Divider(color:Colors.blueGrey,),
        ],
      ),
    );
  }
}
