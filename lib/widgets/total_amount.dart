import 'package:flutter/material.dart';
import 'package:seventh/providers/cart.dart';
import 'package:provider/provider.dart';
import 'package:seventh/providers/orders.dart';
class TotalAmount extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<Cart>(context);
    return Card(
      color: Colors.greenAccent[100],
        elevation: 30,
        margin: const EdgeInsets.all(10),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child:Padding(
          padding: const EdgeInsets.symmetric(
            vertical:12.0,
            horizontal: 20,
          ),
          child: Column(
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text('Total Amount:',
                      style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.w700
                      )
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Card(
                        shape:RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)
                        ),
                        elevation: 10,
                        color:Colors.black,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text('\$ '+cart.totalAmount().toString(),
                              style: TextStyle(
                                color:Theme.of(context).accentColor,
                                fontSize: 25,
                                fontWeight: FontWeight.w600,
                              )
                          ),
                        ),
                      ),
                    ),
                ],
              ),
              SizedBox(height: 20,),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  OrderButton(cart),
                ],
              )
            ],
          ),
        )
    );
  }
}


class OrderButton extends StatefulWidget {
  final Cart cart;
  OrderButton(this.cart);
  @override
  _OrderButtonState createState() => _OrderButtonState();
}

class _OrderButtonState extends State<OrderButton> {
  var isLoading=false;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: widget.cart.totalAmount()<=0 ||isLoading? null : () async{
          setState(() {
            isLoading=true;
          });
          await Provider.of<Order>(context,listen: false)
              .addOrder(widget.cart.cartItems.values.toList(), widget.cart.totalAmount());
          widget.cart.clear();
          setState(() {
            isLoading=false;
          });
        },
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: isLoading?CircularProgressIndicator():Text('Order Now',
              style:TextStyle(
                  fontWeight: FontWeight.normal,
                  fontSize: 20
              )
          ),
        ),
    );
  }
}
