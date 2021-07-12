import 'package:fifth/models/transaction.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
// ignore: must_be_immutable
class TList extends StatelessWidget {
  List<Transaction> list;
  Function del;
  TList(this.list,this.del);
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: list.length,
      itemBuilder:(context,index){
        return Padding(
          padding: const EdgeInsets.fromLTRB(8.0,0.0,8.0,0.0),
          child: Card(
            elevation: 30,
            child: ListTile(
              tileColor: Colors.white,
              leading: CircleAvatar(
                radius:35.0,
                backgroundColor: Colors.black,
                child: Container(
                  child:FittedBox(
                    child: Text(
                        '\u{20B9}'+list[index].amount.toInt().toString(),
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.w900,
                        )
                    ),
                  ),
                  padding: EdgeInsets.all(10),
                ),
              ),
              title: Text(
                  list[index].name,
                  style:TextStyle(
                    fontSize: 25.0,
                    color: Colors.blueGrey,
                    fontWeight: FontWeight.w700,
                  )
              ),
              subtitle: Text(
                  DateFormat.yMMMd().format(list[index].date),
                  style:TextStyle(
                    fontSize: 20.0,
                    color:Colors.grey,
                  )
              ),
              trailing: IconButton(
                icon: Icon(
                  Icons.delete,
                  size:35.0,
                ),
                onPressed: ()=>del(list[index].id),
              ),
            ),
          ),
          );
      });
  }
}
