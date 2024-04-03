
// ignore_for_file: unnecessary_null_in_if_null_operators

class ShopLoginModel {
     bool? status;
     String? message  ;
     UserData? data;

   
//named constructor
     ShopLoginModel.fromJson(Map<String,dynamic> json){
    status = json['status'];
    message = json['message']??'';
    data = json['data'] != null?UserData.fromJson(json['data']):null ;
  }

  
}

class UserData {
  late   dynamic id;
  late  String name;
  late  String email;
  late  String phone;
    String? image;
    dynamic points;
    dynamic credit;
  late  String token;

   

     UserData.fromJson(Map<String, dynamic> json){
        id = json["id"];
        name= json["name"];
        email= json["email"];
        phone= json["phone"];
        image=json["image"];
        points= json["points"];
        credit= json["credit"];
        token= json["token"];
}

    
}
