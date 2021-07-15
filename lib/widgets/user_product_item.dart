import 'package:flutter/material.dart';
import 'package:seventh/providers/product_provider.dart';
import 'package:seventh/screens/edit_product_screen.dart';
import 'package:provider/provider.dart';
class UserProductItem extends StatelessWidget {
  final String id;
  final String title;
  final String imageUrl;
  UserProductItem({
    @required this.id,
    @required this.title,
    @required this.imageUrl
});
  @override
  Widget build(BuildContext context) {
    var scaffold=Scaffold.of(context);
    return Card(
      elevation: 30,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15)
      ),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: ListTile(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15)
          ),
          leading: CircleAvatar(
            radius: 30,
            backgroundImage: NetworkImage(imageUrl),
          ),
          title: Text(title,style: TextStyle(fontSize: 18),),
          trailing: Container(
            width:100,
            child: Row(
              children: <Widget>[
                IconButton(icon: Icon(Icons.edit,size: 27,),color:Theme.of(context).primaryColor, onPressed: (){
                  Navigator.of(context).pushNamed(EditProductScreen.routeName,arguments: id);
                }),
                IconButton(icon: Icon(Icons.delete,size: 27,),color:Colors.red,
                    onPressed: () async{
                      try{
                        await Provider.of<Products>(context, listen: false)
                            .removeProduct(id);
                      }
                      catch(error){
                        scaffold.showSnackBar(SnackBar(content: Text('Deletion Failed!')));
                      }
                    }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
