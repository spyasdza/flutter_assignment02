import 'package:flutter/material.dart';
import 'placeholder.dart';

class MainScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return MainScreenState();
  }
}

class MainScreenState extends State<MainScreen> {
  int _currentIndex = 0;
  final List<Widget> _children = [
    PlaceholderWidget(Colors.white),
    PlaceholderWidget(Colors.deepOrange),
  ];

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text('Todo'),
        actions: <Widget>[
          _currentIndex == 0
              ? new FlatButton(
                  child: new IconTheme(
                    data: new IconThemeData(color: Colors.white),
                    child: new Icon(Icons.add),
                  ),
                  onPressed: () {},
                )
              : new FlatButton(
                  child: new IconTheme(
                    data: new IconThemeData(color: Colors.white),
                    child: new Icon(Icons.delete),
                  ),
                  onPressed: () {},
                ),
        ],
      ),
      body: _children[_currentIndex], // new
      bottomNavigationBar: BottomNavigationBar(
        onTap: onTabTapped, // new
        currentIndex: _currentIndex, // new
        items: [
          new BottomNavigationBarItem(
            icon: Icon(Icons.list),
            title: Text('Task'),
          ),
          new BottomNavigationBarItem(
            icon: Icon(Icons.done_all),
            title: Text('Completed'),
          ),
        ],
      ),
    );
  }

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }
}
