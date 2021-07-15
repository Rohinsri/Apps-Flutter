import 'package:flutter/material.dart';
import 'package:seventh/providers/orders.dart';
import 'package:intl/intl.dart';
import 'dart:math';
class OrdersItem extends StatefulWidget {
  final OrderItem order;
  OrdersItem(this.order);
  @override
  _OrdersItemState createState() => _OrdersItemState();
}

class _OrdersItemState extends State<OrdersItem> {
  var _expanded=false;
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 30,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListTile(
              leading: Card(
                color: Colors.black,
                elevation: 30,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)
                ),
                child: Container(
                  height: 80,
                  width: 100,
                  child: Padding(
                    padding: const EdgeInsets.all(13.0),
                    child: FittedBox(
                      child: Text('\$ ' +
                          (widget.order.amount).toString(),
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
              title: Text('Bought On',style: TextStyle(fontSize:20),),
              subtitle: Text(DateFormat.yMMMMEEEEd().format(widget.order.date) +' '+ DateFormat('HH:MM').format(widget.order.date),
                style: TextStyle(
                  fontSize: 17,
                ),
              ),
              trailing: IconButton(
                icon:Icon(
                  _expanded?Icons.keyboard_arrow_up:Icons.keyboard_arrow_down,
                ),
                onPressed: (){
                  setState(() {
                    _expanded=!_expanded;
                  });
                },
              ),
            ),
          ),
          AnimatedContainer(duration: Duration(milliseconds: 500),
            height: _expanded?min(widget.order.products.length*30.0+100,300):0,
            child:ListView.builder(
                itemCount: widget.order.products.length,
                itemBuilder: (ctx,i)=>ListTile(
                  leading: Card(
                    elevation: 10,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)
                    ),
                    child: Container(
                      height: 50,
                      width: 80,
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: FittedBox(
                          child: Text('\$ ' +
                              (widget.order.products.toList()[i].price * widget.order.products.toList()[i].quantity).toString(),
                            style: TextStyle(
                              color: Colors.greenAccent,
                              fontWeight: FontWeight.w900,
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  title: Text(widget.order.products.toList()[i].title,
                      style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 20
                      )
                  ),
                  subtitle: Text('Cost of one : ' + '\$ ' + widget.order.products.toList()[i].price.toString()),
                  trailing: Text('x' + widget.order.products.toList()[i].quantity.toString(),
                      style: TextStyle(
                        fontSize: 20,
                      )
                  ),
                ),
              )
            ),
        ],
      ),
    );
  }
}
