import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
class Product with ChangeNotifier{
  final String id;
  final String title;
  final String description;
  final double price;
  final String imageUrl;
  bool isFavourite;
  Product({
    @required this.id,
    @required this.title,
    @required this.description,
    @required this.price,
    @required this.imageUrl,
    this.isFavourite=false
  });
  Future<void> toggleFavouriteStatus(String token,String userId) async{
    final url= 'https://first-shop-app-cd3ca-default-rtdb.firebaseio.com/favourites/$userId/$id.json?auth=$token';
    var oldStatus=isFavourite;
    isFavourite = !isFavourite;
    try{
      final response= await http.put(Uri.parse(url),
          body: json.encode(isFavourite));
      notifyListeners();
      if(response.statusCode>=400){
        isFavourite=oldStatus;
        notifyListeners();
      }
    }catch(error){
      isFavourite=oldStatus;
      notifyListeners();
    }
    notifyListeners();
  }
}