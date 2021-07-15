import 'package:flutter/cupertino.dart';
import 'package:seventh/providers/cart.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
class OrderItem{
  final String id;
  final double amount;
  final List<CartItem> products;
  final DateTime date;
  OrderItem({this.id,
    this.amount,
    this.date,
    this.products}
      );
}
class Order with ChangeNotifier{
  List<OrderItem> _orders=[];
  final String token;
  final String userId;
  Order(this.token,this.userId,this._orders);
  List<OrderItem> get orders{
    return [..._orders];
  }
  Future<void> fetchOrders() async{
    final url = 'https://first-shop-app-cd3ca-default-rtdb.firebaseio.com/orders/$userId.json?auth=$token';
    final response=await http.get(Uri.parse(url));
    var fetchedData=json.decode(response.body) as Map<String,dynamic>;
    if(fetchedData==null){
      return;
    }
    List<OrderItem> loadedOrders=[];
    fetchedData.forEach((key, value) {
      loadedOrders.add(OrderItem(
          id:key,
        date:DateTime.parse(value['date']),
        products: (value['products'] as List<dynamic>).map((e) => CartItem(
            id: e['id'],
            title: e['title'],
            price: e['price'],
            quantity: e['quantity']
        )
        ).toList(),
        amount: value['amount'],
      ));
    });
    _orders=loadedOrders;
    notifyListeners();
  }
  Future<void> addOrder(List<CartItem> cartItems,double total) async{
    final url = 'https://first-shop-app-cd3ca-default-rtdb.firebaseio.com/orders/$userId.json?auth=$token';
    final timestamp=DateTime.now();
    final response = await http.post(Uri.parse(url),
        body: json.encode({
      'amount':total,
      'date':timestamp.toIso8601String(),
      'products':cartItems.map((e) => {
        'id':e.id,
        'title':e.title,
        'price':e.price,
        'quantity':e.quantity,
    }).toList()
    }));
    _orders.insert(0,OrderItem(
      id:json.decode(response.body)['name'],
      amount: total,
      products: cartItems,
      date: timestamp,
      )
    );
    notifyListeners();
  }
}