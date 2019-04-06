import 'package:assign_02/database/DBhelper.dart';
import 'package:assign_02/model/Contact.dart';
import 'complete_screen.dart';
import 'package:flutter/material.dart';
import 'todo_screen.dart';

Future<List<Contact>> getContactsFormDBAll() async {
  var dbHelper = DBHelper();
  Future<List<Contact>> contacts = dbHelper.getContactsAll();
  return contacts;
}

class MainScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return MainScreenState();
  }
}

class MainScreenState extends State<MainScreen> {
  int _currentIndex = 0;
  final List<Widget> _children = [
    MyTodoList(),
    MyCompleteList(),
  ];

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
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

