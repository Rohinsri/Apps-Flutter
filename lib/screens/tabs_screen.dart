import 'package:flutter/material.dart';
import 'package:sixth/models/meals.dart';
import 'package:sixth/screens/category_screen.dart';
import 'package:sixth/screens/favourites_screen.dart';
import 'package:sixth/widgets/main_drawer.dart';
class TabScreen extends StatefulWidget {
  List<Meal> _favourites;
  TabScreen(this._favourites);
  @override
  _TabScreenState createState() => _TabScreenState();
}

class _TabScreenState extends State<TabScreen> {
  List<Map<String,Object>> _pages;
  int select = 0;
  void _selectedPage(int index){
    setState(() {
      select = index;
    });
  }
  @override
  void initState() {
    _pages=[{
      'title':'Categories',
      'page':CategoryScreen(),
    },{
      'title':'Favourites',
      'page':Favourites(widget._favourites),
    } ];
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_pages[select]['title'],
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 25,
          ),
        ),
      ),
      drawer: MainDrawer(),
      body:_pages[select]['page'],
      bottomNavigationBar: BottomNavigationBar(
        onTap: _selectedPage,
        backgroundColor: Theme.of(context).primaryColor,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.grey[400],
        currentIndex: select,
        items: [
          BottomNavigationBarItem(
              icon: Icon(Icons.category),
            label: 'Categories',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.star),
            label: 'Favourites',
          ),
        ],
      ),
    );
  }
}
