import 'dart:async';
import 'dart:io' as io;
import 'package:assign_02/model/Contact.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DBHelper {
  //Definal
  final String TABLE_NAME = "TodoListSpy";
  static Database db_instance;

  Future<Database> get db async {
    if (db_instance == null) 
      db_instance = await initDB();
    return db_instance;
  }

  initDB() async {
    io.Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, "eiei.db");
    var db = await openDatabase(path, version: 1, onCreate: onCreateFunc);
    return db;
  }

  void onCreateFunc(Database db, int version) async {
    //Create Table
    await db.execute('CREATE TABLE $TABLE_NAME(id INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT, done INTEGER);');
  }

  /* 
  CRUD Function
  */

  //Get Contract

  Future<List<Contact>> getContacts() async{
    var db_connection = await db;
    List<Map> list = await db_connection.rawQuery("SELECT * FROM $TABLE_NAME WHERE done = 0");
    List<Contact> contacts = new List();
    for (int i = 0;i < list.length; i++){
      Contact contact = new Contact();
      contact.id = list[i]['id'];
      contact.name = list[i]['name'];
      contact.done = list[i]['done'];

      contacts.add(contact);
    }
    return contacts;
  }

  Future<List<Contact>> getContactsC() async{
    var db_connection = await db;
    List<Map> list = await db_connection.rawQuery("SELECT * FROM $TABLE_NAME WHERE done = 1");
    List<Contact> contacts = new List();
    for (int i = 0;i < list.length; i++){
      Contact contact = new Contact();
      contact.id = list[i]['id'];
      contact.name = list[i]['name'];
      contact.done = list[i]['done'];

      contacts.add(contact);
    }
    return contacts;
  }

  //Add New Contact
  void addNewContact (Contact contact) async {
    var db_connection = await db;
    String query = 'INSERT INTO $TABLE_NAME (name, done) VALUES(\'${contact.name}\', \'${contact.done}\')';
    await db_connection.transaction((transaction) async{
      return await transaction.rawInsert(query);
    });
  }

  //Update
  void updateContact (Contact contact) async {
    var db_connection = await db;
    String query = 'UPDATE $TABLE_NAME SET done = ${contact.done} WHERE id=${contact.id}';
    await db_connection.transaction((transaction) async{
      return await transaction.rawQuery(query);
    });
  }

  //Delete
  void deleteContact () async {
    var db_connection = await db;
    String query = 'DELETE FROM $TABLE_NAME WHERE done=1';
    await db_connection.transaction((transaction) async{
      return await transaction.rawQuery(query);
    });
  }
}
