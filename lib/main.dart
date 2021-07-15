import 'package:flutter/material.dart';
import 'package:seventh/providers/auth.dart';
import 'package:seventh/providers/cart.dart';
import 'package:seventh/providers/orders.dart';
import 'package:seventh/providers/product_provider.dart';
import 'package:seventh/screens/auth_screen.dart';
import 'package:seventh/screens/cart_screen.dart';
import 'package:seventh/screens/edit_product_screen.dart';
import 'package:seventh/screens/order_screen.dart';
import 'package:seventh/screens/product_details_screen.dart';
import 'package:seventh/screens/product_overview_file.dart';
import 'package:provider/provider.dart';
import 'package:seventh/screens/splash_screen.dart';
import 'package:seventh/screens/user_product.dart';
void main() {
  runApp(MyApp());
}
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (ctx)=> Auth(),
        ),
        ChangeNotifierProxyProvider<Auth,Products>(
          update: (ctx,auth,previousProducts)=> Products(
              auth.token,
              auth.userId,
              previousProducts==null?[]:previousProducts.items
          ),
        ),
        ChangeNotifierProvider(
          create: (ctx)=> Cart(),
        ),
        ChangeNotifierProxyProvider<Auth,Order>(
          update: (ctx,auth,previousOrders)=> Order(
              auth.token,
              auth.userId,
              previousOrders==null?[]:previousOrders.orders
          ),
        ),
      ],
      child: Consumer<Auth>(
      builder: (ctx,auth,_)=>MaterialApp(
        theme: ThemeData(
          primaryColor: Colors.greenAccent,
        ),
        home: auth.isAuth?ProductOverviewScreen():
            FutureBuilder(
              future: auth.tryAutoLogin(),
                builder: (ctx,authResultSnapshot) =>
                authResultSnapshot.connectionState==ConnectionState.waiting ?
                SplashScreen():AuthScreen()
            ),
        routes: {
          ProductDetailsScreen.routeName: (ctx) => ProductDetailsScreen(),
          CartScreen.routeName: (ctx) => CartScreen(),
          OrderScreen.routeName: (ctx) => OrderScreen(),
          UserProductScreen.routeName: (ctx) => UserProductScreen(),
          EditProductScreen.routeName: (ctx) => EditProductScreen(),
        },
      ),
    )
    );
  }
}

