// ignore_for_file: non_constant_identifier_names

class ContactModel {
  bool? status;
  Data? data;

  ContactModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }
}

class Data {
  int? current_page;
  List<ContactItem> contactItem = [];
  String? first_page_url;
  dynamic from;
  dynamic last_page;
  String? last_page_url;
  String? path;
  int? per_page;
  int? to;
  dynamic total;

  Data.fromJson(Map<String, dynamic> json) {
    total = json['total'];
    current_page = json['current_page'];
    first_page_url = json['first_page_url'];
    from = json['from'];
    last_page = json['last_page'];
    last_page_url = json['last_page_url'];
    path = json['path'];
    per_page = json['per_page'];
    to = json['to'];

    if (json['data'] != null) {
      json['data'].forEach((v) {
        contactItem.add(ContactItem.fromJson(v));
      });
    } else {
      contactItem = [];
    }
  }
}

class ContactItem {
  dynamic id;
  int? type;
  String? value;
  String? image;
 

  ContactItem.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    type = json['type'];
    value = json['value'];
    image = json['image'];
   
  }
}
