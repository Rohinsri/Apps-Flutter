import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:seventh/providers/product_provider.dart';
class ProductDetailsScreen extends StatelessWidget {
  static const routeName='/ProductDetailsScreen';
  @override
  Widget build(BuildContext context) {
    final String productId=ModalRoute.of(context).settings.arguments.toString();
    var product=Provider.of<Products>(context).findProduct(productId);
    return Scaffold(
        appBar: AppBar(
          title: Text(product.title),
        ),
        body: Column(
          children: [
            Card(
                elevation: 30,
                shape:RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: Colors.greenAccent,width:4)
                  ),
                  child: Column(
                    children: [
                      SizedBox(height: 15,),
                      Hero(
                        tag:product.id,
                        child: Image.network(product.imageUrl,
                          width: double.infinity,
                          height: MediaQuery.of(context).size.height*0.3,
                          fit:BoxFit.contain,
                        ),
                      ),
                      SizedBox(height: 8,),
                      ClipRRect(
                        borderRadius: BorderRadius.only(
                          bottomRight: Radius.circular(17),
                          bottomLeft: Radius.circular(17),
                        ),
                        child: Container(
                          width: double.infinity,
                          color:Colors.greenAccent,
                          padding: const EdgeInsets.all(20),
                          child:Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(height:10),
                              Text(
                                  'Features:',
                                  style:TextStyle(
                                    fontSize: 23,
                                    fontWeight: FontWeight.w700
                                  )
                              ),
                              SizedBox(height:5),
                              Text(
                                  product.description,
                                  style:TextStyle(
                                    fontSize: 19,
                                  )
                              ),
                              SizedBox(height:10),
                              Text(
                                  'Price: \$ '+product.price.toString(),
                                  style:TextStyle(
                                    fontSize: 23,
                                    fontWeight: FontWeight.w700
                                  )
                              )
                            ],
                          )
                        ),
                      ),
                    ],
                  ),
                )
            ),
          ],
        )
    );
  }
}
