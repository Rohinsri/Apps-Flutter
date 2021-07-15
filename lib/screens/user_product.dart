import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:seventh/providers/product_provider.dart';
import 'package:seventh/screens/edit_product_screen.dart';
import 'package:seventh/widgets/app_drawer.dart';
import 'package:seventh/widgets/user_product_item.dart';
class UserProductScreen extends StatelessWidget {
  Future<void> _refresh(BuildContext context) async{
    await Provider.of<Products>(context,listen: false).fetchData(true);
  }
  static const routeName='/YourProducts';
  @override
  Widget build(BuildContext context) {
    //final productsData=Provider.of<Products>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Products'),
        actions: <Widget>[
          IconButton(icon: Icon(Icons.add),onPressed: (){
            Navigator.of(context).pushNamed(EditProductScreen.routeName);
          },
          )
        ],
      ),
      drawer: AppDrawer(),
      body:FutureBuilder(
        future: _refresh(context),
        builder:(ctx,snapshot)=> RefreshIndicator(
          onRefresh: () => _refresh(context),
          child: snapshot.connectionState==ConnectionState.waiting
              ?Center(child: CircularProgressIndicator())
              :Padding(
            padding: const EdgeInsets.all(10),
            child: Consumer<Products>(
              builder:(ctx,productsData,_)=>ListView.builder(
                itemCount: productsData.items.length,
                  itemBuilder: (ctx,i)=>UserProductItem(
                    id: productsData.items[i].id,
                    title: productsData.items[i].title,
                    imageUrl: productsData.items[i].imageUrl,
                  )
              ),
            ),
          ),
        ),
      )
    );
  }
}
