// ignore_for_file: avoid_print, unnecessary_null_in_if_null_operators

class GetProductDetailModel {
   bool? status;
  Product? data;

  GetProductDetailModel.fromJson(Map<String, dynamic> json) {
    try {
      status = json['status'];
      data = json['data'] != null ? Product.fromJson(json['data']):null ;
    } catch (e) {
      print('get product detail model ${e.toString()}');
    }
  }
}





class Product {
   int? id;
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
