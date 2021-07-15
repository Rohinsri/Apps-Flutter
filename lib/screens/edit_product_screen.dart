import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:seventh/providers/product.dart';
import 'package:provider/provider.dart';
import 'package:seventh/providers/product_provider.dart';
class EditProductScreen extends StatefulWidget {
  static const routeName='/EditProductScreen';
  @override
  _EditProductScreenState createState() => _EditProductScreenState();
}
class _EditProductScreenState extends State<EditProductScreen> {
  final _priceFocusNode=FocusNode();
  final _descriptionFocusNode=FocusNode();
  final _imageController=TextEditingController();
  final _imageFocusNode=FocusNode();
  final _form=GlobalKey<FormState>();
  var isInit=true;
  var isLoading=false;
  var initValues={
    'title':'',
    'description':'',
    'imageUrl':'',
    'price':''
  };
  var _editProduct=Product(
    id:null,
    title:'',
    description: '',
    imageUrl: '',
    price: 0.0,
  );

  void disposeNode(){
    _priceFocusNode.dispose();
    _descriptionFocusNode.dispose();
    _imageController.dispose();
    _priceFocusNode.dispose();
    _imageController.removeListener(_updateImage);
  }
  @override
  void initState() {
    _imageController.addListener(_updateImage);
    super.initState();
  }
  @override
  void didChangeDependencies() {
    if(isInit){
      String eid=ModalRoute.of(context).settings.arguments as String;
      if(eid!=null){
        _editProduct=Provider.of<Products>(context, listen: false).findProduct(eid);
        initValues={
          'title':_editProduct.title,
          'price':_editProduct.price.toString(),
          'description':_editProduct.description,
          'imageUrl':'',
        };
        _imageController.text=_editProduct.imageUrl;
      }
      }
    isInit=false;
    super.didChangeDependencies();
  }
  void _updateImage(){
    if(!_imageFocusNode.hasFocus){
      if(_imageController.text.isEmpty||
          (!_imageController.text.startsWith('http')&&
          !_imageController.text.startsWith('https')&&
          !_imageController.text.endsWith('jpg')&&
          !_imageController.text.endsWith('png')&&
          !_imageController.text.endsWith('jpeg'))){
        return ;
      }
      setState(() {});
    }
  }
  Future<void> _saveForm() async{
    final isValid=_form.currentState.validate();
    if(!isValid){
       return;
    }
    var eid=_editProduct.id;
    _form.currentState.save();
    setState(() {
      isLoading=true;
    });
    if(eid!=null) {
      await Provider.of<Products>(context, listen: false).updateProducts(eid, _editProduct);
      setState(() {
        isLoading=false;
      });
      Navigator.of(context).pop();
    }
    else{
       try{
         await Provider.of<Products>(context, listen: false).addProduct(_editProduct);
      }
      catch(error){
      await showDialog(context: context,
      builder: (ctx)=>AlertDialog(
        title: Text('Error!'),
        content: Text(error.toString()),
        actions: <Widget>[
          FlatButton(onPressed: (){
          Navigator.of(ctx).pop();
            },
            child: Text('Okay')
          )
        ],)
      );
    } finally{
        setState(() {
          isLoading=false;
        });
        Navigator.of(context).pop();
      }
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Profile'),
        actions: <Widget>[
          IconButton(icon: Icon(Icons.save),
              onPressed: (){
              _saveForm();
            }
          )
        ],
      ),
      body:isLoading?Center(child: CircularProgressIndicator()) :Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _form,
          child: ListView(
            children: <Widget>[
              TextFormField(
                decoration: InputDecoration(labelText: 'Title'),
                initialValue: initValues['title'],
                textInputAction: TextInputAction.next,
                onFieldSubmitted: (_){
                  FocusScope.of(context).requestFocus(_priceFocusNode);
                },
                onSaved: (value){
                  _editProduct=Product(
                    id:null,
                    title: value,
                    description: _editProduct.description,
                    price: _editProduct.price,
                    imageUrl: _editProduct.imageUrl
                  );
                },
                validator: (value){
                  if(value.isEmpty){
                    return 'Enter a valid title';
                  }
                  return null;
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Price'),
                initialValue: initValues['price'],
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.number,
                focusNode: _priceFocusNode,
                onFieldSubmitted: (_){
                  FocusScope.of(context).requestFocus(_descriptionFocusNode);
                },
                onSaved: (value){
                  _editProduct=Product(
                      id:null,
                      title: _editProduct.title,
                      description: _editProduct.description,
                      price: double.parse(value),
                      imageUrl: _editProduct.imageUrl
                  );
                },
                validator: (value){
                  if(value.isEmpty){
                    return 'Price is required!';
                  }
                  if(double.tryParse(value)==null){
                    return 'Enter a valid price!';
                  }
                  else if(double.parse(value)<=0){
                    return 'Price should be greater than 0!';
                  }
                  return null;
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Description',),
                initialValue: initValues['description'],
                textInputAction: TextInputAction.next,
                maxLines: 3,
                keyboardType: TextInputType.multiline,
                focusNode: _descriptionFocusNode,
                onSaved: (value){
                  _editProduct=Product(
                      id:null,
                      title: _editProduct.title,
                      description: value,
                      price: _editProduct.price,
                      imageUrl: _editProduct.imageUrl
                  );
                },
                validator: (value){
                  if(value.isEmpty){
                    return 'Description is required!';
                  }
                  if(value.length<=10){
                    return 'Minimum 10 characters are required!';
                  }
                  return null;
                },
              ),
              Row(
                children: <Widget>[
                  Container(
                    height: 100,
                    width: 100,
                    child:_imageController.text.isEmpty?Center(child: Text('Enter a URL')):
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: FittedBox(child: Image.network(_imageController.text,fit: BoxFit.cover,)),
                    )
                  ),
                  Expanded(
                    child: TextFormField(
                      decoration: InputDecoration(labelText: 'Image URL'),
                      controller: _imageController,
                      textInputAction: TextInputAction.done,
                      keyboardType: TextInputType.url,
                      onSaved: (value){
                        _editProduct=Product(
                            id:null,
                            title: _editProduct.title,
                            description: _editProduct.description,
                            price: _editProduct.price,
                            imageUrl: value
                        );
                      },
                      validator: (value){
                        if(!value.startsWith('http')&&!value.startsWith('https')){
                          return 'Enter a valid URL';
                        }
                        if(!value.endsWith('jpg')&&!value.endsWith('png')&&!value.endsWith('jpeg')){
                          return 'Enter a valid Image type!';
                        }
                        return null;
                      },
                      onFieldSubmitted: (_){
                        _saveForm();
                      },
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      )
    );
  }
}