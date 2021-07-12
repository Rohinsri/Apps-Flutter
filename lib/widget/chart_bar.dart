import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
class Bar extends StatelessWidget {
  final String day;
  final double percent;
  final double amount;
  Bar({this.day,this.percent,this.amount});
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (ctx,constraints){
        return Padding(
          padding: const EdgeInsets.fromLTRB(12.0,15.0,12.0,15.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              Container(
                  height: constraints.maxHeight*0.075,
                  child: FittedBox(
                    child: Text('\u{20B9}'+amount.toInt().toString(),
                        style:TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 10,)
                    ),
                  )
              ),
              SizedBox(height: constraints.maxHeight*0.05,),
              Container(
                  height:constraints.maxHeight*0.6,
                  width:30,
                  child:Stack(
                    children: <Widget>[
                      Container(
                        decoration: BoxDecoration(
                          color:Colors.grey[200],
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                            color:Colors.grey[400],
                            width:1,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: FractionallySizedBox(
                          heightFactor: percent,
                          child: Container(
                            decoration: BoxDecoration(
                                color:Colors.lightBlueAccent,
                                borderRadius: BorderRadius.circular(20),
                                border: Border.all(color: Colors.grey[400],width:1)
                            ),
                          ),
                        ),
                      ),
                    ],
                  )
              ),
              SizedBox(height: constraints.maxHeight*0.05,),
              Container(
                height: constraints.maxHeight*0.1,
                child: Text(day,
                    style:TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    )
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
