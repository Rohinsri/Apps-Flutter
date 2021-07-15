import 'package:flutter/material.dart';
import 'package:seventh/widgets/summary_cart.dart';
import 'package:seventh/widgets/total_amount.dart';
class CartScreen extends StatelessWidget {
  static const routeName='/carScreen';
  @override
  Widget build(BuildContext context) {
      return Scaffold(
        appBar: AppBar(
          title: Text('Your Cart!'),
        ),
        body:SingleChildScrollView(
          child: Column(
            children: <Widget>[
              TotalAmount(),
              SummaryCart(),
            ],
          ),
        )
      );
  }
}