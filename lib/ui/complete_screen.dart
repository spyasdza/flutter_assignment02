import 'dart:async';

import 'package:assign_02/database/DBhelper.dart';
import 'package:assign_02/model/Contact.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

var dbHelper = DBHelper();

Future<List<Contact>> getContactsFormDBC() async {
  Future<List<Contact>> contacts = dbHelper.getContactsC();
  return contacts;
}

// Future<List<Contact>> getContactsFormDBCasList() async {
//   var dbHelper = DBHelper();
//   Future<List<Contact>> contacts = dbHelper.getContactsC();
//   return contacts;
// }

class MyCompleteList extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new MyCompleteListState();
}

class MyCompleteListState extends State<MyCompleteList> {
  final controller_name = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    // Create con
    return Scaffold(
      appBar: AppBar(
        title: Text('Todo'),
        actions: <Widget>[
              new FlatButton(
                  child: new IconTheme(
                    data: new IconThemeData(color: Colors.white),
                    child: new Icon(Icons.delete),
                  ),
                  //delete
                  onPressed: () {
                              dbHelper.deleteContact();
                    // var dbHelper = DBHelper();
                    // Future<List<Contact>> contacts = dbHelper.getContactsC();
                    // print(contacts);
                    // ;
                    // print(contacts);
                    // FutureBuilder<List<Contact>>(
                    //   future: getContactsFormDBC(),
                    //   builder: (context, snapshot){
                    //     for (int i=0; i<snapshot.data.length; i++){
                    //       print("This is snapshot data -> ${snapshot.data}");
                    //       dbHelper.deleteContact(snapshot.data[i]);
                    //     }
                    //   }
                    // );

                    Fluttertoast.showToast(msg: 'Complete list was delete', toastLength: Toast.LENGTH_SHORT,);
                    setState(() {
                      getContactsFormDBC();
                    });
                  },
                )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Container(
          padding: EdgeInsets.all(16.0),
          child: FutureBuilder<List<Contact>>(
            future: getContactsFormDBC(),
            builder: (context, snapshot) {
              if (snapshot.data != null) {
                if (snapshot.data.length > 0) {
                  return ListView.builder(
                    itemCount: snapshot.data.length,
                    itemBuilder: (context, index) {
                      return new Row(
                        children: <Widget>[
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Container(
                                  padding: const EdgeInsets.only(bottom: 8.0),
                                  child: Text(snapshot.data[index].title,
                                      style:
                                          TextStyle(fontWeight: FontWeight.bold)),
                                ),
                              ],
                            ),
                          ),

                          //update/del button
                          GestureDetector(
                            onTap: () {
                              // var dbHelper = DBHelper();
                              Contact contact = new Contact();
                              contact.id = snapshot.data[index].id;
                              contact.done = 0;
                              dbHelper.updateContact(contact);
                              Fluttertoast.showToast(msg: 'Subject was uncheck', toastLength: Toast.LENGTH_SHORT,);
                              setState(() {
                               getContactsFormDBC();
                              });
                            },
                            child: Icon(
                              Icons.check_box,
                              color: Colors.red,
                            ),
                          ),
                        ],
                      );
                    },
                  );
                }
                else{
                return new Container(
                alignment: AlignmentDirectional.center,
                child: Text("No data found.."),
                );
                }
              }

              //show text while snap shot not getting data
              else{
                return new Container(
                alignment: AlignmentDirectional.center,
                child: Text("No data found.."),
                );
              }
            },
          ),
        ),
      ),
    );
  }

  @override
  void initState(){
    super.initState();
  }
}
