import 'package:flutter/cupertino.dart';
class CartItem{
  final String id;
  final String title;
  final int quantity;
  final double price;
  CartItem({
    @required this.id,
    @required this.title,
    @required this.price,
    @required this.quantity});
}
class Cart with ChangeNotifier{
  Map<String,CartItem> _cart={};
  Map<String,CartItem> get cartItems{
    return {..._cart};
  }

  int get cartItemCount{
    return _cart.length;
  }
  void addItem(String productId,double price,String title){
    if(_cart.containsKey(productId)){
      _cart.update(productId, (value) =>
          CartItem(
              id: value.id,
              title: value.title,
              price: value.price,
              quantity: value.quantity+1
          )
      );
    }else{
      _cart.putIfAbsent(productId, () =>
          CartItem(
              id: DateTime.now().toString(),
              title: title, price: price,
              quantity: 1
          )
      );
    }
    notifyListeners();
  }
  double totalAmount(){
    double total=0;
    _cart.forEach((key, value) {
      total+=value.price*value.quantity;
    });
    return total;
  }
  void removeItem(String id){
    _cart.remove(id);
    notifyListeners();
  }
  void clear(){
    _cart={};
    notifyListeners();
  }
  void removeSingleItem(String id){
    if(!_cart.containsKey(id)){
      return;
    }else if(_cart[id].quantity>1){
      _cart.update(id, (existing) => CartItem(id: existing.id, title: existing.title, price: existing.price, quantity: existing.quantity-1));
    }
    else{
      removeItem(id);
    }
    notifyListeners();
  }
}