class UpdateDeleteCartModel {
  bool? status;
  String? message;
  Data? data;

  UpdateDeleteCartModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message']??'';
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }
}

class Data {
  dynamic id;
  int? quantity;
  Product? product;
  dynamic subTotal;
  dynamic total;

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    quantity = json['quantity'];
    product =
        json['product'] != null ? Product.fromJson(json['product']) : null;
      subTotal = json['sub_total'];
    total = json['total'];

  }
}

class Product {
  dynamic id;
  dynamic price;
  dynamic oldPrice;
  int? discount;
  String? image;

  Product.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    price = json['price'];
    oldPrice = json['old_price'];
    discount = json['discount'];
    image = json['image'];
   
  }
}
