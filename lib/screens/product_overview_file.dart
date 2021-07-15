import 'package:flutter/material.dart';
import 'package:seventh/providers/cart.dart';
import 'package:seventh/providers/product_provider.dart';
import 'package:seventh/screens/cart_screen.dart';
import 'package:seventh/widgets/app_drawer.dart';
import 'package:seventh/widgets/badge.dart';
import 'package:seventh/widgets/products_grid.dart';
import 'package:provider/provider.dart';
enum FilterType{
  All,Favourites
}
class ProductOverviewScreen extends StatefulWidget {
  @override
  _ProductOverviewScreenState createState() => _ProductOverviewScreenState();
}
class _ProductOverviewScreenState extends State<ProductOverviewScreen> {
  bool _showFavourites=false;
  var isInit=true;
  var isLoading=false;
  @override
  void didChangeDependencies() {
    if(isInit){
      setState(() {
        isLoading=true;
      });
      Provider.of<Products>(context).fetchData().then((value){
        setState(() {
          isLoading=false;
        });
      });
    }
    isInit=false;
    super.didChangeDependencies();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: AppDrawer(),
      appBar: AppBar(
        title:Text('Shopping App'),
        actions: <Widget>[
          PopupMenuButton(
              icon: Icon(Icons.more_vert),
            onSelected: (FilterType selected){
                setState(() {
                  if(selected==FilterType.Favourites){
                    _showFavourites=true;
                  }else if(selected==FilterType.All) {
                    _showFavourites = false;
                  }
                });
            },
            itemBuilder : (_) => [
              PopupMenuItem(
                child: Text('All'),
                value:FilterType.All
              ),
              PopupMenuItem(
                  child: Text('Favourites'),
                  value:FilterType.Favourites
              ),
            ]
          ),
          Consumer<Cart>(
            builder: (_,cart,ch)=>Badge(
              child: ch,
              value:cart.cartItemCount.toString(),
            ),
            child: IconButton(
              onPressed: (){
                Navigator.of(context).pushNamed(CartScreen.routeName);
              },
              icon: Icon(Icons.shopping_cart,
                color:Colors.black,
              )
            ),
          )
        ],
      ),
      body:isLoading?Center(child: CircularProgressIndicator(),):ProductsGrid(_showFavourites),
    );
  }
}
