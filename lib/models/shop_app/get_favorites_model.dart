// ignore_for_file: avoid_print, unnecessary_null_in_if_null_operators

class GetFavModel {
  late bool status;
  Data? data;

  GetFavModel.fromJson(Map<String, dynamic> json) {
    try {
      status = json['status'];
      data = json['data'] != null ? Data.fromJson(json['data']):null ;
    } catch (e) {
      print('get fav model ${e.toString()}');
    }
  }
}

class Data {
  late int currentPage;
   List<FavoritesData> data = [];
  String? firstPageUrl;
  late int from;
  late int lastPage;
  String? lastPageUrl;
  String? path;
  late int perPage;
  late int to;
  late int total;

  Data.fromJson(Map<String, dynamic> json) {
    try {
       currentPage = json['current_page'];
    if (json['data'] != null ) {
      json['data'].forEach((v) {
        data.add(FavoritesData.fromJson(v));
      });
    }else {
      data = [];
    }
    firstPageUrl = json['first_page_url'];
    from = json['from'];
    lastPage = json['last_page'];
    lastPageUrl = json['last_page_url'];
    path = json['path'];
    perPage = json['per_page'];
    to = json['to'];
    total = json['total'];
    } catch (e) {
            print('get fav model ${e.toString()}');

    }
   
  }
}

class FavoritesData {
   int? id;
  Product? product;

  FavoritesData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    product =
        json['product'] != null ? Product.fromJson(json['product']) : null;
    print(json['product'].runtimeType); // Check the type of 'product' data
  }
}

class Product {
  late int id;
  late dynamic price;
  late dynamic oldPrice;
  late int discount;
  String? image;
  String? name;
  String? description;

  Product.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    price = json['price'];
    oldPrice = json['old_price'];
    discount = json['discount'];
    image = json['image'];
    name = json['name'];
    description = json['description'];
  }
}
