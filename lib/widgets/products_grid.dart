import 'package:flutter/material.dart';
import 'package:seventh/providers/product_provider.dart';
import 'package:provider/provider.dart';
import 'package:seventh/widgets/product_item.dart';
class ProductsGrid extends StatelessWidget {
  final _showFavs;
  ProductsGrid(this._showFavs);
  @override
  Widget build(BuildContext context) {
    final productsData=Provider.of<Products>(context);
    final _products=_showFavs?productsData.favourites:productsData.items;
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 10,
        crossAxisSpacing: 10,
        childAspectRatio: 2/2.7,
      ),
      itemCount: _products.length,
      padding: const EdgeInsets.all(10),
      itemBuilder: (ctx,i)=>ChangeNotifierProvider.value(
        value:_products[i],
        child: ProductItem(),
      ),
    );
  }
}
