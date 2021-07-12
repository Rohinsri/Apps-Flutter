import 'package:flutter/material.dart';
import 'package:sixth/widgets/main_drawer.dart';
class FilterScreen extends StatefulWidget {
  final Function setfilter;
  Map<String,bool> currentFilters;
  FilterScreen({this.currentFilters,this.setfilter});
  @override
  _FilterScreenState createState() => _FilterScreenState();
}

class _FilterScreenState extends State<FilterScreen> {
  Map<String,bool> _filter={
    'gluten':false,
    'lactose':false,
    'vegan':false,
    'veg':false,
  };
  @override
  void initState() {
    _filter=widget.currentFilters;
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Filters',
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 25,
          ),
        ),
      ),
      drawer: MainDrawer(),
      body:Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Text('Adjust Your Choices!',
              style:TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.w600,
              )
            ),
          ),
          SwitchListTile(
            title: Text('Gluten Free',style: TextStyle(fontSize: 20),),
            subtitle: Text('Include Only Gluten Free Meals'),
            value: _filter['gluten'],
            onChanged: (newValue){
              setState(() {
                _filter['gluten']=newValue;
              });
            },
          ),
          SwitchListTile(
            title: Text('Lactose Free',style: TextStyle(fontSize: 20),),
            subtitle: Text('Include Only Lactose Free Meals'),
            value: _filter['lactose'],
            onChanged: (newValue){
              setState(() {
                _filter['lactose']=newValue;
              });
            },
          ),
          SwitchListTile(
            title: Text('Vegan',style: TextStyle(fontSize: 20),),
            subtitle: Text('Include Only Vegan Meals'),
            value: _filter['vegan'],
            onChanged: (newValue){
              setState(() {
                _filter['vegan']=newValue;
              });
            },
          ),
          SwitchListTile(
            title: Text('Vegetarian',style: TextStyle(fontSize: 20),),
            subtitle: Text('Include Only Vegetarian Meals'),
            value: _filter['veg'],
            onChanged: (newValue){
              setState(() {
                _filter['veg']=newValue;
              });
            },
          ),
          SizedBox(height: 40,),
          ElevatedButton(
              onPressed: ()=>widget.setfilter(_filter),
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Text('Save Filter',
                    style:TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w500
                    )
                ),
              ),
          )
        ],
      ),
    );
  }
}
