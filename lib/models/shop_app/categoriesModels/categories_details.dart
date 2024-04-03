// ignore_for_file: avoid_print, non_constant_identifier_names

class CatDetailsModel {
  late bool status;
  Data? data;

  CatDetailsModel.fromJson(Map<String, dynamic> json) {
    try {
      status = json['status'];
      data = json['data'] != null ? Data.fromJson(json['data']) : null;
    } catch (e) {
      print(' search model ${e.toString()}');
    }
  }
}

class Data {
  late int currentPage;
  late List<Product> data = [];
  String? firstPageUrl;
  late int from;
  late int lastPage;
  String? lastPageUrl;
  String? path;
  late int perPage;
  late int to;
  late int total;

  Data.fromJson(Map<String, dynamic> json) {
    currentPage = json['current_page'];
    if (json['data'] != null) {
      json['data'].forEach((v) {
        data.add(Product.fromJson(v));
      });
    }
    firstPageUrl = json['first_page_url'];
    from = json['from'];
    lastPage = json['last_page'];
    lastPageUrl = json['last_page_url'];
    path = json['path'];
    perPage = json['per_page'];
    to = json['to'];
    total = json['total'];
  }
}

class Product {
  late int id;
  late dynamic price;
  dynamic oldPrice;
  dynamic discount;
  String? image;
  String? name;
  String? description;
  List<String> images = [];
  late bool in_favorites;
  late bool in_cart;

  Product.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    price = json['price'];
    oldPrice = json['old_price'];
    discount = json['discount'];
    image = json['image'];
    name = json['name'];
    description = json['description'];
    in_favorites = json['in_favorites'];
    in_cart = json['in_cart'];
    json['images'].forEach((e) {
      images.add(e);
    });
  }
}
