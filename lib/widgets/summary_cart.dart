import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:seventh/providers/cart.dart';
import 'package:seventh/widgets/cart_product_item.dart';
class SummaryCart extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height-290,
      child: Card(
        elevation: 30,
        margin: const EdgeInsets.all(10),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Consumer<Cart>(
            builder: (ctx,cart,child)=>ListView.builder(
                itemCount: cart.cartItemCount,
                itemBuilder: (ctx,i)=>CartProductItem(
                  title: cart.cartItems.values.toList()[i].title,
                  id: cart.cartItems.values.toList()[i].id,
                  price: cart.cartItems.values.toList()[i].price,
                  quantity: cart.cartItems.values.toList()[i].quantity,
                  keys: cart.cartItems.keys.toList()[i]
                ),
            )
          ),
        ),
      ),
    );
  }
}
