import 'package:fifth/widget/chart.dart';
import 'package:fifth/widget/newt.dart';
import 'package:fifth/widget/tlist.dart';
import 'package:flutter/material.dart';
import 'models/transaction.dart';
void main() {
  runApp(MaterialApp(
    home: Home(),
  ));
}
class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final title = TextEditingController();
  final amount = TextEditingController();
  final List<Transaction> _list=[];
  void _addT(String name,double amount,DateTime date){
    setState(() {
      _list.add(Transaction(
          id:DateTime.now().toString(),
          name:name,
          amount:amount,
          date:date
      ));
    });
  }
  void deleteT(String id){
    setState(() {
      _list.removeWhere((element) => element.id==id);
    });
  }
  void realAdd(BuildContext ctx){
    showModalBottomSheet(context: ctx, builder: (_){
      return GestureDetector(child: NewT(_addT),onTap: (){},behavior: HitTestBehavior.opaque,);
    });
  }
  List<Transaction> get _recentTransaction{
    return _list.where((tx){
      return tx.date.isAfter(DateTime.now().subtract(Duration(days: 7)));
    }).toList();
  }
  @override
  Widget build(BuildContext context) {
    final appBar=AppBar(
      backgroundColor: Colors.black,
      elevation: 40,
      actions: <Widget>[
        IconButton(icon: Icon(Icons.add), onPressed: ()=>realAdd(context))
      ],
      centerTitle: true,
      title: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Text('Personal Expenses',style:TextStyle(fontSize: 24)),
      ),
    );
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: appBar,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(5.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Container(
                  child: Chart(_recentTransaction),
                height: (MediaQuery.of(context).size.height - appBar.preferredSize.height -
                    MediaQuery.of(context).padding.top)*0.35,
              ),
              (_list.length==0)?Container(
                height: (MediaQuery.of(context).size.height - appBar.preferredSize.height -
                    MediaQuery.of(context).padding.top)*0.6,
                child: Column(
                  //crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(height: 80.0,),
                    Container(
                      height: 200,
                      child: Image(
                          image:AssetImage('assets/sleep1.png'),
                        fit:BoxFit.cover,
                      ),
                    ),
                  ],
                ),
              ):Container(
                  child: TList(_list,deleteT),
                height: (MediaQuery.of(context).size.height - appBar.preferredSize.height -
                    MediaQuery.of(context).padding.top)*0.6,
              ),
            ],
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.miniCenterFloat,
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.black,
        onPressed: ()=>realAdd(context),
        child: Icon(
          Icons.add,
          size: 25,
        ),
      ),
    );
  }
}
