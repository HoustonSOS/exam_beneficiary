import 'dart:ui';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

import '../model/contact.dart';
import '../model/contact_list.dart';

class RecipientsPage extends StatefulWidget {
  const RecipientsPage({Key? key}) : super(key: key);

  static const String recipients_name = "/recipients";

  @override
  State<RecipientsPage> createState() => _RecipientsPageState();
}

class _RecipientsPageState extends State<RecipientsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.transparent,
        leadingWidth: 40,
        foregroundColor: Colors.black,
        centerTitle: false,
        title: const Padding(
          padding: EdgeInsets.only(left: 15.0),
          child: Text("Add Recipients", style: TextStyle(fontWeight: FontWeight.bold),),
        ),
        leading: Padding(
          padding: const EdgeInsets.only(left: 15.0),
          child: IconButton(icon: const Icon(Icons.arrow_back_ios), onPressed: Navigator.of(context).pop, splashRadius: 0.1),
        ),
      ),
      body: const Body(),
    );
  }
}

class Body extends StatefulWidget {
  const Body({Key? key}) : super(key: key);

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {

  final nameController = TextEditingController(text: "My Love");

  final relationshipController = TextEditingController(text: "Sister");

  final numberController = TextEditingController(text: "+82");

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(30.0),
                child: Stack(
                    alignment: Alignment.bottomRight,
                    children:[
                      Container(
                        width: 100,
                        height: 100,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            gradient: LinearGradient(
                              begin: Alignment.bottomCenter,
                              end: Alignment.topCenter,
                              stops: [
                                0.1,
                                0.8
                              ],
                              colors: [
                                Colors.grey.withOpacity(0.4),
                                Colors.transparent,
                              ],

                            )
                        ),
                      ),
                      Container(
                        height: 30,
                        width: 30,
                        child: Icon(Icons.camera_alt, color: Colors.white, size: 15,),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.grey,
                        ),
                      )
                    ]
                ),
              ),
              _buildTextField(nameController, "Name"),
              const SizedBox(height: 10,),
              _buildTextField(relationshipController, "Relationship"),
              const SizedBox(height: 10,),
              _buildTextField(numberController, "Phone Number"),
            ],
          ),
          Padding(
            padding: EdgeInsets.all(50),
            child: GestureDetector(
              onTap: _onAdd,
              child: Container(
                alignment: Alignment.center,
                width: MediaQuery.of(context).size.width * 0.8,
                height: MediaQuery.of(context).size.height * 0.06,
                child: const Text("Save", style: TextStyle(color: Colors.white, fontSize: 20),),
                decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.all(Radius.circular(20.0))
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  void _onAdd(){
    var name = nameController.text.trim();
    var number = numberController.text.trim();
    var provider = context.read<ContactList>();

    provider.add(Contact(namesurname: name, number: number, id: "4"));

    Navigator.of(context).pop();
  }
  Widget _buildTextField(TextEditingController controller, String hint){
    bool fisrtTry = true;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: TextFormField(
        onTap: (){
          if(fisrtTry){
            fisrtTry = false;
            if(controller.text == "My Love"
                || controller.text == "Sister"
                || controller.text == "+82"){
              controller.text = "";
            }
          }

        },
        controller: controller,
        decoration: InputDecoration(
          labelText: hint,
          border: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(15.0))
          ),
        ),
      ),
    );
  }
}

