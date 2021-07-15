import 'dart:io';
import 'package:flutter/material.dart';
import 'package:seventh/providers/product.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
class Products with ChangeNotifier{
  List<Product> _items=[
    // Product(
    //   id: 'p1',
    //   title: 'Red Shirt',
    //   description: 'A red shirt - it is pretty red!',
    //   price: 29.99,
    //   imageUrl:
    //   'https://cdn.pixabay.com/photo/2016/10/02/22/17/red-t-shirt-1710578_1280.jpg',
    // ),
    // Product(
    //   id: 'p2',
    //   title: 'Trousers',
    //   description: 'A nice pair of trousers.',
    //   price: 59.99,
    //   imageUrl:
    //   'https://upload.wikimedia.org/wikipedia/commons/thumb/e/e8/Trousers%2C_dress_%28AM_1960.022-8%29.jpg/512px-Trousers%2C_dress_%28AM_1960.022-8%29.jpg',
    // ),
    // Product(
    //   id: 'p3',
    //   title: 'Yellow Scarf',
    //   description: 'Warm and cozy - exactly what you need for the winter.',
    //   price: 19.99,
    //   imageUrl:
    //   'https://live.staticflickr.com/4043/4438260868_cc79b3369d_z.jpg',
    // ),
    // Product(
    //   id: 'p4',
    //   title: 'A Pan',
    //   description: 'Prepare any meal you want.',
    //   price: 49.99,
    //   imageUrl:
    //   'https://upload.wikimedia.org/wikipedia/commons/thumb/1/14/Cast-Iron-Pan.jpg/1024px-Cast-Iron-Pan.jpg',
    // ),
  ];
  final String token;
  final String userId;
  Products(this.token,this.userId,this._items);
  List<Product> get items{
    return [..._items];
  }
  List<Product> get favourites{
    return [..._items].where((element) => element.isFavourite==true).toList();
  }
  Future<void> fetchData([bool filterByUser=false]) async{
    try{
      String f=filterByUser?'orderBy="creatorId"&equalTo="$userId"':'';
      final url = 'https://first-shop-app-cd3ca-default-rtdb.firebaseio.com/products.json?auth=$token&'+f;
      final response = await http.get(Uri.parse(url));
      final favouritesUrl = 'https://first-shop-app-cd3ca-default-rtdb.firebaseio.com/favourites/$userId.json?auth=$token';
      final favouritesResponse = await http.get(Uri.parse(favouritesUrl));
      var fetchedData=json.decode(response.body) as Map<String,dynamic>;
      var fetchedFavourites=json.decode(favouritesResponse.body);
      List<Product> loadedProducts=[];
      fetchedData.forEach((key, value) {
         loadedProducts.add(Product(
           id:key,
           title: value['title'],
           description: value['description'],
           imageUrl: value['imageUrl'],
           price: value['price'],
           isFavourite: fetchedFavourites==null?false:fetchedFavourites[key]??false
         ));
      });
      _items=loadedProducts;
      notifyListeners();
    }catch(error){
      throw error;
    }
  }
  Future<void> addProduct(Product value) async {
    try {
      final url = 'https://first-shop-app-cd3ca-default-rtdb.firebaseio.com/products.json?auth=$token';
      final response = await http.post(Uri.parse(url), body: json.encode({
        'creatorId':userId,
        'title': value.title,
        'description': value.description,
        'imageUrl': value.imageUrl,
        'price': value.price,
      }));
      final newProduct = Product(
          id: json.decode(response.body)['name'],
          title: value.title,
          description: value.description,
          imageUrl: value.imageUrl,
          price: value.price,
      );
      _items.add(newProduct);
      notifyListeners();
    } catch (error) {
      throw error;
    }
  }
  Future<void> updateProducts(String id, Product product) async{
    final index =_items.indexWhere((element) => element.id==id);
    if(index>=0){
      final url= 'https://first-shop-app-cd3ca-default-rtdb.firebaseio.com/products/$id.json?auth=$token';
      await http.patch(Uri.parse(url),body: json.encode(
          {
            'title': product.title,
            'description':product.description,
            'price':product.price,
            'imageUrl':product.imageUrl,
          })
      );
    }
    _items[index] = product;
    notifyListeners();
  }
  Product findProduct(String id){
    return _items.firstWhere((element) => element.id==id);
  }
  Future<void> removeProduct(String id) async{
    final index=_items.indexWhere((element) => element.id==id);
    var deleteProduct=_items[index];
    _items.removeWhere((element) => element.id==id);
    notifyListeners();
    final url= 'https://first-shop-app-cd3ca-default-rtdb.firebaseio.com/products/$id.json?auth=$token';
    final response = await http.delete(Uri.parse(url));
    if(response.statusCode>=400){
      _items.insert(index, deleteProduct);
      notifyListeners();
      throw HttpException('Could Not Delete!');
    }
    deleteProduct=null;
  }
}