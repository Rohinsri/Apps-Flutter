import 'package:fifth/models/transaction.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'chart_bar.dart';
class Chart extends StatelessWidget {
  List<Transaction> trans;
  Chart(this.trans);
  List<Map<String,Object>> get gt{
      return List.generate(7,(index){
        final weekDay=DateTime.now().subtract(Duration(days: index));
        var total=0.0;
        var t=0.0;
        for(var i=0;i<trans.length;i++){
          t+=trans[i].amount;
          if(trans[i].date.day==weekDay.day&&trans[i].date.month==weekDay.month&&trans[i].date.year==weekDay.year){
            total+=trans[i].amount;
          }
        }
        var p=(total==0.0&&t==0.0)?0.0:total/t;
        return {'day': DateFormat.E().format(weekDay).substring(0,1),'amount': total,'percent':p};
      }).reversed.toList();
  }
  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.black,
      elevation: 50,
      child:Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: gt.map((data){
          return Flexible(
            fit: FlexFit.loose,
              child: Bar(day: data['day'],percent: data['percent'],amount:data['amount']),
          );
        }).toList(),
      ),
    );
  }
}
