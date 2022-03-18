import 'package:hive_flutter/hive_flutter.dart';
import '../model/contact_list.dart';

class HiveService{

  static const String HIVE_BOX = "CONTACTS_BOX";

  static var contact_box = Hive.box(HIVE_BOX);

  static void store(String contacts){
    contact_box.put("contacts", contacts);
  }

  static String load(){
    return contact_box.get("contacts") ?? "";
  }
}