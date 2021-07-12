import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
class NewT extends StatefulWidget {
  final Function _addT;
  NewT(this._addT);
  @override
  _NewTState createState() => _NewTState();
}
class _NewTState extends State<NewT> {
  final title = TextEditingController();
  final amount = TextEditingController();
  DateTime date;
  void submit(){
    if(title.text.isNotEmpty && double.parse(amount.text)>0 && date!=null){
      widget._addT(title.text, double.parse(amount.text),date);
    }
    Navigator.of(context).pop();
  }
  void selectDate(){
    showDatePicker(
      context: context,
      firstDate: DateTime(2000),
      lastDate: DateTime.now(),
      initialDate: DateTime.now(),
    ).then((d){
      setState(() {
        date=d;
      });
    });
  }
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 40,
      shadowColor: Colors.indigo,
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children:<Widget>[
            TextField(
              controller: title,
              onSubmitted: (_)=>submit(),
              decoration: InputDecoration(
                labelText: 'Enter Title',
                labelStyle: TextStyle(
                  color: Colors.grey,
                  fontSize: 20.0,
                ),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(15.0)),
                    borderSide: BorderSide(color: Colors.grey)),
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(15.0)),
                    borderSide: BorderSide(color: Colors.lightBlueAccent)),
              ),
            ),
            SizedBox(height: 15.0,),
            TextField(
              controller: amount,
              onSubmitted: (_)=>submit(),
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Enter Amount',
                labelStyle: TextStyle(
                  color: Colors.grey,
                  fontSize: 20.0,
                ),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(15.0)),
                    borderSide: BorderSide(color: Colors.grey)),
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(15.0)),
                    borderSide: BorderSide(color: Colors.lightBlueAccent)),
              ),
            ),
            SizedBox(height: 30.0,),
            Row(
              children: <Widget>[
                Expanded(child: Text(date==null?'No Date Chosen':'Date Picked: '+DateFormat.yMd().format(date),
                    style: TextStyle(color: Colors.grey,fontSize: 18))),
                FlatButton(onPressed: selectDate,
                    splashColor: Colors.lightBlueAccent,
                    child: Text('Choose Date',
                        style:TextStyle(color: Colors.lightBlueAccent,fontSize: 20),
                  )
                )
              ],
            ),
            SizedBox(height: 30.0,),
            FlatButton(
              color: Colors.black54,
              onPressed: submit,
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Text(
                  'Add Transaction',
                  style:TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                  )
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}