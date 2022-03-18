import 'dart:convert';

class Contact{

  const Contact({required this.id, required this.number, required this.namesurname});

  final String id;
  final String namesurname;
  final String number;

  factory Contact.fromJSON(Map<String, dynamic> json){
    return Contact(
      id: json["id"],
      namesurname: json["namesurname"],
      number: json["number"],
    );
  }

  Map<String, dynamic> toJSON(){
    var b =  {
      "number" : number,
      "namesurname" : namesurname,
      "id" : id,
    };
    return b;
  }

  @override
  bool operator ==(Object other) {
    if(other is Contact &&
        other.id == id &&
        other.number == number &&
        other.namesurname == namesurname
    ) return true;

    return false;
  }
  @override
  String toString() {
    return "$namesurname $number";
  }

  @override
  // TODO: implement hashCode
  int get hashCode => int.parse(id);

}