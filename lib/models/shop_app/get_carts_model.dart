
// ignore_for_file: non_constant_identifier_names

class GetCartsModel {
  bool? status;
  Data? data;

  GetCartsModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }
}

class Data {
  List<CartItem> cart_items = [];
  dynamic sub_total;
  dynamic total;

  Data.fromJson(Map<String, dynamic> json) {
    total = json['total'];
    sub_total = json['sub_total'];
    if (json['cart_items'] != null) {
      json['cart_items'].forEach((v) {
        cart_items.add(CartItem.fromJson(v));
      });
    } else {
      cart_items = [];
    }
  }
}

class CartItem {
  dynamic id;
  int? quantity;
  Product? product;

  CartItem.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    quantity = json['quantity'];

    product =
        json['product'] != null ? Product.fromJson(json['product']) : null;
  }
}

class Product {
  dynamic id;
  dynamic price;
  dynamic oldPrice;
  int? discount;
  String? image;
  String? name;
  String? description;
  List<String> images =[];
  bool? in_favorites;
  bool? in_cart;
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

    json['images'].forEach((element){
    images.add(element);
   });
  }
}
