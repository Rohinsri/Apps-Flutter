import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:seventh/providers/cart.dart';
class CartProductItem extends StatelessWidget {
  final String title;
  final String id;
  final double price;
  final String keys;
  final int quantity;

  CartProductItem({
    @required this.id,
    @required this.title,
    @required this.quantity,
    @required this.price,
    @required this.keys
  });

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: ValueKey(id),
      onDismissed: (direction) {
        Provider.of<Cart>(context, listen: false).removeItem(keys);
      },
      direction: DismissDirection.endToStart,
      confirmDismiss: (direction){
        return showDialog(context: context, builder: (ctx)=>AlertDialog(
          title: Text('Are You Sure?'),
          content: Text('Do you want to delete the item from the cart'),
          actions: <Widget>[
            FlatButton(onPressed: (){
              Navigator.of(context).pop(true);
            }, child: Text('Yes'),color: Colors.blueGrey,),
            FlatButton(onPressed: (){
              Navigator.of(context).pop(false);
            }, child: Text('No'),color: Colors.blueGrey,),
          ],
        )
        );
      },
      background: Container(
        margin: const EdgeInsets.all(12.0),
        color: Theme
            .of(context)
            .errorColor,
        child: Icon(
          Icons.delete,
          size: 30,
          color: Colors.white,
        ),
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 20),
      ),
      child: Column(
        children: [
          ListTile(
            leading: Card(
              color: Colors.black,
              elevation: 10,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)
              ),
              child: Container(
                height: 80,
                width: 100,
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: FittedBox(
                    child: Text('\$ ' +
                        (price * quantity).toString(),
                      style: TextStyle(
                        color: Colors.greenAccent,
                        fontWeight: FontWeight.w900,
                        fontSize: 20,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            title: Text(title,
                style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 20
                )
            ),
            subtitle: Text('Cost of one : ' + '\$ ' + price.toString()),
            trailing: Text('x' + quantity.toString(),
                style: TextStyle(
                  fontSize: 20,
                )
            ),
          ),
          Divider(color: Colors.blueGrey,),
        ],
      ),
    );
  }
}
