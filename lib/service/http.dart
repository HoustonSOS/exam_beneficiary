import 'dart:convert';

import '../model/contact.dart';
import 'package:http/http.dart' as http;

class HttpService{

  static const String API = "6234569cc47cffbb870c45ee.mockapi.io";
  static const String PATH_GET = "/contact";

  static Future<String?> GET() async {
    var uri = Uri.https(API, PATH_GET);

    var response = await http.get(uri);

    if(response.statusCode == 200){
      print("GET function: ${response.body}");
      return response.body;
    }else{
      print(response.statusCode);
      return null;
    }
  }

  static Future<http.Response?> POST(String contacts) async {
    var uri = Uri.https(API, PATH_GET);

    print("POST function: $contacts");

    var response = await http.post(uri, body: contacts);

    if(response.statusCode == 201){
      print(response.statusCode);
      return response;
    }else{
      print(response.statusCode);
      return null;
    }
  }
}