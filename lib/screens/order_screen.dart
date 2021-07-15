import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:seventh/providers/orders.dart';
import 'package:seventh/widgets/app_drawer.dart';
import 'package:seventh/widgets/orders_item.dart';
class OrderScreen extends StatelessWidget {
  static const routeName='/order_screen';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Orders'),
      ),
      drawer: AppDrawer(),
      body:FutureBuilder(
        future: Provider.of<Order>(context,listen: false).fetchOrders(),
        builder: (ctx,dataSnapshot){
          if(dataSnapshot.connectionState==ConnectionState.waiting){
            return Center(child: CircularProgressIndicator());
          }
          else if(dataSnapshot.error!=null){
            return Center(child: Text('An error occured!'),);
          }
          else{
            return Consumer<Order>(
              builder:(c,order,child)=> ListView.builder(
                padding: const EdgeInsets.all(10),
                itemCount: order.orders.length,
                itemBuilder: (ctx,i)=>OrdersItem(order.orders[i]),
              ),
            );
          }
        },
      )
    );
  }
}
