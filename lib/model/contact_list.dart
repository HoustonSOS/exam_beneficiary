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
      notifyListeners();
    }
  }

  Future<void> setFromAPI() async {
    var response = await HttpService.GET();
    print("From set Api: $response");

    HiveService.store(response!);
    contacts = decode(response);

    notifyListeners();
  }
  void add(Contact contact){
    contacts.add(contact);
    _updateServices();
    notifyListeners();
  }

  void delete(Contact contact){
    if(contacts.contains(contact)){
      contacts.remove(contact);
      notifyListeners();
      _updateServices();
    }
  }

  void _updateServices(){
    var encoded = encode(contacts);

    HttpService.POST(encoded);
    HiveService.store(encoded);
  }
  static String encode(List<Contact> list){
    var string =  list.map((contact) => contact.toJSON()).toList();
    var d = jsonEncode(string);
    print("From encode: $d");
    return d;
  }

  static List<Contact> decode(String json){
    List<Contact> list = [];

    var decoded = jsonDecode(json);

    print("From decode: $decoded");

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