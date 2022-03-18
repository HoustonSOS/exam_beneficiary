import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:untitled/service/hive.dart';
import 'package:untitled/service/http.dart';

import 'contact.dart';

class ContactList with ChangeNotifier{
  List<Contact> contacts = [];


  void setFromDB(){
    var string = HiveService.load();
    if(string != ""){
      contacts = decode(string);
    }
    notifyListeners();
  }

  void add(Contact contact){
    contacts.add(contact);
    HiveService.store(encode(contacts));
    notifyListeners();
  }

  void delete(Contact contact){
    if(contacts.contains(contact)){
      contacts.remove(contact);
      HiveService.store(encode(contacts));
    }
    notifyListeners();
  }

  static String encode(List<Contact> list){
    var string =  list.map((contact) => contact.toJSON()).toList();
    var d = jsonEncode(string);
    print("From encode: $d");
    return d;
  }

  static List<Contact> decode(String json){
    List<Contact> list = [];

    print(json);
    var decoded = jsonDecode(json);
    
    print(decoded.runtimeType);
    for(var contact in decoded){
      list.add(Contact.fromJSON(contact));
    }

    return list;
  }

  @override
  String toString() {
    return contacts[0].namesurname;
  }
}