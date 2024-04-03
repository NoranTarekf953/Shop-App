// ignore_for_file: file_names

class NewAddressModel {
  bool? status;
  String? message;
  NewAddressItem? data;

  NewAddressModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? NewAddressItem.fromJson(json['data']) : null;
  }
}



class NewAddressItem {
  dynamic id;
  String? name;
  String? city;
  String? region;
  String? details;
  String? notes;
  dynamic latitude;
  dynamic longitude;

  NewAddressItem.fromJson(Map<String, dynamic> json) {
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
