// ignore_for_file: non_constant_identifier_names

class AddressModel {
  bool? status;
  Data? data;

  AddressModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }
}

class Data {
  int? current_page;
  List<AddressItem> addressItem = [];
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
        addressItem.add(AddressItem.fromJson(v));
      });
    } else {
      addressItem = [];
    }
  }
}

class AddressItem {
  dynamic id;
  String? name;
  String? city;
  String? region;
  String? details;
  String? notes;
  dynamic latitude;
  dynamic longitude;

  AddressItem.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    city = json['city'];
    region = json['region'];
    details = json['details'];
    notes = json['notes'];
    latitude = json['latitude'];
    longitude = json['longitude'];
  }
}
