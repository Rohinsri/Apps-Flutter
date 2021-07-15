import 'package:flutter/material.dart';
import 'package:seventh/providers/auth.dart';
import 'package:seventh/providers/cart.dart';
import 'package:seventh/providers/product.dart';
import 'package:seventh/screens/product_details_screen.dart';
import 'package:provider/provider.dart';
class ProductItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final product=Provider.of<Product>(context,listen: false);
    return GridTile(
      child: GestureDetector(
        onTap: (){
          Navigator.of(context).pushNamed(ProductDetailsScreen.routeName,arguments: product.id);
        },
        child: Stack(
          children: [
            Card(
            elevation: 30,
            shape:RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: Colors.greenAccent,width:3)
              ),
              child: Column(
                children: [
                  SizedBox(height: 15,),
                  Expanded(
                    child: Hero(
                      tag: product.id,
                      child: FadeInImage(
                        image: NetworkImage(product.imageUrl),
                        placeholder: AssetImage('assets/images/placeholder.png'),
                        fit: BoxFit.fill,
                        ),
                    ),
                    ),
                  SizedBox(height: 8,),
                  ClipRRect(
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(17),
                      bottomRight: Radius.circular(17),
                    ),
                    child: Container(
                      color:Colors.greenAccent,
                      height: 70,
                    ),
                  ),
                ],
              ),
            )
          ),
            Positioned(
              top:10,
                right: 10,
                child: Card(
                  elevation: 20,
                  shape:CircleBorder(
                      side: BorderSide(color:Theme.of(context).primaryColor, width:3)
                  ),
                  child: Consumer<Product>(
                    builder: (ctx,product,child)=> IconButton(
                      icon: Icon(product.isFavourite?Icons.favorite:Icons.favorite_border,
                        color:Colors.redAccent,
                        size:30,
                      ),
                      onPressed: (){
                        product.toggleFavouriteStatus(
                          Provider.of<Auth>(context,listen: false).token,
                          Provider.of<Auth>(context,listen: false).userId
                        );
                      },
                    ),
                  ),
                )
            )
          ]
        ),
      ),
      footer: Padding(
        padding: const EdgeInsets.all(8.0),
        child: GridTileBar(
          title: Text(product.title,
            style: TextStyle(
              color: Colors.black,
                fontSize: 18,
            ),
          ),
          subtitle: Text('\$ '+product.price.toString(),
            style: TextStyle(
              color: Colors.black,
              fontSize: 14,
            ),
          ),
          trailing: Card(
            elevation: 20,
            color: Colors.white,
            shape:CircleBorder(
                //side:BorderSide(color: Colors.blue,width: 1)
            ),
            child: Consumer<Cart>(
              builder:(ctx,cart,child)=> Consumer<Product>(
                builder: (ctx,product,child)=> IconButton(
                  icon: Icon(
                    Icons.shopping_cart,
                    color:Colors.blue,
                    size:27,
                  ),
                  onPressed: (){
                    cart.addItem(product.id, product.price, product.title);
                    Scaffold.of(context).hideCurrentSnackBar();
                    Scaffold.of(context).showSnackBar(SnackBar(
                        content: Text('Item Added!'),
                        action: SnackBarAction(
                          label: 'UNDO',
                          onPressed: (){
                            cart.removeSingleItem(product.id);
                          },
                        ),
                      )
                    );
                  },
                ),
              ),
            ),
          ),
        ),
      )
    );
  }
}
