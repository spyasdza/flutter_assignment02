import 'package:assign_02/database/DBhelper.dart';
import 'package:assign_02/model/Contact.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class AddScreen extends StatefulWidget {
//  Color color;

//  PlaceholderWidget(this.color);

 @override
  State<StatefulWidget> createState() {
    return AddScreenState();
  }
}

class AddScreenState extends State<AddScreen>{
  Contact contact = new Contact();
  String name;

  final scaffoldKey = new GlobalKey<ScaffoldState>();
  final formKey = new GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("New Subject"),
      ),
      body: Padding(
      padding: const EdgeInsets.all(16.0),
      child: Form(
        key: formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            TextFormField(
              keyboardType: TextInputType.text,
              decoration: InputDecoration(labelText: "Subject"),
              validator: (val) => val.length == 0 ? "Please fill subject": null,
              onSaved: (val) => this.name = val,
            ),
            new Container(
              // margin: const EdgeInsets.only(top: 10.0),
              child: RaisedButton(
                onPressed: submitContact,
                child: Text('Save'),
              ),
            )
          ],
        ),
      ),
    ),
    );
  }

  void submitContact(){
    if(this.formKey.currentState.validate()){
      formKey.currentState.save();
    }
    else{
      return null;
    }

    var contact = Contact();
    contact.name = name;
    contact.done = 0;

    var dbHelper = DBHelper();
    dbHelper.addNewContact(contact);
    Fluttertoast.showToast(msg: 'Subject was saved', toastLength: Toast.LENGTH_SHORT,);
  }

  // void startContactList(){
  //   Navigator.push(context, new MaterialPageRoute(builder: (context) => new MyContactList()));
  // }
  

}